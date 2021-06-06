#!/bin/bash

## Notes

# special vars available in rendering
#   $pages - a space seperated list of filenames to be rendered
#   $page - refers to the current filename (corresponding to an output url) being rendered
#     $page doesn't get updated for includes or layouts
#   $url - refers to the current url being rendered

## CONFIG
content_dir="content"
site_dir="site"
helper_script="helpers.sh"
preamble_marker="==="

## PRE-CHECKS

# reference to the name of this file as it was invoked
# this is exploited later to figure out if we're being run as a git pre-commit
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

# TODO all these long match statements could really use some english explanation

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

## CORE FUNCTIONS

indent() {
  local indent_s indent_t pre
  # determine if there's a new list element (ordered or unordered)
  if match "$line" '^( *)([-*]|[0-9]+\.) '; then
    line="${line#"${match[0]}"}"
    indent_s="${#match[1]}"
    # determine if list is ordered or unordered
    if match "${match[2]}" "[0-9]"; then indent_t=o; else indent_t=u; fi
  else
    if match "$line" '^([-*]*)$'; then
      # close everything if there's an empty line or horizontal rule
      indent_s=-1
      if (( ${#match[0]} )); then line="<hr>"; else line="<p>"; fi;
    else
      # this function exists separately so that this return can be effectively a goto
      return
    fi
  fi
  # add closing tags
  while match "$indent" '([uo])([0-9]*)' && [[ "$indent_s" -lt "${match[2]:-(-1)}" ]]; do
    indent="${indent#"${match[0]}"}"
    pre="$pre</${match[1]}l>"
  done
  # add opening tag
  if match "$indent" '([uo])([0-9]*)'; [[ "$indent_s" -gt "${match[2]:-(-1)}" ]]; then
    indent="$indent_t$indent_s$indent"
    pre="$pre<${indent_t}l>"
  fi
  [[ -n "$indent_t" ]] && pre="$pre<li>"
  line="$pre$line"
}

include() {
  local tmp macro layout close line2 id class attr preamble
  tmp="$(mktemp)" macro="$(mktemp)" layout=""
  preamble="$(? "$1" has_preamble)"
  while IFS= read line; do
    # drop the preamble if there is one
    if [[ -n "$preamble" ]]; then match "$line" "^$preamble_marker\$" && preamble=''; continue; fi
    # list
    indent
    # TODO bold asterisk?
    # header
    if match "$line" '^([[:space:]]*)([#]+)' ; then line="${match[1]}<h${#match[2]}->${line#"${match[0]}"}"; fi
    # link
    while match "$line" '^([^]]*)\[([^]]+)\]\(([^)]*)\)'; do
      line="${match[1]}<a target=\"_blank\" href=\"${match[3]}\">${match[2]}</a>${line#"${match[0]}"}"
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
  for page in $pages; do
    local prefix="page_${page//[.\/ ]/_}_"
    local preamble=""
    while read line; do
      # log "$preamble";
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
  # TODO I'd like to remove the python dependancy
  #      it is *technically* possible to serve a website using curl after all
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
