# these functions will be available when rendering the site
# but aren't directly/necessarily used by blog.sh

# get the date formatted according to rfc822
rfc822() { date -R ${1:+-jf %Y-%m-%d $1}; }

li_date_page() {
  date="$(? $1 date)" && echo "<li>[](/${1:-$page})<span class=\"date\">$date</span>"
}

