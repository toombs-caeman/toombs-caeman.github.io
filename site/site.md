<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Site</title>
</head>
<body>
<div .page-content>
<p>TL;DR: <strong>blog.sh</strong> is a simple static site generator built to last decades</p>
<p>Here I'll describe the code that builds this site and why I do it this way.
If you want to know why it does what it does, read the Meta page.</p>
<p>In some sense this is total <a href="https://en.wikipedia.org/wiki/Law_of_triviality">bikeshedding</a>
but I want a note-taking tool that will last a lifetime with minimal fuss.
For all its warts, bash 
    has been available on every computer I've owned with no installation,
    doesn't change, 
    and is likely to stick around (its already older than me).</p>
<p>This has no 'magic' hidden in dependencies which may disappear.
A rule of thumb I've been thinking about recently is "Could I reasonably read just the source and do what it does by hand?".
Code is 'simple' if I could (not that I would ever want to).
If I can't, then either I don't understand it fully, or it relies on hidden complexity in the ecosystem.</p>
<h2>Features Present and Future</h2>
<p>separate into a few components
    * baffle - load data/ jinja templating
    * barkdown - render a markdown dialect that's mostly the <a href="https://www.markdownguide.org/cheat-sheet/#basic-syntax">Basic Syntax</a>
    * blog - tie everything else together</p>
<p>this lets there be reuse between here and ricer
* allow css-like syntax to be added to html tags, headers, links, and images
    * additional html attributes are added to headers links and images after |
    * <code>.cls .cls2</code> -&gt; class='cls cls2'
    * <code>#my-id</code> -&gt; id='my-id'
    * (todo) give a full write up on what this means
* the macro language is bash.
    * good and bad. There isn't a new language to learn, but bash has plenty of footguns.
    * At the time of writing <code>jinja2</code> is the popular macro language of choice.
        As a text transformation DSL it's convenient, but doesn't allow for more powerful macros unless you extend it
        using its host language (typically python). Jinja2 is why I chose double curly brackets to delimit macros.
* integrates with git
    * pages are dated by when they were first committed
    * generated artifacts are committed as part of the included pre-commit hook
        - this allows any dumb webserver to serve the project root folder and make a functional site.
        - also works with <a href="https://pages.github.com/">github pages</a>, bypassing their special sauce to avoid lock in.
* automatically cross-link pages that refer to the title of other pages
    - (todo) also use link anchors so that following the cross-link jumps to the part of the page
* (todo) nginx logs can be captured to provide <a href="https://serverfault.com/questions/447370/how-to-count-unique-visitors-in-an-nginx-access-log">unique visitors stats</a>
    * assuming I leave github for whatever reason.
    * would be sufficient to see that people are interested without tracking your every move.
* a real color scheme
* hack together a css macro/framework for <a href="https://medium.com/@dtinth/spring-animation-in-css-2039de6e1a03">animations</a>
    * need to enable macros in css files
* <a href="https://webdesign.tutsplus.com/tutorials/how-to-build-a-filtering-component-in-pure-css--cms-33111">tag filters</a>
    to group and filter the index
* (todo) <a href="https://gist.github.com/cyrusboadway/5a7b715665f33c237996">auto-update google dns</a>
* /now page
* SVG pipeline for images
  * <a href="https://github.com/esimov/triangle">triangles</a>
  * PCA to find delta between raw image and current svg, draw an overlapping transparent triangle, then repeat
    * what if we use unicode instead of triangles
  * <a href="https://tendigits.space/site/imageswap.html">img swap</a>
  * </p>
<h2>Mechanics</h2>
<h3>bash parameter expansion</h3>
<p>Bash <a href="https://wiki-dev.bash-hackers.org/syntax/pe">parameter expansion</a> can be tricky.
Array variables are expanded using ${array[0]}, where 0 is an index into an array, or @ to indicate
that it should expand everything.
$array is equivalent to ${array[0]}</p>
<h3>invoking (self)</h3>
<p>$BASH_SOURCE is a builtin variable that contains the name of the invoked bash file, as it was invoked.
if</p>
<h3>rendering</h3>
<p>rendering happens in a few stages:
1. the content directory is searched recursively to collect markdown and html files to render into pages.
2. metadata for each page is collected.
    * this is done separately from rendering the content, so consistent across each rendered page.
3. the content of each page is rendered
4. the final render pass for each page
    1. cross-links are added to the end
    2. the content is placed into a layout</p>
<h3>page scoped variables (V)</h3>
<p>Scoping is weird in bash. Functions and variables have distinct scopes.
Variables have a function local scope and a global scope. Functions are global.
There is nothing approximating an object scope (unless you count associative arrays, which are a pain).</p>
<p>I've created a psudo-scope based on pages that is accessed using the function <code>V()</code>.
It works by constructing variable names with a prefix and placing them in global scope.</p>
<h3>regex (M)</h3>
<p>blog.sh makes heavy use of
    <a href="https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html#Pattern-Matching">bash regular expression</a>
    matching (<a href="https://www.gnu.org/software/bash/manual/html_node/Bash-Variables.html#index-BASH_005fREMATCH">BASH_REMATCH</a>)
    which has been given the function name <code>M()</code> for brevity and to hide a few warts.</p>
<h3>list stack (tab_re)</h3>
<h2>abandoned ideas</h2>
<p>probably bad ideas that I'm writing down so I won't think about them anymore:
* is it possible / not against TOS to kluge a github issue into providing a place for comments on the posts?
    - I don't really want to tie blog.sh directly to github, but I also don't want to write that myself in bash. I've
        been through enough.
    - CORS probably won't allow something like an iframe to include the issue thread, but just a link would do.
    - Disqus is another option... but ads and external dependencies... yuck
* <em>busybox</em> only rendering
    - call it <em>b.sh</em> and play a bit of <a href="https://code.golf/">golf</a> to really play up the absurd hyper minimalism
    - requires moving from bash to ash/dash, which doesn't have the =~ match operator
    - since this is really the hyper minimal case, don't even do git stuff</p>
<h2>References</h2>
<ul>
<li>design<ul>
<li><a href="https://idlewords.com/talks/website_obesity.htm">Website Obesity Crisis</a></li>
<li><a href="https://www.w3.org/Provider/Style/URI">Cool URIs don't change</a></li>
<li><a href="https://google.github.io/styleguide/htmlcssguide.html#Optional_Tags">omitting html tags</a></li>
</ul>
</li>
</ul></div>

</body>
</html>