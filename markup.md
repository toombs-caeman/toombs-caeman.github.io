{{?.note}}
# μ

μ (a.k.a. MU a.k.a. Mark Up a.k.a. Made Up) is a markup/templating language heavily inspired by [markdown](https://www.markdownguide.org/basic-syntax/) and [moustache templating](http://mustache.github.io/mustache.5.html), that is being slapped together on the fly to build this site.

**Note:** This document is itself written using μ; you can see the source for it by replacing '.html' with '.md' in the URL.

μ is intended to be as easy-to-read, easy-to-code, and easy-to-write as is feasible.
Unlike markdown, μ provides only a single way to create most elements.

μ has a single [canonical implementation](blog.sh) which defines the 'standard'. This file is more of a test bed for new features than any attempt at definition.

## Block Elements

### Paragraphs and Line Breaks

A paragraph is simply one or more consecutive lines of text, separated
by one or more blank lines. 

### Horizontal Rules
Horizontal Rules are three or more `-` or `=` on a line by themselves.

----

### Headers

μ headers begin with one or more `#` on a newline followed by a space, and continue to the end of the line. The number of opening hashes determines the header level.

### Lists

μ supports ordered (numbered) and unordered (bulleted) lists.

Unordered lists use asterisks, pluses, and hyphens -- interchangably -- as list markers:

*   Red
+   Green
-   Blue

Ordered lists use numbers followed by periods:

4.  Bird
2.  McHale
0.  Parish

The actual numbers you use to mark the list have no effect on the HTML output μ produces.

To make lists look nice, you can wrap items with hanging indents, but you don't have to.

*   Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,
    viverra nec, fringilla in, laoreet vitae, risus.
*   Donec sit amet nisl. Aliquam semper ipsum sit amet velit.
Suspendisse id sem consectetuer libero luctus adipiscing.

List nesting is determined by tab-level

1. first level
    * second level, and unordered
2. first level again

### Code Blocks

μ wraps a code block in both `<pre>` and `<code>` tags.

Regular μ syntax is not processed within code blocks. E.g.,
asterisks are just literal asterisks within a code block. This means
it's also easy to use μ to write about μ's own syntax.

```
tell application "Foo"
    beep
end tell
```

## Span Elements

### HTML Attributes
μ enables html elements to use a shorthand for attributes similar to css.
* `.title .important` becomes `class="title important"`
* `#bourne` becomes `id="bourne"`

### Links and Images

μ supports links like `[an example](http://example.com/ .exampleclass)` [an example](https://example.com/ .exampleclass).

images follow the same convention, with a prefix `!` `![an example image](.favicon.jpg width="30" height="30")`.

![an example image](.favicon.jpg width="30" height="30")

[^footnotes]

[^footnotes]:
A footnote `[^note]` is translated into a nutshell link to a marker `[:note](#note)` which jumps to the note.
The corresponding `[^note]:` marker is translated into a hidden nutshell section.

### More Span Elements
Surrounding text with the following marks generates these elements:
* *single asterisks* - `<em>`
* :joy: - emojis from short names (this one is `:joy:`). Not sure I like this, but it works.
* **double asterisks** - `<b>`
* ~~double tilde~~ - `<del>`
* ^^double carets^^ - `<sup>`
* __double underscores__ - `<sub>`
    * ^^over^^__under__ - putting superscript directly before subscript will wrap both in `<span .supsub>`, which can be made to appear one above the other with a little css. This specifically looks for `^^__` with no space between.
* `single backtick` - wraps in `<code>`, also escapes contents

## Templating
* `{{?layout}}` indicates that what follows should use the file `layout` to wrap the rendered output
*  `{{.}}` indicates that the wrapped content should be placed here
* `{{!comments}}` is a comment. It isn't included in the output html like `<!--comments-->`. I might remove this later
* `{{>include.md}}` - file `include.md` should be rendered and inlined here.
* `{{var}}` - insert value of environment variable

