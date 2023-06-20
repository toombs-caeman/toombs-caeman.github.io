<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Markdown: Syntax</title>
    <link rel="stylesheet" href="/.main.css" type="text/css">
    <link rel="shortcut icon" href="/.favicon.jpg" type=image/x-icon">
    <script src="https://cdn.jsdelivr.net/gh/ncase/nutshell/nutshell.js"></script>
</head>
<body>
    <div class="page-content">
    
<h1>Markdown: Syntax</h1>
<p>
<ul>
<li>  <a href="#overview">Overview</a>
<ul>
<li>  <a href="#philosophy">Philosophy</a>
</li>
<li>  <a href="#html">Inline HTML</a>
</li>
<li>  <a href="#autoescape">Automatic Escaping for Special Characters</a>
</li></ul>  <a href="#block">Block Elements</a>
<ul>
<li>  <a href="#p">Paragraphs and Line Breaks</a>
</li>
<li>  <a href="#header">Headers</a>
</li>
<li>  <a href="#blockquote">Blockquotes</a>
</li>
<li>  <a href="#list">Lists</a>
</li>
<li>  <a href="#precode">Code Blocks</a>
</li>
<li>  <a href="#hr">Horizontal Rules</a>
</li></ul>  <a href="#span">Span Elements</a>
<ul>
<li>  <a href="#link">Links</a>
</li>
<li>  <a href="#em">Emphasis</a>
</li>
<li>  <a href="#code">Code</a>
</li>
<li>  <a href="#img">Images</a>
</li></ul>  <a href="#misc">Miscellaneous</a>
<ul>
<li>  <a href="#backslash">Backslash Escapes</a>
</li>
<li>  <a href="#autolink">Automatic Links</a>
</li></ul></li></ul><p>
<p>
<em>Note:</em> This document is itself written using Markdown; you
can <a href="./markdown.md">see the source for it by adding '.md' to the URL</a>.
<p>
<hr>
<p>
<h2>Overview</h2>
<p>
<h3>Philosophy</h3>
<p>
Markdown is intended to be as easy-to-read and easy-to-write as is feasible.
<p>
Readability, however, is emphasized above all else. A Markdown-formatted
document should be publishable as-is, as plain text, without looking
like it's been marked up with tags or formatting instructions. While
Markdown's syntax has been influenced by several existing text-to-HTML
filters -- including <a href="http://docutils.sourceforge.net/mirror/setext.html">Setext</a>, <a href="http://www.aaronsw.com/2002/atx/">atx</a>, <a href="http://textism.com/tools/textile/">Textile</a>, <a href="http://docutils.sourceforge.net/rst.html">reStructuredText</a>,
<a href="http://www.triptico.com/software/grutatxt.html">Grutatext</a>, and <a href="http://ettext.taint.org/doc/">EtText</a> -- the single biggest source of
inspiration for Markdown's syntax is the format of plain text email.
<p>
<h2>Block Elements</h2>
<p>
<h3>Paragraphs and Line Breaks</h3>
<p>
A paragraph is simply one or more consecutive lines of text, separated
by one or more blank lines. (A blank line is any line that looks like a
blank line -- a line containing nothing but spaces or tabs is considered
blank.) Normal paragraphs should not be indented with spaces or tabs.
<p>
The implication of the "one or more consecutive lines of text" rule is
that Markdown supports "hard-wrapped" text paragraphs. This differs
significantly from most other text-to-HTML formatters (including Movable
Type's "Convert Line Breaks" option) which translate every line break
character in a paragraph into a <code><br /></code> tag.
<p>
When you <b>do</b> want to insert a <code><br /></code> break tag using Markdown, you
end a line with two or more spaces, then type return.
<p>
<h3>Headers</h3>
<p>
Markdown supports two styles of headers, [Setext] [1] and [atx] [2].
<p>
Optionally, you may "close" atx-style headers. This is purely
cosmetic -- you can use this if you think it looks better. The
closing hashes don't even need to match the number of hashes
used to open the header. (The number of opening hashes
determines the header level.)
<p>
<p>
<h3>Blockquotes</h3>
<p>
Markdown uses email-style <code>></code> characters for blockquoting. If you're
familiar with quoting passages of text in an email message, then you
know how to create a blockquote in Markdown. It looks best if you hard
wrap the text and put a <code>></code> before every line:
<p>
> This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
> consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
> Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.
> 
> Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse
> id sem consectetuer libero luctus adipiscing.
<p>
Markdown allows you to be lazy and only put the <code>></code> before the first
line of a hard-wrapped paragraph:
<p>
> This is a blockquote with two paragraphs. Lorem ipsum dolor sit amet,
consectetuer adipiscing elit. Aliquam hendrerit mi posuere lectus.
Vestibulum enim wisi, viverra nec, fringilla in, laoreet vitae, risus.
<p>
> Donec sit amet nisl. Aliquam semper ipsum sit amet velit. Suspendisse
id sem consectetuer libero luctus adipiscing.
<p>
Blockquotes can be nested (i.e. a blockquote-in-a-blockquote) by
adding additional levels of <code>></code>:
<p>
> This is the first level of quoting.
>
> > This is nested blockquote.
>
> Back to the first level.
<p>
Blockquotes can contain other Markdown elements, including headers, lists,
and code blocks:
<p>
> ## This is a header.
> 
> 1.   This is the first list item.
> 2.   This is the second list item.
> 
> Here's some example code:
> 
>     return shell_exec("echo $input | $markdown_script");
<p>
Any decent text editor should make email-style quoting easy. For
example, with BBEdit, you can make a selection and choose Increase
Quote Level from the Text menu.
<p>
<p>
<h3>Lists</h3>
<p>
Markdown supports ordered (numbered) and unordered (bulleted) lists.
<p>
Unordered lists use asterisks, pluses, and hyphens -- interchangably
-- as list markers:
<p>
<ul>
<li>  Red
</li>
<li>  Green
</li>
<li>  Blue
</li></ul><p>
is equivalent to:
<p>
+   Red
+   Green
+   Blue
<p>
and:
<p>
<ul>
<li>  Red
</li>
<li>  Green
</li>
<li>  Blue
</li></ul><p>
Ordered lists use numbers followed by periods:
<p>
<ol>
<li> Bird
</li>
<li> McHale
</li>
<li> Parish
</li></ol><p>
It's important to note that the actual numbers you use to mark the
list have no effect on the HTML output Markdown produces. The HTML
Markdown produces from the above list is:
<p>
If you instead wrote the list in Markdown like this:
<p>
<ol>
<li> Bird
</li>
<li> McHale
</li>
<li> Parish
</li></ol><p>
or even:
<p>
<ol>
<li>Bird
</li>
<li>McHale
</li>
<li>Parish
</li></ol><p>
you'd get the exact same HTML output. The point is, if you want to,
you can use ordinal numbers in your ordered Markdown lists, so that
the numbers in your source match the numbers in your published HTML.
But if you want to be lazy, you don't have to.
<p>
To make lists look nice, you can wrap items with hanging indents:
<p>
<ul>
<li>  Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
    Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,
    viverra nec, fringilla in, laoreet vitae, risus.
</li>
<li>  Donec sit amet nisl. Aliquam semper ipsum sit amet velit.
    Suspendisse id sem consectetuer libero luctus adipiscing.
</li></ul><p>
But if you want to be lazy, you don't have to:
<p>
<ul>
<li>  Lorem ipsum dolor sit amet, consectetuer adipiscing elit.
Aliquam hendrerit mi posuere lectus. Vestibulum enim wisi,
viverra nec, fringilla in, laoreet vitae, risus.
</li>
<li>  Donec sit amet nisl. Aliquam semper ipsum sit amet velit.
Suspendisse id sem consectetuer libero luctus adipiscing.
</li></ul><p>
List items may consist of multiple paragraphs. Each subsequent
paragraph in a list item must be indented by either 4 spaces
or one tab:
<p>
<ol>
<li> This is a list item with two paragraphs. Lorem ipsum dolor
    sit amet, consectetuer adipiscing elit. Aliquam hendrerit
    mi posuere lectus.
</li></ol><p>
    Vestibulum enim wisi, viverra nec, fringilla in, laoreet
    vitae, risus. Donec sit amet nisl. Aliquam semper ipsum
    sit amet velit.
<p>
<ol>
<li> Suspendisse id sem consectetuer libero luctus adipiscing.
</li></ol><p>
It looks nice if you indent every line of the subsequent
paragraphs, but here again, Markdown will allow you to be
lazy:
<p>
<ul>
<li>  This is a list item with two paragraphs.
</li></ul><p>
    This is the second paragraph in the list item. You're
only required to indent the first line. Lorem ipsum dolor
sit amet, consectetuer adipiscing elit.
<p>
<ul>
<li>  Another item in the same list.
</li></ul><p>
To put a blockquote within a list item, the blockquote's <code>></code>
delimiters need to be indented:
<p>
<ul>
<li>  A list item with a blockquote:
</li></ul><p>
    > This is a blockquote
    > inside a list item.
<p>
To put a code block within a list item, the code block needs
to be indented <b>twice</b> -- 8 spaces or two tabs:
<p>
<ul>
<li>  A list item with a code block:
</li></ul><p>
        <code goes here>
<p>
<h3>Code Blocks</h3>
<p>
Pre-formatted code blocks are used for writing about programming or
markup source code. Rather than forming normal paragraphs, the lines
of a code block are interpreted literally. Markdown wraps a code block
in both <code><pre></code> and <code><code></code> tags.
<p>
To produce a code block in Markdown, simply indent every line of the
block by at least 4 spaces or 1 tab.
<p>
This is a normal paragraph:
<p>
    This is a code block.
<p>
Here is an example of AppleScript:
<p>
    tell application "Foo"
        beep
    end tell
<p>
A code block continues until it reaches a line that is not indented
(or the end of the article).
<p>
Within a code block, ampersands (<code>&</code>) and angle brackets (<code><</code> and <code>></code>)
are automatically converted into HTML entities. This makes it very
easy to include example HTML source code using Markdown -- just paste
it and indent it, and Markdown will handle the hassle of encoding the
ampersands and angle brackets. For example, this:
<p>
    <div class="footer">
        &copy; 2004 Foo Corporation
    </div>
<p>
Regular Markdown syntax is not processed within code blocks. E.g.,
asterisks are just literal asterisks within a code block. This means
it's also easy to use Markdown to write about Markdown's own syntax.
<p>
<code></code><code>
tell application "Foo"
    beep
end tell
</code><code></code>
<p>
<h2>Span Elements</h2>
<p>
<h3>Links</h3>
<p>
Markdown supports two style of links: <b>inline</b> and <b>reference</b>.
<p>
In both styles, the link text is delimited by [square brackets].
<p>
To create an inline link, use a set of regular parentheses immediately
after the link text's closing square bracket. Inside the parentheses,
put the URL where you want the link to point, along with an <b>optional</b>
title for the link, surrounded in quotes. For example:
<p>
This is <a href="http://example.com/">an example</a> inline link.
<p>
<a href="http://example.net/">This link</a> has no title attribute.
<p>
<h3>Emphasis</h3>
<p>
Markdown treats asterisks (<code>*</code>) and underscores (<code>_</code>) as indicators of
emphasis. Text wrapped with one <code>*</code> or <code>_</code> will be wrapped with an
HTML <code><em></code> tag; double <code>*</code>'s or <code>_</code>'s will be wrapped with an HTML
<code><strong></code> tag. E.g., this input:
<p>
<b>single asterisks</b>
<p>
_single underscores_
<p>
<em>double asterisks</em>
<p>
__double underscores__
<p>
<h3>Code</h3>
<p>
To indicate a span of code, wrap it with backtick quotes (<code></code> <code> </code><code>).
Unlike a pre-formatted code block, a code span indicates code within a
normal paragraph. For example:

Use the </code>printf()` function.
    </div>
    <hr>
    <footer>
        <div style=text-align:center>
            <a href="mailto:toombs.caeman@gmail.com"> <img class="icon" src="/.mail.svg" alt="email"></a>
            <a href="https://github.com/toombs-caeman"> <img class="icon" src="/.github.svg" alt="github"></a>
        </div>
    </footer>
</body>
</html>