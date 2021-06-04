#!/bin/bash

# in macros, no self closing tags or
self="$(realpath -s "${BASH_SOURCE[0]}")"
# only run from the project root
cd "$(git rev-parse --show-toplevel)" || exit $?

log() { echo "${self##*/}:${FUNCNAME[1]}: $*" >&2; }
match() { [[ "$1" =~ $2 ]] && match=("${BASH_REMATCH[@]}"); }
rfc822() { date -R ${1:+-jf %Y-%m-%d $1}; }
url_for() { echo "site/${1/%txt/html}"; }
?() { echo "${!@}"; }
page_link() { echo "<a href=\"/$(url_for ${1:-$page})\">$(query ${1:-$page} title || echo "${1:-$page}")</a>"; }
li_date_page() {
  date="$(query ${1:-$page} date)" && echo "<li>$(page_link ${1:-$page})<span class=\"date\">$date</span>"
}

query() {
  while read line; do
    match "$line" "\`($2=[^\`]*)\`" && eval "${match[1]}" && echo "${!2}" && return
  done < "content/$1"
  return 1
}

include() {
  local tmp macro layout close line2 id class attr
  tmp="$(mktemp)" macro="$(mktemp)" layout=""
  while read line; do
    # paragraph and horizontal rule
    if match "$line" '^([-*]*)$'; then if (( ${#match[0]} )); then line="<hr>"; else line="<p>"; fi; fi
    # list
    if match "$line" '^([[:space:]]*)[-*] '; then line="${match[1]}<li>${line#"${match[0]}"}"; fi
    # header
    if match "$line" '^([[:space:]]*)([#]+)' ; then line="${match[1]}<h${#match[2]}->${line#"${match[0]}"}"; fi
    # link
    while match "$line" '^([^]]*)\[([^]]+)\]\(([^)]*)\)'; do
      line="${match[1]}<a target="_blank" href=\"${match[3]}\">${match[2]}</a>${line#"${match[0]}"}"
    done
    # extended tag
    close="" line2=""
    while match "$line" "^([^<]*)<([[:alnum:]]+)(([^>]?[^->])*)([-]?)>"; do
      id='' class=() attr=() close="${match[${#match[@]}-1]:+"</${match[2]}>"}$close"
      for a in ${match[3]}; do
          case "$a" in
              \#*) id="${a#'#'}" ;;
              \.*) class+=("${a#.}") ;;
              *) attr+=("$a") ;;
          esac
      done
      line2+="${match[1]}<${match[2]}${id:+ id=\"$id\"}${class:+ class=\"${class[@]}\"}${attr:+ ${attr[@]}}>"
      line="${line#"${match[0]}"}"
    done
    line="$line2$line$close"
    # macro
    while match "$line" '^([^`]*)`([^`]*)`'; do
      # weird redirect to avoid subshells
      eval "${match[2]}" > "$macro"
      line="${match[1]}$(cat < "$macro")${line#*"${match[0]}"}"
    done
    echo "$line"
  done < <(cat "content/$1"; echo)  > "$tmp"
  # layout
  if [[ -n "$layout" ]]; then
    local content="$(cat "$tmp")"
    include "$layout"
  else
    cat "$tmp"
  fi
  rm "$tmp" "$macro"
}

css_minify() {
  local X="$(cat - | tr "\n" " ")"
  while match "$X" '\/\*([^*]*|\*[^\/])*\*\/'; do X="${X/"${match[0]}"}"; done
  while match "$X" '^([^[:space:]]*)[[:space:]]+(.?)'; do
    echo -n "${match[1]}"
    X="${X/"${match[0]}"/${match[2]}}"
    [[ "${match[1]: -1}${match[2]}" =~ ^[[:alnum:]]*$ ]] && echo -n " "
  done
  return 0
}


render_site() {
  rm -rf site/*
  pages="$(cd content; find * -name "*.txt")"
  for page in $pages; do
    url="$(url_for $page)"
    log "content/$page --> $url"
    mkdir -p "$(dirname "${url#/}")" && include "$page" > "$url"
  done
  log "content/feed.xml --> site/feed.xml"
  include feed.xml > site/feed.xml
  log "content/*.css --> site/min.css"
  find content/ -name "*.css" -exec cat {} + | css_minify  >> "site/min.css"
}

daemon() {
  render_site || exit $?
  trap 'kill $server_pid;rm $timestamp; exit' SIGINT
  timestamp="$(mktemp)"
  python -m SimpleHTTPServer 5000 & server_pid="$!"
  while sleep 1; do
    local changed="$(cd content; find * -newer "$timestamp")"
    touch "$timestamp"
    [[ "$changed" ]] && render_site && log "reload complete: $changed" | tr "\n" " "
  done
}

case "${1:-${self##*/}}" in
  # initialize self as pre-commit hook
  init) ln -fs "$self" .git/hooks/pre-commit ;;
  render) render_site ;;
  pre-commit) render_site || exit $?; git add site/ ;;
  *) daemon ;;
esac
