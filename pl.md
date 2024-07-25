{{?.note}}
# Programming Language Design
What ought to be considered when designing a programming language?
While it can be fun to make a language focused on a single aspect for a side project with a single user, language designers need to consider a vast array of things in order to create a language with wide appeal. A new language must bring something new to the table in order to compete, while at the same time providing the niceties expected of an established language.

What follows is a list of things to consider, which aims to be more or less exhaustive. Users will typically decide whether or not to use a language based on one or more of these considerations. This is not to say that its pointless to make a language without considering all these aspects. Language design can be a challenge and satisfying for its own sake.

## Basis
What is the core reason for this language to exist and be used?

Possible reasons include:
* It solves problems within a given domain better than a general language.
* It solves a particular gripe about developing in another language.
* It has platform exclusivity (like javascript in the browser).
* It was fun to build.
* It is fun to use.
* A bad case of [:NIH syndrome](https://en.wikipedia.org/wiki/Not_invented_here)
* It encourages solving problems in a novel way.
* It eliminates certain classes of programming errors.
* It is easy to port.
* It is small, and therefore easy to grok.
* It is large, and therefore can do everything.
* It introduces novel or experimental features.

Clearly, not every language needs all of these reasons to exist, and some reasons contradict others. The point is that a new language should have at least one.

## Semantics
* What [:programming paradigms](https://en.wikipedia.org/wiki/Programming_paradigm) are supported? Which are encouraged?
* What are the built-in types?
* [:first class functions?](https://en.wikipedia.org/wiki/First-class_function)
* What metaprogramming or preprocessor is available?
    * [:homoiconicity?](https://en.wikipedia.org/wiki/Homoiconicity)
    * Is the preprocessor language the same as the full language, a subset, or totally distinct?
* concurrency? parallelism? async? system threads vs language threads
    * how is state safely shared between threads?
* type system? static? dynamic (duck)? hinting?
    * Implicit casting?
    * Implicit broadcasting/ [function lifting?](https://futhark-lang.org/blog/2024-06-17-automap.html)
    * Generics?
* What happens when a computation has no result? do you have (Null nil NaN None)?
* What values are considered false (perhaps null, 0, '')?
* What scopes are there? how are names resolved?
    * how does global scope behave? especially when multithreaded
    * lexical(static) vs dynamic scope, closures
    * do you have file-local or other scopes?
    * How do you reference libraries and/or code in the same project but a different file?
* Statements vs expressions
* what flow control structures
* manual memory management or garbage collection?

## Syntax
* How familiar/weird is the syntax? What's the closest extant language or language family?
* How does the syntax support/enforce the dominant paradigms?
    * usually syntax used heavily in the dominant paradigm is shorter
* How visually distinct are distinct language constructs?
    * Are similar constructs visually similar?
    * visual similarity here is informally related to edit distance. How much typing is needed to make a subtle semantic change?
* What are the worst cases? What constructs are unweildy, hard to read, write, or edit?
    * deeply nested loops or lists? repeated function applications?
    * Are parts of the language "write only"?
* How semanticaly dense is the syntax (on a scale of Java to APL)?
* Does the "flow" of an expression move cleanly left-to-right or right-to-left
    * Does the order that things happen match the order in which they would be read?
    * personally it's a bit confusing when the first thing that happens is in the middle.
    * like Endian-ness, but for expressions
* Does your language use hard to type symbols (like APL)?
    * The symbols available on a keyboard are not standard across (natural) languages, and may make the (programming) language difficult to type with a non-QWERTY keyboard.
* Which native types have [:literals](https://en.wikipedia.org/wiki/Literal_(computer_programming))
* Is the grammar easy to parse?
    * The grammars should be straightforward and unambiguous for the computer to formally parse, but it also needs to easy to (informally) parse as a human reading code.

### Embedded Domains
The core syntax of a language is usually composed of distinct clusters of syntax each handling a different subsystem in the language. Most of these can be omitted (as evidenced by lisp).

Common examples:
* operators
    * boolean logic - comparison operators
    * bit manipulation - usually in the main gammar
    * basic math - math-consistent operator precedence usually
* flow control
* type definitions
* function definitions
* variable assignments
* value literals
* indexing/slicing
* packing/unpacking arguments
* preprocessor/compile-time code blocks/quote/eval
* import/requires - often effectively declarative assertions about project structure, even in languages which are primarily imperative.
* exec - shell scripts like bash are almost entirely a syntax to invoke other commands

What to include is a tradeoff of complexity and readability, and also has implications for the "intended usecase" of the language.

### Value Embedded DSLs
Libraries usually define their own 'language' with which to discuss their domain, but do so in a way that only makes use of the general syntactic constructs for values, functions, types, etc. The DSLs discussed here are not of that nature.
Of interest here are embedded DSLs which impose additional syntactical constraints outside of the language's typical mode of parsing. Usually these DSLs are encoded as strings and parsed at runtime.

For example consider the difference between printf's format specifiers and python's f-strings. Because f-strings are a distinct literal form, they can be statically parsed and proved to be syntactically valid. Printf's format string on the other hand potentially hides structural unsound-ness until runtime.

More examples:
* regex - usually encoded as a string
* format specifiers - printf (string) or python's f-strings (literal)
* cron spec - usually a string
* sql - usually a string, with markers for safe parameter injection
* documentation - often as a comment, but sometimes as strings (python's doc-string)

Value embedded DSLs are a tradeoff between allowing more complete compile-time checks but adding complexity to the core grammar vs delegating to libraries but hiding code structure in values (usually strings).
Libraries that implement a value embedded DSL must duplicate the parsing, validation, and error reporting machinery that already exist in the core language. If the core language does not expose this machinery to libraries then handling will be inconsistent.


## External Data
* How do you interact with files?
* environment variables?
* syscalls? peripheral hardware?
* How to capture user input/stdin?
* Which data-file formats are natively supported?
* Is there a standard database API? Do native types have a standard representation?
* Can you share native types over the network to another program in the same language? Is it safe to do so? Is there explicit marshalling involved?

## External Code
* Is there an [:FFI](https://en.wikipedia.org/wiki/Foreign_function_interface)
    * can functions and libraries be easily implemented in a more performant base language (perhaps C, rust)?
    * how much boilerplate and performance overhead is there?
* What does it look like to call an external program (as a shell)?
    * What about parsing output and return codes?
* How do libraries work?
    * are dependencies fetched automatically? At runtime or compile-time?
    * system install vs vendoring in VCS
    * versioning. What if code depends on multiple versions of the same library?
    * a standard repository/CDN for libraries? Non-standard and/or private repositories?
    * how to publish?
    * Hot loading?

## Project Structure
* How is a project typically/idiomatically structured?
* Are there special/reserved file names within the project?

## Performance
* Have you done benchmarks against competitor languages?
* Does the language run well with restricted resources (memory) or in a VM?
* Can you transparently use the GPU or extra CPU cores when it's available and gracefully degrade?
* Can you optimize compilation for speed, memory usage, binary size, etc.?
* [:Dynamic compilation](https://en.wikipedia.org/wiki/Dynamic_compilation)
    * Can you collect persistent analytics and avoid the initial performance lag for subsequent executions?
    * Can you apply runtime analytics to optimize a statically compiled language?
    * example: a given algorithm may have high overhead but good asymptotic behavior. It shouldn't be used if the data is almost always small. Can this be detected, and an algorithm with lower overhead substituted?
    * example: automatically generate database index based on typical query usage?
* What's the total size of the toolchain? How compact are the binaries?

## Tooling
* How to version/update the toolchain
    * Allow multiple versions to be installed at once?
* How to version/download/publish libraries and/or executables
    * Do you support binary distributions of libraries?
* editor/ide integrations? emacs,vim,vscode
    * Do you have a [:language server (lsp)](https://en.wikipedia.org/wiki/Language_Server_Protocol)
* version control integration. git, ... what else?
    * standard hooks for linting and testing
* How descriptive is reporting of compile-time or runtime errors?
* What platforms are supported
    * Is it easy to port to new hardware?
    * cross-compiling?
* Testing framework
    * [inline snapshot testing](https://15r10nk.github.io/inline-snapshot/)
* generate documentation from comments?
    * like [doxygen](https://www.doxygen.nl/index.html)
    * support for [:literate programming](https://en.wikipedia.org/wiki/Literate_programming) or jupyter style notebooks?
* REPL?
    * How easy is it to save a REPL session and edit it down to get something useful?
* debugger?
    * How different is the debugger from the repl?
    * debugging concurrent programs?
* How do you measure language performance?
    * Are there tools for visualizing hot-paths?
* linter
    * Is there a language wide style convention enforced by a standard linter?
* [Where's the config?](https://news.ycombinator.com/item?id=36465886)

## Standard Library
* How comprehensive is the standard library?
    * are batteries included? can they be removed for a minimal install?
* string manipulation
* sets, mappings, arrays
* GUI? TUI?
* desktop environment integration, notifications, clipboard
* regex?
* sqlite?
* csv, json, toml, yaml?
* markdown, moustache?
* unittest, logging
* inspect/reflect, ast
* encryption, compression
* random
* http
* data structures for realtime collaborative editing?
* concensus algorithms
* graph structures
* modeling physics, scientific computing
* scheduling
* threading, queues
* constraint programming, sat solvers

## Documentation
* Is there a website and/or marketing material for the language?
* How comprehensive is the documentation?
    * It should have several levels of detail, from the 2-minute elevator speech to the complete language specification.
* Do you have tutorials? code snippets for common usecases?

## Community, Accessibility
* Who is the language for?
* Where do people gather to talk about the language?
    * Is there a code of conduct for this platform?
* Is the toolchain packaged for popular system package managers? apt, pacman, homebrew, etc.
* How do people contribute back to the language? feature requests, bug reports, patches, CVE
    * what's the process for RFC/[PEP](https://peps.python.org/)
* How welcoming is the language to new-to-the-language programmers?
    * What about new-to-programming programmers?
* How long do you expect it to take for a competant programmer who's not familiar with the language to become productive?
* How are abandoned, insecure, useless, or intentionally compromised community published libraries handled?

# Implementation
A well designed and specified language should be independent of its implementation. Multiple implementations may exist. Therefore this section is concerned not with language design per se, but resources and considerations for the implementation of compilers, interpreters and other tooling.

* Compiled or interpreted? Bytecode?
* [Execution](https://en.wikipedia.org/wiki/Execution_(computing))
* [crafting interpreters](https://craftinginterpreters.com/)

## Parsing
* Use a parser-generator or write by hand?
    * ANTLR
* [overview of parsing algorithms](https://stereobooster.com/posts/an-overview-of-parsing-algorithms/)
* [precedence climbing](https://eli.thegreenplace.net/2012/08/02/parsing-expressions-by-precedence-climbing)
[hn:parsing](https://news.ycombinator.com/item?id=31311218#31312473)
* [packrat reference](https://bford.info/packrat/)


# More Ideas for New Languages
Things I think would be interesting to have in a new language. Features big and small to serve as inspiration.

* context free functions (pure, or only manipulating memory already exclusively allocated to that process) have only
    a single meta-algorithm, which is available throughout the whole stack.
    * the compiler should be aware if someone effectively reimplements a algorithm by hand and warn them to use the standard version
    * The same thing could be implemented multiple times. Readable (but not performant) versions should be left in 
        so they can be available for the book/learning version.
    * competing ways of doing the same task should be maintained, especially if they prioritize competing performance metrics.
        They can be tested for correctness against each other, and context aware compilation can pick one over the other.
* top-level applications mark which functions a human user will be waiting on (real-time, human-facing IO) versus functions
    on which performance is not hyper noticeable.
    * this allows meta-algorithms to experiment with various implementations in contexts where no one will notice to gather real performance statistics
        on the current context.
    * real performance statistics are used to find the optimal algorithm to apply in the human-facing scenario
    * this optimization / recompilation happens in the background
* truly DAG filesystems or tag based systems
    * use 'everything is a file' paradigm to expose dag query api

* strong separation between persistent state and intermediate representations
  * what if we handle persistence as a type property?
  * strong separation between state transitions and data transformations
  * state transitions <-> state <-> transformations <-> IO
* pure functions are semantically equivalent to (potentially infinite) immutable mappings from arguments to a value.
    * despite the equivalence, there are time/space performance tradeoffs between the two. Can the compiler choose between the two?
    * Can this equivalence be reflected in syntax?
* are zipped iterators synced or not? what are the applications of each
* deriving types from properties? Generics over properties?
* [function lifting](https://futhark-lang.org/blog/2024-06-17-automap.html) (APL, futhark) implicitly map over arguments of unexpected rank
* SOA/AOS implicitly convert data model from array of structs to struct of arrays based on length hints and static analysis of access patterns
* easy convert between call styles
  * immediate call, callback/continuation, partial/delayed
* consider the entire programming environment as 'part of the language'
  * package manager
    * versioning
    * installation
  * editor integration
    * language designed for powerful refactoring? 
  * language hooks/interop
  * consider integration into the development environment as part of the language
  * documentation generator
  * editor
  * package manager
  * versioning
  * testing
  * debugging
* seamless transition between compute environments (compilation targets)
  * cpu, gpu, threaded, cloud compute
  * suitable functions (based on length hints, access patterns, derived purity) should automatically be sent to the gpu
  * for distributed compute, 
    * autogenerate networking security boundaries.
    * encryption, networking, serialized data format, consistency, defunctionalization (serializing function objects safely)
    * what are the available sync primitives?
    * [No more DSLs](http://catern.com/caternetes.html)
* reduce the number of core concepts
  * "everything is a ...". in lisp everything is a list, in apl a matrix. In unix everything is a file
    * unifying similar concepts to produce a simplified (but no less powerful) experience.
  * expression only, no statements
  * code blocks are equivalent to immediate anonymous functions.
    * variables that are accessed in the block are parameters, variables that are set are return values.
    * the language should treat these as equivalent and be able to extract or inline functions in the editor
        with no change to lexical scoping rules
  * no garbage collection, use rust style borrow ref to determine lifetimes and collect statically
  * repl is debugger
  * only one looping control flow construct
  * only one branching control flow construct
  * objects are just mappings
* unify sql and apl ways of thinking, with a dash of numpy?
* [a framework for rapid language prototyping](https://github.com/toombs-caeman/treerat). A meta-language.
* rust "eliminated" memory safety errors, what's the next class of errors to be swept away?
* Can a single language be simple enough at its core to compile it by hand (a la. [Ken Thompson's great story](https://en.wikipedia.org/wiki/TMG_(language))) but that can meta-program itself well enough to be viable on all levels of the stack?
* array of structs <=> struct of arrays (a la. JAI) a focus on high-performance game programming?
* ergonomics
    * correctness through the easy path (good defaults)
    * write only what's necessary (good defaults)
    * powerful primitives
    * readability
    * helpful error messages
* How do we minimize the cost associated with changing decisions? Especially those made in the begining of a project? Can this even be a feature of the language, or only of the design pattern?
* algebraic effects
* static analysis of [:numerical stability](https://en.wikipedia.org/wiki/Numerical_stability). Can the compiler assert that an algorithm is stable under certain conditions?
* The type system should be capable of reflecting any arbitrary rules a programmer knows about the bounds of a value
    * bounded number types (aka enums, but not necessarily enumerable)
        * let x be a float in [0, 1]. on cast from float, clamp
        * let y be an int [0, 8]. on cast from int, mod 8
        * let bool be int 0 or 1. on cast from float, fail
    * typed strings for embedded langauges, with custom value escaping / formatting
        * regex
        * sql queries
        * these are used as special form literal values, but cannot be checked by the type system because the cast from string is usually implemented by a library
* embed debug visualization types as an extension of debug symbols
    * how should utilization of a function be visualized in a debugging context?
    * expected data size?
    * expected runtime? to flag functions that are underperforming
* inline snapshot testing
* can name everything, don't have to name anything
    * DeBrujin naming
    * [name resolution](https://willcrichton.net/notes/specificity-programming-languages/)

# Other Resources
* [where to start](https://claucece.github.io/2020/06/05/programming-language-design-and-compilers.html)
* [notation as a tool of thought](https://www.jsoftware.com/papers/tot.htm)
* [:pl theory](https://en.wikipedia.org/wiki/Programming_language_theory)
* [scrapscript](https://scrapscript.org/)
* [Racket](https://racket-lang.org/) has probably done the most on "langauge-oriented" programming, or meta-programming as an explicit strength of a language.
* [semantic versioning](https://semver.org/)



# Other Thoughts
### compunomicon
I've been obsessing lately over the idea that there's no good reason why there is more than a single implementation of sort present on a single computer.
Why is it that we need sort implemented in C, python, javascript, etc. each with a (potentially) different and arbitrary choice of algorithm?


I'm imagining a hyper-monolith that is compiler, operating system, scripting language, browser, and javascript all in one.
It would run on desktops, tablets, super-computers, smartphones, and micro-controllers. It's meta-algorithms would select
the appropriate way to sort given what it knows about its resource constraints, and the data it is sorting.

The data it collects on what is sorted, how often and how much, would be compiled. It would know its own strengths and weaknesses.
This data can be used tune the meta-algorithm. Perhaps that tuning would inform the next generation of chip design.
The monolith can compile real world performance analytics into verilog, to produce a chip that will perform faster.

The monolith generates its own documentation from its own source with the right flag.

I believe all the pieces exist, in one form or another. The only question is if they all fit together in a useful shape.

### computer literacy
the day everyone has a basic understanding of computing we will see a fundamental shift in our society similar to the shift seen in preliterate to literate societies.
It think it may be useful to develop a lingua franca for this situation while we have the opportunity.

# :x fractal
the same ideas recur, with varying levels of sophistication, in widely different contexts.

[IPC](https://en.wikipedia.org/wiki/Inter-process_communication) is just [networking](https://en.wikipedia.org/wiki/Computer_network).

ISAs are DSLs

everything turing complete is equivalent.

The browser is a desktop environment with better ergonomics for how it installs programs (websites are turing complete after all)

Caching happens in the processor (from memory), in memory (from the disk), in the disk (from the network) and in the CDN (from the site).
If a program can be programmatically re-installed or updated when needed, how is that different than a cached web resource?
Even a compiled binary could be considered a cache of the source (again if it could be dynamically recompiled when needed).

compilation and compression are intimately linked.

# :x inbox
finish treerat maybe?
