#!/bin/bash

self="$(realpath -s "${BASH_SOURCE[0]}")"
# only run from the project root
cd "$(git rev-parse --show-toplevel)" || exit $?

# CORE FUNCTIONS
log() { echo "${self##*/}:${FUNCNAME[1]}: $*" >&2; }
match() { [[ "$1" =~ $2 ]] && match=("${BASH_REMATCH[@]}"); }
tag() {
  # extends html syntax to give it a similar syntax to css
  # <p #myid .myclass .class2 -> yo
  # <p id="myid" class="myclass class2"> yo</p>
  # the closing tag is inserted at the end of the line when '->' is used
  # in the opening tag
  # TODO edit the whole line and emit at the end
  # TODO subsume into include()
  while read line; do
    local close=""
    while match "$line" "^([^<]*)<([[:alnum:]]+)(([^>]?[^->])*)([-]?)>"; do
      # emit everything before the tag
      echo -n "${match[1]}"
      local tag="${match[2]}"
      local raw_attr="${match[3]}"
      close="${match[${#match[@]} -1]:+"</$tag>"}$close"
      # chop the line
      line="${line#*"${match[0]}"}"
      # process attributes
      local id=''
      local class=()
      local attr=()
      for a in $raw_attr; do
          case "$a" in
              \#*) id="${a#'#'}" ;;
              \.*) class+=("${a#.}") ;;
              *) attr+=("$a") ;;
          esac
      done
      echo -n "<$tag${id:+ id=\"$id\"}${class:+ class=\"${class[@]}\"}${attr:+ ${attr[@]}}>"
    done
    echo "$line$close"
  done < /dev/stdin
}

rfc822() { date -R ${1:+-jf %Y-%m-%d $1}; }
url_for() { echo "site/${1/%txt/html}"; }
emit() { echo "$@" | tag; }
?() { echo "${!@}"; }
page_link() { emit "<a href=\"/$(url_for ${1:-$page})\"->$(query ${1:-$page} title || echo "${1:-$page}")"; }
li_date_page() {
  date="$(query ${1:-$page} date)"
  [[ -n "$date" ]] && echo "<li>$(page_link ${1:-$page})<span class=\"date\">$date</span>"
}

query() {
  # prints the value of $2 as defined in file $1
  while read line; do
    match "$line" "\`($2=[^\`]*)\`" && eval "${match[1]}" && echo "${!2}" && return
  done < "content/$1"
  return 1 # return 1 if it wasn't defined
}

include() {
  # macros are denoted with backticks and are bash expressions
  #   because of this backticks are not allowed in macros
  # layout are denoted by setting the $layout in a macro like `layout=default`
  # layout receive the rendered file in $content (accessed like `? content`)
  local tmp="$(mktemp)"
  local layout=""
  while read line; do
    # paragraph and horizontal rules
    # this match comes first, and intentionally matches an empty string
    # which means that following patterns don't need to worry about that
    if match "$line" '^([-*]*)$'; then
      if (( ${#match[0]} )); then
       	line="<hr>"
      else
	line="<p>"
      fi
    fi 
    # lists
    # TODO handle list depth, start and stop
    if match "$line" '^([[:space:]]*)[-*] '; then
      line="${match[1]}<li>${line#"${match[0]}"}"
    fi 
    # header
    if match "$line" '^([[:space:]]*)([#]+)' ; then
      line="${match[1]}<h${#match[2]}->${line#"${match[0]}"}"
    fi 
    # links
    while match "$line" '^([^]]*)\[([^]]+)\]\(([^)]*)\)'; do
      line="${match[1]}<a target="_blank" href=\"${match[3]}\">${match[2]}</a>${line#"${match[0]}"}"
    done

    # macro pass
    # TODO modify the line in place, only emit at the end
    while match "$line" '^([^`]*)`([^`]*)`'; do
      echo -n "${match[1]}"
      if [[ "${match[1]}" == *"->"* ]]; then
        # incase there's a self closing tag, put everything
        # on the same line.
        eval "${match[2]}" | tr "\n" " "
      else
        eval "${match[2]}"
      fi
      line="${line#*"${match[0]}"}"
    done
    echo "$line"
  done < "content/$1" > "$tmp"
  # layout pass
  if [[ -n "$layout" ]]; then
    local content="$(cat "$tmp")"
    include "$layout"
  else
    cat "$tmp"
  fi
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

log() { echo "${0##*/}:${FUNCNAME[1]}: $*"; }

render_site() {
  # clean
  rm -rf site/*
  # render html
  pages="$(cd content; find * -name "*.txt")"
  for page in $pages; do
    url="$(url_for $page)"
    log "content/$page --> $url"
    mkdir -p "$(dirname "${url#/}")"
    include "$page" | tag > "$url"
  done
  # render rss
  log "content/feed.xml --> site/feed.xml"
  include feed.xml > site/feed.xml
  # render css
  log "content/*.css --> site/min.css"
  find content/ -name "*.css" -exec cat {} + | css_minify  >> "site/min.css"
}

daemon() {
  render_site || exit $?
  log starting
  trap 'kill $server_pid;rm $tmp; exit' SIGINT
  tmp="$(mktemp)"
  python -m SimpleHTTPServer 5000 & server_pid="$!"
  while sleep 1; do
    local changed="$(cd content; find * -type f -newer "$tmp")"
    touch "$tmp"
    if [[ -n "$changed" ]]; then
      render_site > /dev/null && log "reload complete: $changed" | tr "\n" " "
      echo
    fi
    done
}

# MAIN
case "${1:-${self##*/}}" in
  init)
    # initialize self as pre-commit hook
    ln -fs "$self" .git/hooks/pre-commit ;;
  render) render_site ;;
  pre-commit)
    # run as git pre-commit hook
    render_site || exit $?
    git add site/
    ;;
  *) daemon ;;
esac
