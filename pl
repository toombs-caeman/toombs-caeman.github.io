<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="shortcut icon" href="/inc/favicon.jpg" type=image/x-icon">

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/inc/common.css" type="text/css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/comic-mono@0.0.1/index.min.css">
</head>

<body>
    <script src="https://cdn.jsdelivr.net/npm/mermaid@11.4.1/dist/mermaid.min.js"></script>
    <script src="/inc/common.js"></script>
    <div class="cover">
        <div class="page">
            <a class="bookmark" href="/"></a>
            <h1>Programming Language Design</h1>
<p>What ought to be considered when designing a programming language?
While it can be fun to make a language focused on a single aspect for a side project with a single user, language designers need to consider a vast array of things in order to create a language with wide appeal. A new language must bring something new to the table in order to compete, while at the same time providing the niceties expected of an established language.</p>
<p>What follows is a list of things to consider, which aims to be more or less exhaustive. Users will typically decide whether or not to use a language based on one or more of these considerations. This is not to say that its pointless to make a language without considering all these aspects. Language design can be a challenge and satisfying for its own sake.</p>
<h2>Basis</h2>
<p>What is the core reason for this language to exist and be used?</p>
<p>Possible reasons include:</p>
<ul>
<li>It solves problems within a given domain better than a general language.</li>
<li>It solves a particular gripe about developing in another language.</li>
<li>It has platform exclusivity (like javascript in the browser).</li>
<li>It was fun to build.</li>
<li>It is fun to use.</li>
<li>A bad case of <a href="https://en.wikipedia.org/wiki/Not_invented_here">NIH syndrome</a></li>
<li>It encourages solving problems in a novel way.</li>
<li>It eliminates certain classes of programming errors.</li>
<li>It is easy to port.</li>
<li>It is small, and therefore easy to grok.</li>
<li>It is large, and therefore can do everything.</li>
<li>It introduces novel or experimental features.</li>
</ul>
<p>Clearly, not every language needs all of these reasons to exist, and some reasons contradict others. The point is that a new language should have at least one.</p>
<h2>Semantics</h2>
<ul>
<li>What <a href="https://en.wikipedia.org/wiki/Programming_paradigm">programming paradigms</a> are supported? Which are encouraged?</li>
<li>What are the built-in types?</li>
<li><a href="https://en.wikipedia.org/wiki/First-class_function">first class functions?</a></li>
<li>What metaprogramming or preprocessor is available?<ul>
<li><a href="https://en.wikipedia.org/wiki/Homoiconicity">homoiconicity?</a></li>
<li>Is the preprocessor language the same as the full language, a subset, or totally distinct?</li>
</ul>
</li>
<li>concurrency? parallelism? async? system threads vs language threads<ul>
<li>how is state safely shared between threads?</li>
</ul>
</li>
<li>type system? static? dynamic (duck)? hinting?<ul>
<li>Implicit casting?</li>
<li>Implicit broadcasting/ <a href="https://futhark-lang.org/blog/2024-06-17-automap.html">function lifting?</a></li>
<li>Generics?</li>
</ul>
</li>
<li>What happens when a computation has no result? do you have (Null nil NaN None)?</li>
<li>What values are considered false (perhaps null, 0, '')?</li>
<li>What scopes are there? how are names resolved?<ul>
<li>how does global scope behave? especially when multithreaded</li>
<li>lexical(static) vs dynamic scope, closures</li>
<li>do you have file-local or other scopes?</li>
<li>How do you reference libraries and/or code in the same project but a different file?</li>
</ul>
</li>
<li>Statements vs expressions</li>
<li>what flow control structures</li>
<li>manual memory management or garbage collection?</li>
</ul>
<h2>Syntax</h2>
<ul>
<li>How familiar/weird is the syntax? What's the closest extant language or language family?</li>
<li>How does the syntax support/enforce the dominant paradigms?<ul>
<li>usually syntax used heavily in the dominant paradigm is shorter</li>
</ul>
</li>
<li>How visually distinct are distinct language constructs?<ul>
<li>Are similar constructs visually similar?</li>
<li>visual similarity here is informally related to edit distance. How much typing is needed to make a subtle semantic change?</li>
</ul>
</li>
<li>What are the worst cases? What constructs are unweildy, hard to read, write, or edit?<ul>
<li>deeply nested loops or lists? repeated function applications?</li>
<li>Are parts of the language &quot;write only&quot;?</li>
</ul>
</li>
<li>How semanticaly dense is the syntax (on a scale of Java to APL)?</li>
<li>Does the &quot;flow&quot; of an expression move cleanly left-to-right or right-to-left<ul>
<li>Does the order that things happen match the order in which they would be read?</li>
<li>personally it's a bit confusing when the first thing that happens is in the middle.</li>
<li>like Endian-ness, but for expressions</li>
</ul>
</li>
<li>Does your language use hard to type symbols (like APL)?<ul>
<li>The symbols available on a keyboard are not standard across (natural) languages, and may make the (programming) language difficult to type with a non-QWERTY keyboard.</li>
</ul>
</li>
<li>Which native types have <a href="https://en.wikipedia.org/wiki/Literal_(computer_programming)">literals</a></li>
<li>Is the grammar easy to parse?<ul>
<li>The grammars should be straightforward and unambiguous for the computer to formally parse, but it also needs to easy to (informally) parse as a human reading code.</li>
</ul>
</li>
</ul>
<h3>Embedded Domains</h3>
<p>The core syntax of a language is usually composed of distinct clusters of syntax each handling a different subsystem in the language. Most of these can be omitted (as evidenced by lisp).</p>
<p>Common examples:</p>
<ul>
<li>operators<ul>
<li>boolean logic - comparison operators</li>
<li>bit manipulation - usually in the main gammar</li>
<li>basic math - math-consistent operator precedence usually</li>
</ul>
</li>
<li>flow control</li>
<li>type definitions</li>
<li>function definitions</li>
<li>variable assignments</li>
<li>value literals</li>
<li>indexing/slicing</li>
<li>packing/unpacking arguments</li>
<li>preprocessor/compile-time code blocks/quote/eval</li>
<li>import/requires - often effectively declarative assertions about project structure, even in languages which are primarily imperative.</li>
<li>exec - shell scripts like bash are almost entirely a syntax to invoke other commands</li>
</ul>
<p>What to include is a tradeoff of complexity and readability, and also has implications for the &quot;intended usecase&quot; of the language.</p>
<h3>Value Embedded DSLs</h3>
<p>Libraries usually define their own 'language' with which to discuss their domain, but do so in a way that only makes use of the general syntactic constructs for values, functions, types, etc. The DSLs discussed here are not of that nature.
Of interest here are embedded DSLs which impose additional syntactical constraints outside of the language's typical mode of parsing. Usually these DSLs are encoded as strings and parsed at runtime.</p>
<p>For example consider the difference between printf's format specifiers and python's f-strings. Because f-strings are a distinct literal form, they can be statically parsed and proved to be syntactically valid. Printf's format string on the other hand potentially hides structural unsound-ness until runtime.</p>
<p>More examples:</p>
<ul>
<li>regex - usually encoded as a string</li>
<li>format specifiers - printf (string) or python's f-strings (literal)</li>
<li>cron spec - usually a string</li>
<li>sql - usually a string, with markers for safe parameter injection</li>
<li>documentation - often as a comment, but sometimes as strings (python's doc-string)</li>
</ul>
<p>Value embedded DSLs are a tradeoff between allowing more complete compile-time checks but adding complexity to the core grammar vs delegating to libraries but hiding code structure in values (usually strings).
Libraries that implement a value embedded DSL must duplicate the parsing, validation, and error reporting machinery that already exist in the core language. If the core language does not expose this machinery to libraries then handling will be inconsistent.</p>
<h2>External Data</h2>
<ul>
<li>How do you interact with files?</li>
<li>environment variables?</li>
<li>syscalls? peripheral hardware?</li>
<li>How to capture user input/stdin?</li>
<li>Which data-file formats are natively supported?</li>
<li>Is there a standard database API? Do native types have a standard representation?</li>
<li>Can you share native types over the network to another program in the same language? Is it safe to do so? Is there explicit marshalling involved?</li>
</ul>
<h2>External Code</h2>
<ul>
<li>Is there an <a href="https://en.wikipedia.org/wiki/Foreign_function_interface">FFI</a><ul>
<li>can functions and libraries be easily implemented in a more performant base language (perhaps C, rust)?</li>
<li>how much boilerplate and performance overhead is there?</li>
</ul>
</li>
<li>What does it look like to call an external program (as a shell)?<ul>
<li>What about parsing output and return codes?</li>
</ul>
</li>
<li>How do libraries work?<ul>
<li>are dependencies fetched automatically? At runtime or compile-time?</li>
<li>system install vs vendoring in VCS</li>
<li>versioning. What if code depends on multiple versions of the same library?</li>
<li>a standard repository/CDN for libraries? Non-standard and/or private repositories?</li>
<li>how to publish?</li>
<li>Hot loading?</li>
</ul>
</li>
</ul>
<h2>Project Structure</h2>
<ul>
<li>How is a project typically/idiomatically structured?</li>
<li>Are there special/reserved file names within the project?</li>
</ul>
<h2>Performance</h2>
<ul>
<li>Have you done benchmarks against competitor languages?</li>
<li>Does the language run well with restricted resources (memory) or in a VM?</li>
<li>Can you transparently use the GPU or extra CPU cores when it's available and gracefully degrade?</li>
<li>Can you optimize compilation for speed, memory usage, binary size, etc.?</li>
<li><a href="https://en.wikipedia.org/wiki/Dynamic_compilation">Dynamic compilation</a><ul>
<li>Can you collect persistent analytics and avoid the initial performance lag for subsequent executions?</li>
<li>Can you apply runtime analytics to optimize a statically compiled language?</li>
<li>example: a given algorithm may have high overhead but good asymptotic behavior. It shouldn't be used if the data is almost always small. Can this be detected, and an algorithm with lower overhead substituted?</li>
<li>example: automatically generate database index based on typical query usage?</li>
</ul>
</li>
<li>What's the total size of the toolchain? How compact are the binaries?</li>
</ul>
<h2>Tooling</h2>
<ul>
<li>How to version/update the toolchain<ul>
<li>Allow multiple versions to be installed at once?</li>
</ul>
</li>
<li>How to version/download/publish libraries and/or executables<ul>
<li>Do you support binary distributions of libraries?</li>
</ul>
</li>
<li>editor/ide integrations? emacs,vim,vscode<ul>
<li>Do you have a <a href="https://en.wikipedia.org/wiki/Language_Server_Protocol">language server (lsp)</a></li>
</ul>
</li>
<li>version control integration. git, ... what else?<ul>
<li>standard hooks for linting and testing</li>
</ul>
</li>
<li>How descriptive is reporting of compile-time or runtime errors?</li>
<li>What platforms are supported<ul>
<li>Is it easy to port to new hardware?</li>
<li>cross-compiling?</li>
</ul>
</li>
<li>Testing framework<ul>
<li><a href="https://15r10nk.github.io/inline-snapshot/">inline snapshot testing</a></li>
</ul>
</li>
<li>generate documentation from comments?<ul>
<li>like <a href="https://www.doxygen.nl/index.html">doxygen</a></li>
<li>support for <a href="https://en.wikipedia.org/wiki/Literate_programming">literate programming</a> or jupyter style notebooks?</li>
</ul>
</li>
<li>REPL?<ul>
<li>How easy is it to save a REPL session and edit it down to get something useful?</li>
</ul>
</li>
<li>debugger?<ul>
<li>How different is the debugger from the repl?</li>
<li>debugging concurrent programs?</li>
</ul>
</li>
<li>How do you measure language performance?<ul>
<li>Are there tools for visualizing hot-paths?</li>
</ul>
</li>
<li>linter<ul>
<li>Is there a language wide style convention enforced by a standard linter?</li>
</ul>
</li>
<li><a href="https://news.ycombinator.com/item?id=36465886">Where's the config?</a></li>
</ul>
<h2>Standard Library</h2>
<ul>
<li>How comprehensive is the standard library?<ul>
<li>are batteries included? can they be removed for a minimal install?</li>
</ul>
</li>
<li>string manipulation</li>
<li>sets, mappings, arrays</li>
<li>GUI? TUI?</li>
<li>desktop environment integration, notifications, clipboard</li>
<li>regex?</li>
<li>sqlite?</li>
<li>csv, json, toml, yaml?</li>
<li>markdown, moustache?</li>
<li>unittest, logging</li>
<li>inspect/reflect, ast</li>
<li>encryption, compression</li>
<li>random</li>
<li>http</li>
<li>data structures for realtime collaborative editing?</li>
<li>concensus algorithms</li>
<li>graph structures</li>
<li>modeling physics, scientific computing</li>
<li>scheduling</li>
<li>threading, queues</li>
<li>constraint programming, sat solvers</li>
</ul>
<h2>Documentation</h2>
<ul>
<li>Is there a website and/or marketing material for the language?</li>
<li>How comprehensive is the documentation?<ul>
<li>It should have several levels of detail, from the 2-minute elevator speech to the complete language specification.</li>
</ul>
</li>
<li>Do you have tutorials? code snippets for common usecases?</li>
</ul>
<h2>Community, Accessibility</h2>
<ul>
<li>Who is the language for?</li>
<li>Where do people gather to talk about the language?<ul>
<li>Is there a code of conduct for this platform?</li>
</ul>
</li>
<li>Is the toolchain packaged for popular system package managers? apt, pacman, homebrew, etc.</li>
<li>How do people contribute back to the language? feature requests, bug reports, patches, CVE<ul>
<li>what's the process for RFC/<a href="https://peps.python.org/">PEP</a></li>
</ul>
</li>
<li>How welcoming is the language to new-to-the-language programmers?<ul>
<li>What about new-to-programming programmers?</li>
</ul>
</li>
<li>How long do you expect it to take for a competant programmer who's not familiar with the language to become productive?</li>
<li>How are abandoned, insecure, useless, or intentionally compromised community published libraries handled?</li>
</ul>
<h1>Implementation</h1>
<p>A well designed and specified language should be independent of its implementation. Multiple implementations may exist. Therefore this section is concerned not with language design per se, but resources and considerations for the implementation of compilers, interpreters and other tooling.</p>
<ul>
<li>Compiled or interpreted? Bytecode?</li>
<li><a href="https://en.wikipedia.org/wiki/Execution_(computing)">Execution</a></li>
<li><a href="https://craftinginterpreters.com/">crafting interpreters</a></li>
</ul>
<h2>Parsing</h2>
<ul>
<li>Use a parser-generator or write by hand?<ul>
<li>ANTLR</li>
</ul>
</li>
<li><a href="https://stereobooster.com/posts/an-overview-of-parsing-algorithms/">overview of parsing algorithms</a></li>
<li><a href="https://eli.thegreenplace.net/2012/08/02/parsing-expressions-by-precedence-climbing">precedence climbing</a>
<a href="https://news.ycombinator.com/item?id=31311218#31312473">hn:parsing</a></li>
<li><a href="https://bford.info/packrat/">packrat reference</a></li>
</ul>
<h1>More Ideas for New Languages</h1>
<p>Things I think would be interesting to have in a new language. Features big and small to serve as inspiration.</p>
<ul>
<li><p>context free functions (pure, or only manipulating memory already exclusively allocated to that process) have only
a single meta-algorithm, which is available throughout the whole stack.</p>
<ul>
<li>the compiler should be aware if someone effectively reimplements a algorithm by hand and warn them to use the standard version</li>
<li>The same thing could be implemented multiple times. Readable (but not performant) versions should be left in
so they can be available for the book/learning version.</li>
<li>competing ways of doing the same task should be maintained, especially if they prioritize competing performance metrics.
They can be tested for correctness against each other, and context aware compilation can pick one over the other.</li>
</ul>
</li>
<li><p>top-level applications mark which functions a human user will be waiting on (real-time, human-facing IO) versus functions
on which performance is not hyper noticeable.</p>
<ul>
<li>this allows meta-algorithms to experiment with various implementations in contexts where no one will notice to gather real performance statistics
on the current context.</li>
<li>real performance statistics are used to find the optimal algorithm to apply in the human-facing scenario</li>
<li>this optimization / recompilation happens in the background</li>
</ul>
</li>
<li><p>truly DAG filesystems or tag based systems</p>
<ul>
<li>use 'everything is a file' paradigm to expose dag query api</li>
</ul>
</li>
<li><p>strong separation between persistent state and intermediate representations</p>
<ul>
<li>what if we handle persistence as a type property?</li>
<li>strong separation between state transitions and data transformations</li>
<li>state transitions &lt;-&gt; state &lt;-&gt; transformations &lt;-&gt; IO</li>
</ul>
</li>
<li><p>pure functions are semantically equivalent to (potentially infinite) immutable mappings from arguments to a value.</p>
<ul>
<li>despite the equivalence, there are time/space performance tradeoffs between the two. Can the compiler choose between the two?</li>
<li>Can this equivalence be reflected in syntax?</li>
</ul>
</li>
<li><p>are zipped iterators synced or not? what are the applications of each</p>
</li>
<li><p>deriving types from properties? Generics over properties?</p>
</li>
<li><p><a href="https://futhark-lang.org/blog/2024-06-17-automap.html">function lifting</a> (APL, futhark) implicitly map over arguments of unexpected rank</p>
</li>
<li><p>SOA/AOS implicitly convert data model from array of structs to struct of arrays based on length hints and static analysis of access patterns</p>
</li>
<li><p>easy convert between call styles</p>
<ul>
<li>immediate call, callback/continuation, partial/delayed</li>
</ul>
</li>
<li><p>consider the entire programming environment as 'part of the language'</p>
<ul>
<li>package manager<ul>
<li>versioning</li>
<li>installation</li>
</ul>
</li>
<li>editor integration<ul>
<li>language designed for powerful refactoring?</li>
</ul>
</li>
<li>language hooks/interop</li>
<li>consider integration into the development environment as part of the language</li>
<li>documentation generator</li>
<li>editor</li>
<li>package manager</li>
<li>versioning</li>
<li>testing</li>
<li>debugging</li>
</ul>
</li>
<li><p>seamless transition between compute environments (compilation targets)</p>
<ul>
<li>cpu, gpu, threaded, cloud compute</li>
<li>suitable functions (based on length hints, access patterns, derived purity) should automatically be sent to the gpu</li>
<li>for distributed compute,<ul>
<li>autogenerate networking security boundaries.</li>
<li>encryption, networking, serialized data format, consistency, defunctionalization (serializing function objects safely)</li>
<li>what are the available sync primitives?</li>
<li><a href="http://catern.com/caternetes.html">No more DSLs</a></li>
</ul>
</li>
</ul>
</li>
<li><p>reduce the number of core concepts</p>
<ul>
<li>&quot;everything is a ...&quot;. in lisp everything is a list, in apl a matrix. In unix everything is a file<ul>
<li>unifying similar concepts to produce a simplified (but no less powerful) experience.</li>
</ul>
</li>
<li>expression only, no statements</li>
<li>code blocks are equivalent to immediate anonymous functions.<ul>
<li>variables that are accessed in the block are parameters, variables that are set are return values.</li>
<li>the language should treat these as equivalent and be able to extract or inline functions in the editor
with no change to lexical scoping rules</li>
</ul>
</li>
<li>no garbage collection, use rust style borrow ref to determine lifetimes and collect statically</li>
<li>repl is debugger</li>
<li>only one looping control flow construct</li>
<li>only one branching control flow construct</li>
<li>objects are just mappings</li>
</ul>
</li>
<li><p>unify sql and apl ways of thinking, with a dash of numpy?</p>
</li>
<li><p><a href="https://github.com/toombs-caeman/treerat">a framework for rapid language prototyping</a>. A meta-language.</p>
</li>
<li><p>rust &quot;eliminated&quot; memory safety errors, what's the next class of errors to be swept away?</p>
</li>
<li><p>Can a single language be simple enough at its core to compile it by hand (a la. <a href="https://en.wikipedia.org/wiki/TMG_(language)">Ken Thompson's great story</a>) but that can meta-program itself well enough to be viable on all levels of the stack?</p>
</li>
<li><p>array of structs &lt;=&gt; struct of arrays (a la. JAI) a focus on high-performance game programming?</p>
</li>
<li><p>ergonomics</p>
<ul>
<li>correctness through the easy path (good defaults)</li>
<li>write only what's necessary (good defaults)</li>
<li>powerful primitives</li>
<li>readability</li>
<li>helpful error messages</li>
</ul>
</li>
<li><p>How do we minimize the cost associated with changing decisions? Especially those made in the begining of a project? Can this even be a feature of the language, or only of the design pattern?</p>
</li>
<li><p>algebraic effects</p>
</li>
<li><p>static analysis of <a href="https://en.wikipedia.org/wiki/Numerical_stability">numerical stability</a>. Can the compiler assert that an algorithm is stable under certain conditions?</p>
</li>
<li><p>The type system should be capable of reflecting any arbitrary rules a programmer knows about the bounds of a value</p>
<ul>
<li>bounded number types (aka enums, but not necessarily enumerable)<ul>
<li>let x be a float in [0, 1]. on cast from float, clamp</li>
<li>let y be an int [0, 8]. on cast from int, mod 8</li>
<li>let bool be int 0 or 1. on cast from float, fail</li>
</ul>
</li>
<li>typed strings for embedded langauges, with custom value escaping / formatting<ul>
<li>regex</li>
<li>sql queries</li>
<li>these are used as special form literal values, but cannot be checked by the type system because the cast from string is usually implemented by a library</li>
</ul>
</li>
</ul>
</li>
<li><p>embed debug visualization types as an extension of debug symbols</p>
<ul>
<li>how should utilization of a function be visualized in a debugging context?</li>
<li>expected data size?</li>
<li>expected runtime? to flag functions that are underperforming</li>
</ul>
</li>
<li><p>inline snapshot testing</p>
</li>
<li><p>can name everything, don't have to name anything</p>
<ul>
<li>DeBrujin naming</li>
<li><a href="https://willcrichton.net/notes/specificity-programming-languages/">name resolution</a></li>
</ul>
</li>
</ul>
<h1>Other Resources</h1>
<ul>
<li><a href="https://claucece.github.io/2020/06/05/programming-language-design-and-compilers.html">where to start</a></li>
<li><a href="https://www.jsoftware.com/papers/tot.htm">notation as a tool of thought</a></li>
<li><a href="https://en.wikipedia.org/wiki/Programming_language_theory">pl theory</a></li>
<li><a href="https://scrapscript.org/">scrapscript</a></li>
<li><a href="https://racket-lang.org/">Racket</a> has probably done the most on &quot;langauge-oriented&quot; programming, or meta-programming as an explicit strength of a language.</li>
<li><a href="https://semver.org/">semantic versioning</a></li>
</ul>
<h1>Other Thoughts</h1>
<h3>compunomicon</h3>
<p>I've been obsessing lately over the idea that there's no good reason why there is more than a single implementation of sort present on a single computer.
Why is it that we need sort implemented in C, python, javascript, etc. each with a (potentially) different and arbitrary choice of algorithm?</p>
<p>I'm imagining a hyper-monolith that is compiler, operating system, scripting language, browser, and javascript all in one.
It would run on desktops, tablets, super-computers, smartphones, and micro-controllers. It's meta-algorithms would select
the appropriate way to sort given what it knows about its resource constraints, and the data it is sorting.</p>
<p>The data it collects on what is sorted, how often and how much, would be compiled. It would know its own strengths and weaknesses.
This data can be used tune the meta-algorithm. Perhaps that tuning would inform the next generation of chip design.
The monolith can compile real world performance analytics into verilog, to produce a chip that will perform faster.</p>
<p>The monolith generates its own documentation from its own source with the right flag.</p>
<p>I believe all the pieces exist, in one form or another. The only question is if they all fit together in a useful shape.</p>
<h3>computer literacy</h3>
<p>the day everyone has a basic understanding of computing we will see a fundamental shift in our society similar to the shift seen in preliterate to literate societies.
It think it may be useful to develop a lingua franca for this situation while we have the opportunity.</p>
<h2>fractal</h2>
<p>the same ideas recur, with varying levels of sophistication, in widely different contexts.</p>
<p><a href="https://en.wikipedia.org/wiki/Inter-process_communication">IPC</a> is just <a href="https://en.wikipedia.org/wiki/Computer_network">networking</a>.</p>
<p>ISAs are DSLs</p>
<p>everything turing complete is equivalent.</p>
<p>The browser is a desktop environment with better ergonomics for how it installs programs (websites are turing complete after all)</p>
<p>Caching happens in the processor (from memory), in memory (from the disk), in the disk (from the network) and in the CDN (from the site).
If a program can be programmatically re-installed or updated when needed, how is that different than a cached web resource?
Even a compiled binary could be considered a cache of the source (again if it could be dynamically recompiled when needed).</p>
<p>compilation and compression are intimately linked.</p>

            <footer>
                <a href="/">Home</a>
            </footer>
        </div>
    </div>
</body>

</html>
