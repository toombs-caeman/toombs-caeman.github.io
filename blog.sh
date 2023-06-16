#!/bin/bash
shopt -s globstar

n=$'\n' # newlines are hard to get right

# stack operators
pop() { : "$1[-1]"; eval "printf ${2:+-v} $2 %s \"\${$_}\"; [ -n \"\$ZSH_VERSIOn\" ] && $_=() || unset -v $_"; }
peek() { : "$1[-1]"; eval "printf ${2:+-v} $2 %s \"\${$_}\""; }
peek2() { : "$1[-2]"; eval "printf ${2:+-v} $2 %s \"\${$_}\""; }

# perl style named capture groups
M() { # <text> <pattern> [<match var=M>]
    unset -v "${3:-M}"
    set -- "$1" "$2" '\(\?P<([^>]*)>' "${3:-M}=(\"\${BASH_REMATCH[@]}\")"
    while [[ "$2" =~ $3 ]] ; do
        : "${2%%"${BASH_REMATCH[0]}"*}"; : "${_//'\('/}"; : "${_//[^(]/}"
        set -- "$1" "${2//"${BASH_REMATCH[0]}"/(}" "${@:3}" "unset -v ${BASH_REMATCH[1]}" "${BASH_REMATCH[1]}=\"\${BASH_REMATCH[$((${#_} + 1))]}\""
    done
    [[ "$1" =~ $2 ]] || return 1
    shift 3
    while (($#)); do eval "$1"; shift; done
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
    while M "$raw" "$re"; do
        final "${raw%%"${M[0]}"*}"
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
        pop stack x
        pop stack t
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

final() { # <content>
    (( ${#1} )) || return
    local t=''
    peek2 stack t 2>/dev/null
    if [[ "$t" == "final" ]]; then
        pop stack t
        stack+=("$t$1")
    else
        stack+=(final "$1")
    fi
}

register em '\*\*'
em=0
em() { (( em )) && final '</em>' || final '<em>'; em=$((em^1)); }

register b '\*'
b=0
b() { (( b )) && final '</b>' || final '<b>'; b=$((b^1)); }


register code '`(?P<Rcode>[^`]*)`'
code() { final "<code>$Rcode</code>"; }

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

register Rtag '(?P<Rtag><[^<>]*>)'
Rtag() { tag "$Rtag"; }
tag=()
tag() { # <tag>
    local M x raw_attr line
    if ! M "$1" '<(?P<x>[[:alnum:]]+)(?P<raw_attr>([^>]?[^->])*)(?P<line>-?)>';then
        final "$1"; return
    fi
    # if '->', then add close tag at the end of the line
    [[ -n "$line" ]] && tag+="</$x>"
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

register aimg '(?P<Rimg>!?)\[(?P<desc>[^]]*)]\((?P<url>[^ )]*)(?P<meta>[^)]*)\)'
aimg() {
    if [[ -n "$Rimg" ]]; then
        tag "<img src=\"$url\" alt=\"$desc\" $meta>"
    else
        tag "<a href=\"$url\" $meta>"; final "$desc</a>"
    fi
}

register ulol "$n(?P<Rdepth> *)(?P<Rulol>[*-]|[0-9]+\\.) "
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
}

register p "$n$n"
p() { lf; close_ulol -1; final "<p>"; raw="$n$raw"; }

register lf "$n"
lf() {
    local x
    while (( ${#tag[@]} )); do
        pop tag x
        final "$x"
    done
    if (( h )); then
        final "</h$h>"
        h=0
    fi
    final $'\n'
}
# TODO moustache array, not, and end blocks
# TODO moustache var, unsafe var
# TODO md codeblock

render() {
    # TODO massage internal urls to be all relative
    clean
    for filename in **/**.md; do
        echo "file $filename > ${filename%.md}"
        file "$filename" > "${filename%.md}"
        # TODO special case for index > index.html
    done
}
clean() {
    for filename in **/**; do
        # filter only regular files that have no extension (.)
        if M "$filename" '(^|/)[^.]*$' && [[ -f "$filename" ]]; then
            echo "clean $filename"
            rm "$filename"
            # TODO special case for index.html
        fi
    done
}
daemon() {
    render
    local tmp server_pid
    trap 'kill $server_pid;rm $tmp; exit' SIGINT
    tmp="$(mktemp)"
    python <<EOF & server_pid="$!"
from http.server import HTTPServer, SimpleHTTPRequestHandler
SimpleHTTPRequestHandler.extensions_map[''] = 'text/html'
HTTPServer(('', 5000), SimpleHTTPRequestHandler).serve_forever()
EOF
    while sleep 1; do
        local x="$(find * -type f -newer "$tmp" -print)"
        [[ -n "$x" ]] && render
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
