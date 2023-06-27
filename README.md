{{?.note}}
# About the Site

## Concept
This is mostly a public reflection of things I've written in my physical notebooks. I'm a fan of first thinking with [:pen and paper](pens) (and privately).

The visual style of the site is meant to emulate writing in a Rhodia Sapphire dot-grid notebook
with Waterman's Serenity Blue or Pilot's Iroshizuku Kon-peki ink, though I've limited myself to [css named colors](https://www.w3schools.com/cssref/css_colors.asp). The font is [comic mono](https://dtinth.github.io/comic-mono-font/).


## Hosting & Rendering
This site is hosted on [github](https://github.com/toombs-caeman/toombs-caeman.github.io) currently. The content is not and probably never will be interactive, so pages are rendered statically.

The format I write in is mostly [markdown](https://www.markdownguide.org/basic-syntax/) with a touch of [moustache templating](http://mustache.github.io/mustache.5.html), though it isn't fully compatible with either.
Rendering to html is done through a [:pure bash](#why-bash) [script](blog.sh).
{{! if you're reading the markdown, this is a comment gets removed during rendering. The first line of the file says to use the .note layout}}

## Directory Structure

Rendered html is saved in [:git](#history) alongside the markdown that generated it. I'm trying to keep everything in a single folder for now. [Short urls](https://sive.rs/su) are better.
Layout templates and other static resources (images, css, etc.) are hidden files. Mostly I want to focus on the writing when I'm poking around the project directly.

#### :x why-bash
[:I started learning bash because it was available.](#omni) However, bash sucks, and it's a bit masochistic to use it for anything more than one-liners you copy off of stackoverflow. The syntax is crusty (verbose) and full of warts (bad defalts). Just look at parameter expansion: It's extremely common, verbose, has terrible and unpredictable default behaviors, etc, etc. Don't even get me started on arrays.

Another problem is its age, which means that searching for advice often leads to 'accepted answers' which use features either too new or too old to apply to your situation. It doesn't help that for a while macs were stuck with an ancient version of bash for licensing reasons.
It's a common problem with unix utilities which have many different implementations and varieties of extensions (here's looking at you, gnu). A found script for `awk` cannot be expected to work 100% of the time with the binary called `awk` on your machine.

What's more, sometimes I use `zsh`, which is incredibly similar, but different enough that you can't just copy scripts over and expect them to work. Also search engines can't seem to tell the difference between them.

On the other hand, this isn't a serious project and you can't stop me.

#### :x omnipresence
Bash is everywhere. Bash is nowhere.

Every device you're likely to be working on has bash. Except Macs, which use zsh. And Windows that has powershell. And Debian based stuff which uses dash. And little docker images which use sh. And BSD which uses chsh.


#### :x history
mixing build artifacts into the source history!? Oh my...

#### :x motivation?
[blogging myths](https://jvns.ca/blog/2023/06/05/some-blogging-myths/)

#### :x fellows
[peppe.rs](https://peppe.rs/posts/static_sites_with_bash/)
