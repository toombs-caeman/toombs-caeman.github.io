# About the Site

This is mostly a public reflection of things I've written in my physical notebooks. I'm a fan of first thinking with [pen and paper](pens.md).

The visual style of the site is meant to emulate writing in a Rhodia Sapphire dot-grid notebook
with Waterman's Serenity Blue or Pilot's Iroshizuku Kon-peki ink, though I've limited myself to [css named colors](https://www.w3schools.com/cssref/css_colors.asp). The font is [comic mono](https://dtinth.github.io/comic-mono-font/).


## Hosting & Rendering
This site is hosted on [github](https://github.com/toombs-caeman/toombs-caeman.github.io) currently. The content is not and probably never will be interactive, so pages are rendered statically.

Rendering is done with a [nushell](https://www.nushell.sh/) script delegating the heavy lifting to the [mustach](https://gitlab.com/jobol/mustach/) and [md4c](https://github.com/mity/md4c) packages for [mustache templating](https://mustache.github.io/) and [markdown rendering](https://github.github.com/gfm/)

Rendered files are saved in git so that the deployed site is totally static.

## Directory Structure
Scripts used to render and test the site are in `/bin/`. 
The original markdown in `/src/` is rendered into `/`. 
Static files (which shouldn't be rendered at all) are in `/inc/`

In general, [short urls](https://sive.rs/su) are preferred.

There are a lot of half-written and/or broken pages floating around that simply aren't linked from the main page. You could find them if you cared to, simply by looking at the source files on github. I don't care to keep that truly hidden.

## Why
* [pg on words](http://www.paulgraham.com/words.html)
* [blogging myths](https://jvns.ca/blog/2023/06/05/some-blogging-myths/)
* [why write](https://bastian.rieck.me/blog/posts/2023/writing_why/)
