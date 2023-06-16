{{?.layout.html}}
# Site
all about this site

## Concept
This is mostly a public reflection of things I've written in my physical notebooks. I'm a fan of first thinking with pen and paper (and privately).

## Visual Style
This site is meant to emulate writing in a Rhodia Sapphire dot-grid notebook
with Waterman's Serenity Blue or Pilot's Iroshizuku Kon-peki ink, though I've limited myself to [css named colors](https://www.w3schools.com/cssref/css_colors.asp). The font is [comic mono](https://dtinth.github.io/comic-mono-font/).

## Folders vs Tags vs Links
In the messy world of ideas, I've found that categorizing things is a struggle.

The idea of tagging generally implies a duality between the task of generating content and categorizing it. One side or the other inevitably gets neglected, and ultimately it's a [:false duality](tao#42) anyway, since metadata is just data. What happens if you have thoughts on the category as a whole? Is there a privileged `index` which is somehow special?

Folders are like tags but worse, since they also enforce an unwarrented heirarchy.

The websites are naturally a link based media, but I find it suits my thinking even when writing with pen and paper. All my notebooks, going back years, are numbered sequentially and all pages are numbered. 'Links' are in the form `7.71` (71st page of the 7th book). Its quick and easy to write.

Generally on the web a users has the option to explore links in tabs (spatially) or by backtracking through the history (temporal). Tabs struggle because the spatial metaphor gets collapsed to one dimension. Backtracking isn't great either since whole branches of history can easily be lost accidentally.
I am using [nutshell](https://ncase.me/nutshell/) to turn links into expandable sections, which expands the spatial metaphor.


## Hosting & Rendering
This site is hosted on [github](https://github.com/toombs-caeman/toombs-caeman.github.io) currently. The content is not and probably never will be interactive, so pages are rendered statically.

The format I write in is mostly [markdown](https://www.markdownguide.org/basic-syntax/) with a touch of [moustache](http://mustache.github.io/mustache.5.html) templating, though it isn't fully compatible with either.
Rendering to html is done through a [:pure bash](#why-bash) [script](./sta.sh).


Rendered html is saved in [:git](#history) right alongside the markdown that generated it.
Templates and other static resources (images, css, etc.) are hidden files. Mostly I want to focus on the writing when I'm poking around the project directly.

#### :x why-bash
[:I started learning bash because it was available.](#omni) But it really sucks, and it's a bit masochistic to use it for anything more than one-liners you copy off of stackoverflow. The syntax is crusty (verbose) and full of warts (bad defalts). Just look at parameter expansion: It's extremely common, verbose, has terrible and unpredictable default behaviors, etc, etc. Don't even get me started on arrays.

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
