#!/usr/local/bin/bash

## CONFIGURATION
src="content"
bin="site"

# TODO content subdirectories don't seem to work anymore?
# add CNAME record to make use of new domain

main() {
  n=$'\n' # parameter expansion is more consistent than escaping
  cd "$(git rev-parse --show-toplevel)" || exit $?
  case "${1:-${BASH_SOURCE[0]##*/}}" in
    init) ln -vfs "$(realpath -s "${BASH_SOURCE[0]}")" .git/hooks/pre-commit ;;
    pre-commit) render_site || exit $?; git add site/ ;;
    render) perf render_site ;;
    *) test_server ;;
  esac
}

render_site() {
  perf render_metadata
  rm -rf ${bin:-site}/* # clear out old files, don't accidentially rm -rf /*
  for page in $pages; do perf render_page & done
  perf render_css
  wait
}

perf() { local TIMEFORMAT="perf:$1: %lR %lU %lS"; time "$@"; }
declare -A log; log=([info]=0 [warning]=1 [error]=2); log=warning
log() { (( "${log[$1]:-0}" >= ${log[$log]} )) && printf "%s\n" "${BASH_SOURCE[0]##*/}:${FUNCNAME[1]}: $*" >&2; }
V() { V="${2:-$page}"; V="page_${V//[.\/ ]/_}_$1"; [[ $# == 3 ]] && export "$V"="$3" || printf '%s' "${!V}"; }
M() { unset -v M; [[ "$1" =~ $2 ]] && M=("${BASH_REMATCH[@]}"); }

render_metadata() {
  pages="$(cd "$src"; find -- * \( -iname "*.md" -o -iname "*.html" \))"
  local x C
  for page in $pages; do
    V title    "$page" "${page%\.*}"
    V file     "$page" "$bin/${page%\.md}"
    V url      "$page" "${!V%index.html}"
    V date     "$page" "$(git log --date=short --format=%ad -- "$src/$page" | tail -1)"
    V layout   "$page" "default"
    V backlink "$page" "index.html"
    V content  "$page" "$(<"$src/$page")"
    x="$V" # x is variable name for $page content
    while M "$(V content)" "^([[:alnum:]]+): ?([^$n]*)$n"; do  # read and drop preamble
      V content   "$page" "${!x/"$M"}";
      V "${M[1]}" "$page" "${M[2]}";
    done
    # title case for title
    # shellcheck disable=SC2207
    x=($(V title | tr _ ' ')); x=("${x[@],,}");
    V title "$page" "${x[*]^}"
  done
  V backlink "index.html" "$pages"
  log generate backlink list
  for page in $pages; do for p in $pages; do
    M "$C" "$(V title "$p")" && V backlink "$p" "$(V backlink "$p") $page"
  done; done
  # sort pages by title, longest first
  pages="$({ for p in $pages;   do printf "%s\t%s\n" "$(V title "$p")" "$p"; done } | sort -r -t"\t" -k1 | cut -f 2)"
  # sort links by title, alphabetically
  for page in $pages; do
    V backlink "$page" "$(
      { for p in $(V backlink); do
        [[ "$p" == "$page" ]] ||   printf "%s\t%s\n" "$(V title "$p")" "$p"; done } | sort    -t"\t" -k1 | cut -f 2
    )"
    log "$page -->" "$(V backlink)"
  done
}

render_page() {
  local log="$page" layout="$(V layout)" C hash
  declare -A pre
  if [[ -n "$layout" ]]; then C="$(<"$src/$layout")"; else C="$(V content)"; fi
  # macro
  while M "$C" '{{((}?[^}])*)}}'; do C="${C/"$M"/$(eval "${M[1]}")}"; done
  # strip out pre (backticks) and replace with hash
  # shellcheck disable=SC2016
  while M "$C" '`(((\\`)?[^`])*)`'; do
    hash="$(sha1sum <<<"$M")"
    pre[$hash]="<pre>${M[1]//'\`'/'`'}</pre>";
    C="${C//"$M"/"$hash"}"
  done
  #log "auto-link"
  # only auto-link main content. Don't link yourself
  # TODO case-insensitive search
  for p in $pages; do
    local t="$(V title "$p")"
    if [[ "$p" != "$page" ]] && M "$C" "(<[^>]*$t)|($t[^<]*</a>)|(\([^)]*$t)|($t(.*))" && [[ -n "${M[4]}" ]]; then
      C="${C/"${M[4]}"/[](/${p#index.html})${M[5]}}";
    fi
  done
  C="$(render_lines <<<"$C$n$n")"
  for hash in "${!pre[@]}"; do
    C="${C//"$hash"/"${pre[$hash]}"}";
  done
  printf '%s' "$C" > "$(V file)"
}

render_lines() {
  local list_block=''
  while IFS= read -r line; do
    if [[ -z "$list_block" ]]; then # we're not in a list so see if we need to start
      if M "$line" '^ *([-*>]|[0-9]+\.) '; then list_block="$n$line"; continue; fi
    else
      if [[ -z "$line" ]]; then # we hit an empty line, so process $list_block
        # $tab is a stack serialized as a string. `M "$tab" "$tab_re"` peeks at the top of the stack.
        local tab_re='([a-z]+)([0-9]+)' tab=''
        while M "$list_block" "$n( *)([-*>]|[0-9]+\.) "; do
          local l_in="$M" l_out='' tab_s=${#M[1]} tab_t=''
          # determine list type
          case "${M[2]: -1}" in \.) tab_t=ol ;; \>) tab_t=blockquote ;; *) tab_t=ul ;; esac
          # add list close tag
          while M "$tab" "$tab_re" && [[ "$tab_s" -lt "${M[2]}" ]];do tab="${tab#"$M"}"; l_out="$l_out</${M[1]}>"; done
          # add list opening tag
          if M "$tab" "$tab_re";[[ "$tab_s" -gt "${M[2]:-(-1)}" ]];then tab="$tab_t$tab_s$tab"; l_out="$l_out$n<${tab_t}>"; fi
          # add element tag or a space
          [[ "blockquote" != "$tab_t" ]] && l_out="$l_out<li>" || l_out="$l_out "
          list_block="${list_block/"$l_in"/$l_out}"
        done
        # close remaining tags
        while M "$tab" "$tab_re"; do tab="${tab#"$M"}"; list_block="$list_block</${M[1]}>"; done
        line="$list_block$n<p>" list_block=''
      # otherwise scan for the end of the block
      else list_block="$list_block$n$line"; continue; fi
    fi
    # <p> <hr>
    M "$line" '^-*$' && if (( ${#M} )); then line="<hr>"; else line="<p>"; fi;
    # # headers
    if M "$line" '^[[:space:]]*(#+)([^|]*)\|?(.*)$' ; then line="<h${#M[1]} ${M[3]}->${M[2]}"; fi
    # **bold**
    while M "$line" '\*\*((\*[^*]|[^*])*)\*\*'; do line="${line/"$M"/<b>${M[1]}</b>}"; done
    # *italic*
    while M "$line" '\*([^*]*)\*'; do line="${line/"$M"/<em>${M[1]}</em>}"; done
    # ![images and links](/url.txt)
    while M "$line" '!\[ *([^]|]*) *\|? *([^]]*)\]\(([^)]*)\)'; do
        line="${line/"$M"/<img src=\"${M[3]}\" alt=\"${M[1]}\" title=\"${M[1]}\" ${M[2]}>}";
    done
    while M "$line"  '\[ *([^]|]*) *\|? *([^]]*)\]\((/?)([^)]*)\)'; do
      # 1: display_text, 2: metadata, 3: is_internal, 4: url_or_page
      case "${M[3]}" in
        "/")line="${line/"$M"/<a href=\"/$(V url "${M[4]}")\" ${M[2]}>${M[1]:-$(V title "${M[4]}")}</a>}";;
        *) line="${line/"$M"/<a href=\"${M[4]}\" ${M[2]}>${M[1]:-${M[4]}}</a>}";;
      esac
    done
    # <self-closing-tags ->
    local close=''
    while M "$line" '<([^ >]+)([^>]*)->'; do
      line="${line/"$M"/<${M[1]} ${M[2]}>}"
      close="</${M[1]}>$close"
    done
    close="$line$close" line=''
    # extended attrs
    while M "$close" '^([^<]*)<([^ >]+)([^>]*)>'; do
      local id='' class=() attr=()
      # TODO don't split quoted attribute values
      # shellcheck disable=SC2068
      for a in ${M[3]}; do case "$a" in \#*) id="${a#'#'}" ;; \.*) class+=("${a#.}") ;; *) attr+=("$a") ;; esac done
      line="$line${M[1]}<${M[2]}${id:+ id=\"$id\"}${class:+ class=\"${class[@]}\"}${attr:+ ${attr[@]}}>"
      close="${close/"$M"/}"
    done
    line="$line$close"
    printf '%s' "$line"
  done
}

# TODO allow macros in css
# TODO style internal links as bold, leave external links as blue and target=_blank?
render_css() { find $src/ -name "*.css" -exec cat {} + | css_minify >> "$bin/min.css"; }
css_minify() {
  local X="$(cat - | tr "\n" " ")"
  while M "$X" '\/\*([^*]*|\*[^\/])*\*\/'; do X="${X/"$M"}"; done
  while M "$X" '^([^[:space:]]*)[[:space:]]+(.?)'; do
    printf '%s' "${M[1]}"
    X="${X/"$M"/${M[2]}}"
    [[ "${M[1]: -1}${M[2]}" =~ ^[[:alnum:]]*$ ]] && printf ' '
  done
  return 0
}

test_server() {
  log=info
  perf render_site || exit $?
  trap 'rm -f -- "$timestamp"' EXIT; timestamp="$(mktemp)"
  # check for changes every second and rebuild the site when necessary
  while sleep 1; do
    changed="$(cd "$src"; find * -newer "$timestamp")"; touch "$timestamp"
    if [[ "$changed" ]]; then log "reloading: ${changed}"; perf render_site; fi
  done &
  # TODO ease external dependancy https://gist.github.com/willurd/5720255
  php -S 127.0.0.1:5000
}

main "$@"
