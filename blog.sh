#!/bin/bash

content_dir="content"
site_dir="site"
helper_script="helpers.sh"
default_layout="default"

cd "$(git rev-parse --show-toplevel)" || exit $?
self="$(realpath -s "${BASH_SOURCE[0]}")" # name of this file as it was invoked.
n=$'\n' # parameter expansion is more consistent than escaping
log() { echo "${self##*/}:${FUNCNAME[1]}:${BASH_LINENO[0]}: $*" >&2; }
A() { # attribute extensions
  # TODO don't split quoted attribute values
  local id='' class=() attr=()
  # shellcheck disable=SC2068
  for a in $@; do case "$a" in \#*) id="${a#'#'}" ;; \.*) class+=("${a#.}") ;; *) attr+=("$a") ;; esac done
  echo "${id:+ id=\"$id\"}${class:+ class=\"${class[@]}\"}${attr:+ ${attr[@]}}"
}
# generate url from page
U() { U="${1:-$page}"; echo "$site_dir/${U%.md}"; }
# get/set value defined in page scope. usage: V var [page [value]]
V() { V="${2:-$page}"; V="page_${V//[.\/ ]/_}_$1"; [[ $# == 3 ]] && export "$V"="$3" || echo "${!V}" ; }
# nicer match syntax
M() { unset -v M; [[ "$1" =~ $2 ]] && M=("${BASH_REMATCH[@]}"); }

# TODO revisit
css_minify() {
  local X="$(cat - | tr "\n" " ")"
  while M "$X" '\/\*([^*]*|\*[^\/])*\*\/'; do X="${X/"$M"}"; done
  while M "$X" '^([^[:space:]]*)[[:space:]]+(.?)'; do
    echo -n "${M[1]}"
    X="${X/"$M"/${M[2]}}"
    [[ "${M[1]: -1}${M[2]}" =~ ^[[:alnum:]]*$ ]] && echo -n " "
  done
  return 0
}

include() {
  local C="$(<"${1:+$content_dir/}${1:-/dev/stdin}")$n" # collect the file, make sure it ends in a newline
  # strip: preamble
  if M "$C" "^.*$n===$n"; then C="${C/"$M"/}"; fi

  # `pre`
  # TODO marker doesn't always get converted?
  local pre=() pre_count=0 pre_marker="%pre%"
  # TODO save pre in an array and leave a marker, then come back in later to paste it in
  while M "$C" "\`([^\`]+)\`"; do C="${C/"$M"/$pre_marker}"; pre[${#pre[@]}]="${M[1]}"; done

  # {{ macro }}
  while M "$C" '{{((}?[^}])*)}}'; do C="${C/"$M"/$(eval "${M[1]}")}"; done

  # auto-link
  # TODO why is there an extra empty link for each of these?
  # TODO anchor on first link
  # TODO stop linking yourself
  for p in $pages; do
    if M "$C" "$(V title "$p")" && [[ "$p" != "$page" ]]; then
      V backlink "$p" "$(V backlink "$p") $page"
      C="${C//"$(V title "$p")"/[](/$p)}";
    fi
  done

  # rendering in the following section is line based
  local list_block=''
  while IFS= read -r line; do
    if [[ -z "$list_block" ]]; then
      # see if we need to start a list
      if M "$line" '^ *([-*>]|[0-9]+\.) '; then list_block="$n$line"; continue; fi
    else
      if [[ -z "$line" ]]; then
#        log "list block: $list_block"
        # close out list block
        local tab_re='([a-z]+)([0-9]+)' tab=''
        while M "$list_block" "$n( *)([-*>]|[0-9]+\.) "; do
          local l_in="$M" l_out='' tab_s=${#M[1]} tab_t=''
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
    # TODO if we match a list, then continue reading until we hit \n\n and process the whole thing at once
    # <p> <hr>
    M "$line" '^-*$' && if (( ${#M} )); then line="<hr>"; else line="<p>"; fi;
    # # headers
    if M "$line" '^[[:space:]]*(#+)([^|]*)\|?(.*)$' ; then line="<h${#M[1]} ${M[3]}->${M[2]}"; fi
    # **bold**
    while M "$line" '\*\*((\*[^*]|[^*])*)\*\*'; do line="${line/"$M"/<b>${M[1]}</b>}"; done
    # *italic*
    while M "$line" '\*([^*]*)\*'; do line="${line/"$M"/<em>${M[1]}</em>}"; done
    # ![images and links](/url.txt)
    while M "$line" '(!?)\[ *([^]|]*) *\|?([^]]*)\]\(([^)]*:/)?/(([^)/]*)[^)]*)\)'; do
      # Mes 1: is_image, 2: display_text, 3: metadata, 4: protocol, 5: partial_url, 6: domain
      # separate cases for image (has !), external link (has protocol), and internal link (neither)
      case "${M[1]}${M[4]}" in
        "")line="${line/"$M"/<a href=\"/$(U "${M[5]}")\" ${M[3]}>${M[2]:-$(V title "${M[5]}")}</a>}";;
        !*)line="${line/"$M"/<img src=\"/${M[5]}\" alt=\"${M[2]}\" ${M[3]}>}";;
        *) line="${line/"$M"/<a href=\"${M[4]}/${M[5]}\" ${M[3]}>${M[2]:-${M[6]}}</a>}";;
      esac
    done
    # <self-closing-tags ->
    local close=''
    while M "$line" '<([^ >]+)([^>]*)->'; do
      line="${line/"$M"/<${M[1]} ${M[2]}>}"
      close="</${M[1]}>$close"
    done
    close="$line$close" line=''
    # TODO extended attrs
    while M "$close" '^([^<]*)<([^ >]+)([^>]*)>'; do
      line="$line${M[1]}<${M[2]}$(A ${M[3]})>"
      close="${close/"$M"/}"
    done
    line="$line$close"
    while M "$line" "$pre_marker"; do
      line="${line/"$M"/<code>${pre[$pre_count]}</code>}"
      pre_count=$((pre_count + 1))
    done
    echo "$line"
  done < <(printf '%s' "$C$n$n")
}

# render site
render_site() {
  # default $site_dir to "site" to prevent expansion to `rm -rf /*`
  rm -rf ${site_dir:?site}/*
  pages="$(cd "$content_dir"; find -- * \( -iname "*.md" -o -iname "*.html" \))"
  # collect metadata, add in default layout, has_preamble, depth in order to allow relative links
  for page in $pages; do
    V title "$page" "$page"
    V layout "$page" "$default_layout"
    # it seems like date isn't aware of moving files
    V date "$page" "$(git log --date=short --format=%ad -- "$content_dir/$page" | tail -1)"
    # shellcheck disable=SC2162
    while read line; do
      if M "$line" '^([[:alnum:]]+): ?(.*)$'; then V "${M[1]}" "$page" "${M[2]}"; else break; fi
    done < "$content_dir/$page"
    # shellcheck disable=SC2207
    tags=("${tags[@]}" $(V tags))
  done
  # deduplicate tags
  IFS=$n sort <<<"${tags[@]}" | uniq | read -ra tags

  [[ -f "$helper_script" ]] && . "$helper_script"

  # render main contents for each page
  for page in $pages; do V content "$page" "$(include "$page")"; done

  # render min.css
  find $content_dir/ -name "*.css" -exec cat {} + | css_minify >> "$site_dir/min.css"

  # final render
  for page in $pages; do
    # add cross-links to content
    local links=""
    for backlink in $(V backlink | tr ' ' "$n" | sort | uniq); do links="$links* $(V title "$backlink")$n"; done
    [[ -z "$links" ]] || V content "$page" "$(V content)$n---$n### backlinks$n$links"
    # render layout
    if [[ -n "$(V layout)" ]]; then include "$(V layout)" > "$(U)"; else V content > "$(U)"; fi
  done
}

test_server() {
  render_site || exit $?
  trap 'kill $server_pid;rm $timestamp; exit' SIGINT
  timestamp="$(mktemp)"
  # TODO ease python dependancy https://gist.github.com/willurd/5720255
  php -S 127.0.0.1:5000 & server_pid="$!"
  # check for changes every second and rebuild the site when necessary
  while sleep 1; do
    changed="$(cd $content_dir; find * -newer "$timestamp")"
    touch "$timestamp"
    [[ "$changed" ]] && render_site && log "reload complete: ${changed//$n/ }"
  done

}
## MAIN
case "${1:-${self##*/}}" in
  # link self as pre-commit hook
  init) ln -fs "$self" .git/hooks/pre-commit ;;
  # run as a precommit
  pre-commit) render_site || exit $?; git add site/ ;;
  render) render_site ;;
  *) test_server ;;
esac
