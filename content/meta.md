title: Meta
===

<blockquote cite="somebody.somewhere"-> You **NEED** to use Jekyll | Wordpress | Ghost | etc. in order to maintain your blog! \
	-- Somebody, probably
Well if you want to enjoy the experience, then maybe. But if you'd rather watch on forlornly as sections of your site break
for no apparent reason and spend hours upon hours debugging regular expressions when you could be watching grass grow then have I got just the thing for you.

Introducing [blog.sh](https://github.com/toombs-caeman/toombs-caeman.github.io/blob/master/blog.sh),
a static site generator that's pure bs (bourne shell).
As a single bash file with zero dependencies weighing in at `wc -l < blog.sh` lines this is the best way to put your website rendering on a diet.
I'm doing my part to fend off the [Website Obesity Crisis](https://idlewords.com/talks/website_obesity.htm).

This site is served using blog.sh and [github pages](https://pages.github.com/). It is entirely static.
There's no server side processing (pages are rendered during pre-commit), no client side javascript
(not even for the burger animation, though blog.sh doesn't forbid that), and no tracking/analytics.

If I ever have to move away from github for some reason, the site could be hosted as simply as nginx or httpd serving an up-to-date copy of the repository.
Nginx logs can be captured to provide [unique visitors](https://serverfault.com/questions/447370/how-to-count-unique-visitors-in-an-nginx-access-log),
which would be sufficient for me to see that people are interested without tracking your every move.

## Features
* text transformation
    * implements Markdown's [Basic Syntax](https://www.markdownguide.org/cheat-sheet/#basic-syntax)
    * yaml style front matter (===)
    * the macro language is bash instead of the more common and more sensible jinja (have fun lol)
    * allow css-like syntax to be added to html tags, headers, links, and images
    * (todo) [tag filters](https://webdesign.tutsplus.com/tutorials/how-to-build-a-filtering-component-in-pure-css--cms-33111)
    * (todo) automatically cross-link pages that refer to the title of other pages
        - also use link anchors so that following the cross-link jumps to the part of the page
* tools
    * integrates nicely with git to auto-commit generated files (normal form purists can get bent).
        This allows you to serve the site very simply from just a clone of the repository
    * will watch for changes and re-render the site


## References
* mechanics
    * [bash regex](https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html#Pattern-Matching)
    * [bash parameter expansion](https://wiki-dev.bash-hackers.org/syntax/pe)
    * [Markdown Cheat Sheet](https://www.markdownguide.org/cheat-sheet/)
* cleanliness
    * [Cool URIs don't change](https://www.w3.org/Provider/Style/URI)
    * [omitting html tags](https://google.github.io/styleguide/htmlcssguide.html#Optional_Tags)


## future site updates
* a real color scheme
* fix rss
* generalize the development server using any of these [one-line servers](https://gist.github.com/willurd/5720255).

## abandoned ideas
probably bad ideas that I'm writing down so I won't think about them anymore:
* is it possible / not against TOS to kluge a github issue into providing a place for comments on the posts?
    - I don't really want to tie blog.sh directly to github, but I also don't want to write that myself in bash. I've
        been through enough.
    - CORS probably won't allow something like an iframe to include the issue thread, but just a link would do.
    - Disqus is another option... but ads and external dependencies... yuck
* *busybox* only rendering
    - call it *b.sh* and play a bit of [golf](https://code.golf/) to really play up the absurd hyper minimalism
    - requires moving from bash to ash/dash, which doesn't have the =~ match operator
    - since this is really the hyper minimal case, don't even do git stuff
    - need to verify that the output is the same
