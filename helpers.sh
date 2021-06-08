# these functions will be available when rendering the site
# but aren't directly/necessarily used by blog.sh

# get the date formatted according to rfc822
rfc822() { date -R ${1:+-jf %Y-%m-%d $1}; }

# get a link to an internal page
page_link() { echo "<a href=\"/$(url_for ${1:-$page})\">$(? $1 title || echo "${1:-$page}")</a>"; }


li_date_page() {
  date="$(? $1 date)" && echo "<li>[](/${1:-$page})<span class=\"date\">$date</span>"
}

