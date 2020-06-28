#!/bin/bash
self="$(realpath -s "${BASH_SOURCE[0]}")"
# only run from the project root
cd "$(git rev-parse --show-toplevel)" || exit $?

# CORE FUNCTIONS
log() { echo "${self##*/}:${FUNCNAME[1]}: $*" >&2; }
tag() {
  # extends html syntax to give it a similar syntax to css
  # <p #myid .myclass .class2 -> yo
  # <p id="myid" class="myclass class2"> yo</p>
  # the closing tag is inserted at the end of the line when '->' is used
  # in the opening tag
  local pattern="^([^<]*)<([[:alnum:]]+)(([^>]?[^->])*)([-]?)>"
  while read line; do
    local close=""
    while [[ "$line" =~ $pattern ]]; do
      # emit everything before the tag
      echo -n "${BASH_REMATCH[1]}"
      local tag="${BASH_REMATCH[2]}"
      local raw_attr="${BASH_REMATCH[3]}"
      close="${BASH_REMATCH[${#BASH_REMATCH[@]}-1]:+"</$tag>"}$close"
      # chop the line
      line="${line#*"${BASH_REMATCH[0]}"}"
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

query() {
  # prints the value of $2 as defined in file $1
  local pattern="\`($2=[^\`]*)\`"
  while read line; do
    [[ "$line" =~ $pattern ]] && eval "${BASH_REMATCH[1]}" && echo "${!2}" && return
  done < "content/$1"
  return 1 # return 1 if it wasn't defined
}
include() {
  # macros are denoted with backticks and are bash expressions
  #   because of this backticks are not allowed in macros
  # layout are denoted by setting the $layout in a macro like `layout=default`
  # layout receive the rendered file in $content (accessed like `? content`)
  local tmp="$(mktemp)"
  # TODO markdown pass
  # TODO    handle things like header and list shorhand
  # macro pass
  local layout=""
  local pattern='^([^`]*)`([^`]*)`'
  while read line; do
    while [[ "$line" =~ $pattern ]]; do
      echo -n "${BASH_REMATCH[1]}"
      if [[ "${BASH_REMATCH[1]}" == *"->"* ]]; then
        # incase there's a self closing tag, put everything
        # on the same line.
        eval "${BASH_REMATCH[2]}" | tr "\n" " "
      else
        eval "${BASH_REMATCH[2]}"
      fi
      line="${line#*"${BASH_REMATCH[0]}"}"
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
  while [[ "$X" =~ \/\*([^*]*|\*[^\/])*\*\/ ]]; do X="${X/"${BASH_REMATCH[0]}"}"; done
  while [[ "$X" =~ ^([^[:space:]]*)[[:space:]]+(.?) ]]; do
    echo -n "${BASH_REMATCH[1]}"
    X="${X/"${BASH_REMATCH[0]}"/${BASH_REMATCH[2]}}"
    [[ "${BASH_REMATCH[1]: -1}${BASH_REMATCH[2]}" =~ ^[[:alnum:]]*$ ]] && echo -n " "
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
  find -E content/ -regex ".*\.css" -exec cat {} + | css_minify  >> "site/min.css"
}

serve() {
  render_site || exit $?
  log starting
  trap 'kill $server_pid; exit' SIGINT
  python -m SimpleHTTPServer 5000 & server_pid="$!"
  while sleep 1; do
    ( [[ -n "$(find content/ -type f -mtime 1s)" ]] && render_site &)
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
  *) serve ;;
esac
