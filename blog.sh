#!/bin/bash

## Notes
# special vars you probably shouldn't set in macros: [pages, page, url] iff macros aren't in a subshell
# TODO all these long match statements could really use some english explanation
# TODO what if we change the macro marker to {{}} like jinja2 and let backticks be <code> like markdown intended
# TODO render pages in background then `wait`

## CONFIG
content_dir="content"
site_dir="site"
helper_script="helpers.sh"
preamble_marker="==="
default_layout=default

## PRE-CHECKS

# name of this file as it was invoked. this is exploited later to figure out if we're being run as a git pre-commit
self="$(realpath -s "${BASH_SOURCE[0]}")"

# only run from the project root, and only while in git
cd "$(git rev-parse --show-toplevel)" || exit $?

## UTILITY FUNCTIONS

log() { echo "${self##*/}:${FUNCNAME[1]}: $*" >&2; }

# in bash, function and variable namespaces are distinct.
# this is a bit more readable than typing BASH_REMATCH all over the place
# unset -v deletes previous match arrays so that there aren't old results hanging around
match() { unset -v match; [[ "$1" =~ $2 ]] && match=("${BASH_REMATCH[@]}"); }

# generate $url from $page
url_for() { echo "$site_dir/${1/%txt/html}"; }

# ?(page=$page, var) - get value defined in page scope
?() {
  set -- "$page" "$@"; set -- "${*:(-2)}"
  local var="page_${1//[.\/ ]/_}";
  echo "${!var}"
}

css_minify() {
  local X="$(cat - | tr "\n" " ")"
  while match "$X" '\/\*([^*]*|\*[^\/])*\*\/'; do X="${X/"$match"}"; done
  while match "$X" '^([^[:space:]]*)[[:space:]]+(.?)'; do
    echo -n "${match[1]}"
    X="${X/"$match"/${match[2]}}"
    [[ "${match[1]: -1}${match[2]}" =~ ^[[:alnum:]]*$ ]] && echo -n " "
  done
  return 0
}

# TODO attribute expansion happens twice (normal tags and []() construct), pull it out into this function
# TODO attribute expansion is distinct from self-closing tags
attrify() {
  local id='' class=() attr=()
  # shellcheck disable=SC2068
  for a in $@; do case "$a" in \#*) id="${a#'#'}" ;; \.*) class+=("${a#.}") ;; *) attr+=("$a") ;; esac done
  echo "${id:+ id=\"$id\"}${class:+ class=\"${class[@]}\"}${attr:+ ${attr[@]}}"
}
## CORE FUNCTIONS

# $indent is a coded string containing '[uo][0-9]+' pairs representing
# ordered or unordered lists at the given indent level (number of spaces)
indent() {
  local indent_s indent_t pre
  # determine if there's a new list element, and if it's ordered or unordered
  if match "$line" '^( *)([-*]|[0-9]+\.) '; then
    line="${line#"$match"}"
    indent_s="${#match[1]}"
    if match "${match[2]}" "[0-9]"; then indent_t=o; else indent_t=u; fi
  else
    # close everything if there's an empty line or horizontal rule
    if match "$line" '^([-*]*)$'; then
      indent_s=-1
      if (( ${#match[0]} )); then line="<hr>"; else line="<p>"; fi;
    else
      return # this function exists separately from include() so that this return can be effectively a goto
    fi
  fi
  # add list closing tags
  while match "$indent" '([uo])([0-9]*)' && [[ "$indent_s" -lt "${match[2]:-(-1)}" ]]; do
    indent="${indent#"$match"}"
    pre="$pre</${match[1]}l>"
  done
  # add list opening tag
  if match "$indent" '([uo])([0-9]*)'; [[ "$indent_s" -gt "${match[2]:-(-1)}" ]]; then
    indent="$indent_t$indent_s$indent"
    pre="$pre<${indent_t}l>"
  fi
  [[ -n "$indent_t" ]] && pre="$pre<li>"
  line="$pre$line"
}

include() {
  # TODO I think that $tmp can be removed if the redirects on the main while loop can be figured out beforehand
  #      now that the preamble is processed separately should a macro even be able to set vars?
  local tmp macro layout close line2 id class attr preamble
  tmp="$(mktemp)" macro="$(mktemp)" layout=""
  preamble="$(? "$1" has_preamble)"
  while IFS= read line; do
    # TODO header links and header extended tags
    # TODO <pre>, <code>, blockquotes, footnotes? emojis?
    # TODO section ordering: tags/headers/blockquotes/lists all care about lines. can macro emit multiple lines?
    # drop the preamble if there is one
    if [[ -n "$preamble" ]]; then match "$line" "^$preamble_marker\$" && preamble=''; continue; fi
    # list
    indent
    # header
    if match "$line" '^([[:space:]]*)([#]+)' ; then line="${match[1]}<h${#match[2]}->${line#"$match"}"; fi
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
      line="${line#"$match"}"
    done
    line="$line2$line$close"
    # macro
    # TODO allow multiline macro. let {{ and }} be on separate lines. How does this play with <tags->?
    while match "$line" '^([^`]*)`([^`]*)`'; do
      # weird redirect to avoid subshells
      eval "${match[2]}" > "$macro"
      line="${match[1]}$(cat < "$macro")${line#*"$match"}"
    done
    # <img> and <a>
    while match "$line" '(!?)\[ *([^]|]*) *\|?([^]]*)\]\(([^)]*:/)?/(([^)/]*)[^)]*)\)'; do
      # matches 1: is_image, 2: display_text, 3: metadata, 4: protocol, 5: partial_url, 6: domain
      local meta="$(attrify "${match[3]}")"
      # separate cases for image (has !), external link (has protocol), and internal link (neither)
      case "${match[1]}${match[4]}" in
        "")line="${line/"$match"/<a href=\"/$(url_for "${match[5]}")\" $meta>${match[2]:-$(? "${match[5]}" title)}</a>}";;
        !*)line="${line/"$match"/<img src=\"/${match[5]}\" alt=\"${match[2]}\" $meta>}";;
        *) line="${line/"$match"/<a href=\"${match[4]}/${match[5]}\" $meta>${match[2]:-${match[6]}}</a>}";;
      esac
    done
    # TODO attribute expansion
    # <b> and <em>
    while match "$line" '\*\*(.*)\*\*'; do line="${line/"$match"/<b>${match[1]}</b>}"; done
    while match "$line" '\*(.*)\*'; do line="${line/"$match"/<em>${match[1]}</em>}"; done
    echo "$line"
  done < <(cat "$content_dir/$1"; echo)  > "$tmp"
  # layout
  layout="$(? "$1" layout)"
  if [[ -n "$layout" ]]; then
    declare -x "page_${page//[.\/]/_}_content=$(cat "$tmp")"
    include "$layout"
  else
    cat "$tmp"
  fi
  rm "$tmp" "$macro"
}

render_site() {
  [[ -f "$helper_script" ]] && . "$helper_script"
  # default $site_dir to "site" to prevent expansion to `rm -rf /*`
  rm -rf ${site_dir:?site}/*
  pages="$(cd $content_dir; find * -name "*.txt")"
  # load preambles
  # TODO should preamble use `var: value` syntax instead of `var=value`. allow spaces after : and quote right hand side
  for page in $pages; do
    local prefix="page_${page//[.\/ ]/_}_"
    local preamble=""
    export ${prefix}layout="$default_layout"
    while read line; do
      if match "$line" "^$preamble_marker\$"; then
        export ${prefix}has_preamble=1
        eval "$preamble"
        break
      fi
      preamble="${preamble}export $prefix$line;"
    done < "$content_dir/$page"
  done
  # render pages
  for page in $pages; do
    url="$(url_for "$page")"
    log "$content_dir/$page --> $url"
    mkdir -p "$(dirname "${url#/}")" && include "$page" > "$url"
  done

  log "$content_dir/feed.xml --> $site_dir/feed.xml"
  include feed.xml > site/feed.xml

  log "$content_dir/*.css --> $site_dir/min.css"
  find $content_dir/ -name "*.css" -exec cat {} + | css_minify  >> "$site_dir/min.css"
}

development_server() {
  render_site || exit $?
  trap 'kill $server_pid;rm $timestamp; exit' SIGINT
  timestamp="$(mktemp)"
  # TODO ease python dependancy https://gist.github.com/willurd/5720255
  python -m SimpleHTTPServer 5000 & server_pid="$!"
  # check for changes every second and rebuild the site when necessary
  while sleep 1; do
    changed="$(cd $content_dir; find * -newer "$timestamp")"
    touch "$timestamp"
    [[ "$changed" ]] && render_site && log "reload complete: $changed" | tr "\n" " "
  done
}

## MAIN
case "${1:-${self##*/}}" in
  # link self as pre-commit hook
  init) ln -fs "$self" .git/hooks/pre-commit ;;
  # run as a precommit
  pre-commit) render_site || exit $?; git add site/ ;;
  render) render_site ;;
  *) development_server ;;
esac
