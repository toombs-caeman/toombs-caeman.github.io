TL;DR: **blog.sh** is a simple static site generator built to last decades

Here I'll describe the code that builds this site and why I do it this way.
If you want to know why it does what it does, read the Meta page.

In some sense this is total [bikeshedding](https://en.wikipedia.org/wiki/Law_of_triviality)
but I want a note-taking tool that will last a lifetime with minimal fuss.
For all its warts, bash 
    has been available on every computer I've owned with no installation,
    doesn't change, 
    and is likely to stick around (its already older than me).
    
This has no 'magic' hidden in dependencies which may disappear.
A rule of thumb I've been thinking about recently is "Could I reasonably read just the source and do what it does by hand?".
Code is 'simple' if I could (not that I would ever want to).
If I can't, then either I don't understand it fully, or it relies on hidden complexity in the ecosystem.

## Features Present and Future
* implements Markdown's [Basic Syntax](https://www.markdownguide.org/cheat-sheet/#basic-syntax)
* allow css-like syntax to be added to html tags, headers, links, and images
    * additional html attributes are added to headers links and images after |
    * `.cls .cls2` -> class='cls cls2'
    * `#my-id` -> id='my-id'
    * (todo) give a full write up on what this means
* the macro language is bash.
    * good and bad. There isn't a new language to learn, but bash has plenty of footguns.
    * At the time of writing `jinja2` is the popular macro language of choice.
        As a text transformation DSL it's convenient, but doesn't allow for more powerful macros unless you extend it
        using its host language (typically python). Jinja2 is why I chose double curly brackets to delimit macros.
* includes a development mode that spins up a local test server and rebuilds changes on the fly.
    * (todo) current method of watching for changes is janky
    * (todo) generalize using any of these [one-line servers](https://gist.github.com/willurd/5720255).
* integrates with git
    * pages are dated by when they were first committed
    * generated artifacts are committed as part of the included pre-commit hook
        - this allows any dumb webserver to serve the project root folder and make a functional site.
        - also works with [github pages](https://pages.github.com/), bypassing their special sauce to avoid lock in.
* automatically cross-link pages that refer to the title of other pages
    - (todo) also use link anchors so that following the cross-link jumps to the part of the page
* (todo) nginx logs can be captured to provide [unique visitors stats](https://serverfault.com/questions/447370/how-to-count-unique-visitors-in-an-nginx-access-log)
    * assuming I leave github for whatever reason.
    * would be sufficient to see that people are interested without tracking your every move.
* (todo) figure out how to join background processes to do concurrent content rendering
* a real color scheme
* hack together a css macro/framework for [animations](https://medium.com/@dtinth/spring-animation-in-css-2039de6e1a03)
    * need to enable macros in css files
* (todo) add [tag filters](https://webdesign.tutsplus.com/tutorials/how-to-build-a-filtering-component-in-pure-css--cms-33111)
    to group and filter the index


## Mechanics
### bash parameter expansion
Bash [parameter expansion](https://wiki-dev.bash-hackers.org/syntax/pe) can be tricky.
Array variables are expanded using ${array[0]}, where 0 is an index into an array, or @ to indicate
that it should expand everything.
$array is equivalent to ${array[0]}
### invoking (self)
$BASH_SOURCE is a builtin variable that contains the name of the invoked bash file, as it was invoked.
if
### rendering
rendering happens in a few stages:
1. the content directory is searched recursively to collect markdown and html files to render into pages.
2. metadata for each page is collected.
    * this is done separately from rendering the content, so consistent across each rendered page.
3. the content of each page is rendered
4. the final render pass for each page
    1. cross-links are added to the end
    2. the content is placed into a layout
### page scoped variables (V)
Scoping is weird in bash. Functions and variables have distinct scopes.
Variables have a function local scope and a global scope. Functions are global.
There is nothing approximating an object scope (unless you count associative arrays, which are a pain).

I've created a psudo-scope based on pages that is accessed using the function `V()`.
It works by constructing variable names with a prefix and placing them in global scope.
### regex (M)
blog.sh makes heavy use of
    [bash regular expression](https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html#Pattern-Matching)
    matching ([BASH_REMATCH](https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html#index-BASH_005fREMATCH))
    which has been given the function name `M()` for brevity and to hide a few warts.
### list stack (tab_re)

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
    
## References
* design
    * [Website Obesity Crisis](https://idlewords.com/talks/website_obesity.htm)
    * [Cool URIs don't change](https://www.w3.org/Provider/Style/URI)
    * [omitting html tags](https://google.github.io/styleguide/htmlcssguide.html#Optional_Tags)
