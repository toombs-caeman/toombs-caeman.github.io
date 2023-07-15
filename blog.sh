#!/bin/bash
shopt -s globstar

n=$'\n' # newlines are hard to get right

# perl style named capture groups with a cache
declare -A _P _E
M() { # <text> <pattern> [<match var=M>]
    unset -v "${3:-M}"
    set -- "$1" "$2" '\(\?P<([^>]*)>' "${3:-M}=(\"\${BASH_REMATCH[@]}\")"
    if [[ -n "${_P["$2"]}" ]]; then
        set -- "$1" "${_P["$2"]}" '' "${_E["$2"]}"
    else
        local original="$2"
        while [[ "$2" =~ $3 ]] ; do
            : "${2%%"${BASH_REMATCH[0]}"*}"; : "${_//'\('/}"; : "${_//[^(]/}"
            set -- "$1" "${2//"${BASH_REMATCH[0]}"/(}" "$3" "$4 ${BASH_REMATCH[1]}=\"\${BASH_REMATCH[$((${#_} + 1))]}\""
        done
        _P["$original"]="$2"
        _E["$original"]="$4"
    fi
    [[ "$1" =~ $2 ]] || return 1
    eval "$4"
}

fnames=() groups=0 re=''
register() { # <function> <when regex>
    # save the name of the function as a function of its group number
    fnames[$groups]="$1"
    # make sure the regex has at least one group
    set -- "$1" "($2)"
    # count number of groups in regex to increment the total group number
    : "${2//'\('/}"; : "${_//[^(]/}"
    groups=$((groups + ${#_}))
    # append the regex
    [[ -n "$re" ]] && re+="|$2" || re="$2"
}

file() {
    local stack=() raw="$(echo;cat "$1";echo)"
    M "$raw" "$n# (?P<title>[^$n]*)"
    while M "$raw" "$re"; do
        escape "${raw%%"${M[0]}"*}"
        raw="${raw#*"${M[0]}"}"
        M=("${M[@]:1}")
        : "${M[*]}"; : "${_%%[^ ]*}" # index of first non-empty group
        ${fnames[${#_}]} # call function
    done
    final "$raw"
    eof "$2"
}
eof() { # <output>
    local x t
    local content='' # this must be a separate function for content to pass down
    while (( ${#stack[@]} )); do
        # pop x and t off the stack
        x="${stack[-1]}"
        unset -v stack[-1]
        t="${stack[-1]}"
        unset -v stack[-1]
        case "$t" in
            layout)
                local inner
                file "$x" inner
                content="$inner"
                ;;
            final) content="$x$content" ;;
            *)
                # TODO error state?
                printf 'ERROR: unclosed tag: %s(%q)\n' "$t" "$x" >&2
            ;;
        esac
    done
    # strip leading newlines
    M "$content" "^$n*(?P<content>.*)$"
    printf ${1:+-v} $1 %s "$content"
}

final() { stack+=(final "$1"); }
escape() {
    local s="${*//&/&amp\;}"; s="${s//</&lt\;}"; s="${s//>/&gt\;}";
    final "${s//"\""/&quot\;}";
}

register em '\*'
em=0
em() { (( em )) && final '</em>' || final '<em>'; em=$((em^1)); }

. .emoji.sh
register emoji "(?P<Remoji>:[a-z_]+:)"
emoji() { final "${emoji[$Remoji]}"; }

register b '\*\*'
b=0
b() { (( b )) && final '</b>' || final '<b>'; b=$((b^1)); }

# strikethrough
register del '~~'
del=0
del() { (( del )) && final '</del>' || final '<del>'; del=$((del^1)); }

register sup '\^\^'
sup=0
sup() { (( sup )) && final '</sup>' || final '<sup>'; sup=$((sup^1)); }

register supsub '\^\^__'
supsub=0
supsub() {
    # look back to find <sup>
    local i
    for ((i=${#stack[@]}; i>0; i--)); do
        if [[ "${stack[$i]}" = '<sup>' ]]; then
            stack[$i]='<span class="supsub"><sup>'
            sup; sub
            supsub=1
            break
        fi
    done
}

register sub '__'
sub=0
sub() {
    if ((sub)); then
        final '</sub>'
        ((supsub)) && final '</span>'
        supsub=0
    else
        final '<sub>'
    fi
    sub=$((sub^1));
}

#register overline '--'
#overline=0
#overline() { ((overline)) && final '</span>' || final '<span class="overline">'; overline=$((overline^1)); }



register code '`(?P<Rcode>[^`]*)`'
code() { final "<code>"; escape "$Rcode"; final "</code>"; }
register ecode '``(?P<Recode>(`?[^`]+)*)``'
ecode() { final "<code>"; escape "$Recode"; final "</code>"; }

register h "$n(?P<Rh>##*) "
h=0
h() { lf; h="${#Rh}"; final "<h$h>"; }

register hr "$n(----*|====*)$n"
hr() { lf; final '<hr>'; raw="$n$raw"; }

register comment '\{\{\!(}?[^}])*}}'
comment() { :; } # comments produce no output

register content '\{\{\.}}'
content() { final "$content"; }

register layout '\{\{\?(?P<Rlayout>(}?[^}])*)}}'
layout() { stack+=(layout "$Rlayout"); }

register include '\{\{>(?P<Rinclude>(}?[^}])*)}}'
include() { file "$Rinclude" Rinclude; final "$Rinclude"; }

register var '\{\{(?P<Rvar>(}?[^}])*)}}'
var() { eval "escape \"\$$Rvar\""; }
register uvar '\{\{&(?P<Ruvar>(}?[^}])*)}}'
uvar() { eval "final \"\$$Ruvar\""; }

register Rtag '(?P<Rtag><[^<>]*>)'
Rtag() { tag "$Rtag"; }
tag=''
tag() { # <tag>
    local M x raw_attr line
    if ! M "$1" '<(?P<x>[[:alnum:]]+)(?P<raw_attr>([^>]?[^->])*)(?P<line>-?)>';then
        final "$1"; return
    fi
    # if '->', then add close tag at the end of the line
    [[ -n "$line" ]] && tag="</$x>$tag"
    # process attributes
    local a id='' class=() attr=()
    for a in $raw_attr; do # TODO raw word splitting is not good here
        case "$a" in
            \#*) id="${a#'#'}" ;;
            \.*) class+=("${a#.}") ;;
            *) attr+=("$a") ;;
        esac
    done
    final "<$x${id:+ id=\"${id}\"}${class:+ class=\"${class[*]}\"}${attr:+ ${attr[*]}}>"
}

register aimg '(?P<Rimg>!?)\[(?P<desc>[^]]*)]\((?P<url>[^ )]*)(?P<meta>[^)]*)\)(?P<Rwiki>\)?)'
aimg() {
    # let internal .md links be renamed to point to the rendered .html pages
    # so following the link works correctly in vim and in browser
    [[ "$url" = *.md ]] && url="${url%.md}.html"
    if [[ -n "$Rimg" ]]; then
        tag "<img src=\"$url$Rwiki\" alt=\"$desc\" $meta>"
    else
        tag "<a href=\"$url$Rwiki\" $meta>"; final "$desc</a>"
    fi
}

register ulol "$n(?P<Rdepth> *)(?P<Rulol>[*+-]|[0-9]+\\.) "
ulol=''
ulol() {
    lf
    local ptype pdepth
    M "$ulol" '(?P<ptype>[^0-9]*)(?P<pdepth>[0-9]*)$'
    [[ -n "$pdepth" ]] || pdepth='-1'
    [[ "$Rulol" =~ [0-9] ]] && Rulol=ol || Rulol=ul
    Rdepth="${#Rdepth}"
    if (( Rdepth > pdepth )); then final "<$Rulol>$n<li>"; ulol+="$Rulol$Rdepth"; fi
    if (( Rdepth == pdepth)); then final "</li>$n<li>"; fi
    if (( Rdepth < pdepth)); then close_ulol "$Rdepth"; fi
}
close_ulol() { # <new depth>
    while M "$ulol" '(?P<ptype>[^0-9]+)(?P<pdepth>[0-9]+)$'; do
        (( "$1" < pdepth )) || break
        final "</li></$ptype>"
        ulol="${ulol%"${M[0]}"}"
    done
    (( $1 > -1 )) && final '<li>'
}

register codeblock '```(?P<codeblock>(`?`?[^`]+)+)```'
codeblock() {
    final '<pre><code>'
    escape "${codeblock#"$n"}"
    final '</code></pre>'
}

register p "$n$n"
p() { lf; close_ulol -1; final "<p>"; raw="$n$raw"; }

register lf "$n"
lf() {
    # TODO give headers ids equal to their text content 's/ /-/g' for jumps
    ((h))&& tag+="</h$h><p>"
    final "$tag$n"
    h=0 tag=''
}

elapsed() { bc <<< "$(date -u +%s.%N)-${1:-0}"; }

render() {
    clean
    local pid=() p start="$(elapsed)"
    # process all files in parallel
    for filename in **/**.md; do
        {
            file "$filename" > "${filename%.md}.html"
            printf '%.3f %s\n' "$(elapsed "$start")" "${filename%.md}"
        } &
        pid+=("$!")
    done
    # wait for all processes
    for p in "${pid[@]}"; do tail --pid="$p" -f /dev/null; done
    printf '%s %.3f\n' "render" "$(elapsed "$start")"
}
clean() { for filename in **/**.html; do rm "$filename"; done; echo "clean"; }
daemon() {
    render
    local tmp server_pid
    trap 'kill $server_pid;rm $tmp; exit' SIGINT
    tmp="$(mktemp)"
    python -m http.server 5000 & server_pid="$!"
    echo '    http://0.0.0.0:5000'
    while sleep 1; do
        [[ -n "$(find * -type f -newer "$tmp" -print)" ]] && render
        touch "$tmp"
    done
}

# MAIN
case "${1:-${self##*/}}" in
  init)
    # initialize self as pre-commit hook
    ln -fs "$self" .git/hooks/pre-commit ;;
  render) render ;;
  clean) clean ;;
  pre-commit)
    # run as git pre-commit hook
    render || exit $?
    git add *
    ;;
  *) daemon ;;
esac

# TODO  /gitpagestest
# TODO performance testing. inbox.md is around 1400 lines right now and takes 10 seconds
# TODO moustache array, not, and end blocks
# TODO md [table](https://markdown.land/markdown-table) or two column layout
# TODO extract url munging to its own function, autolink urls?
