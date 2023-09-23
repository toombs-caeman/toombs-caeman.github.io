{{?.note}}
# Programming Language Design
what is a programming language?
or So you want to design a language.
and bits and pieces to consider when designing a language

* [:Programming Language Theory](https://en.wikipedia.org/wiki/Programming_language_theory)
----------------------------------------------------------------------------------------
# syntax semantics mechanics tooling ecosystem
syntax, the form of the code written in a language, is distinct but not separate from
semantics, the underlying concepts of a language.
This is again distinct from the mechanics, the way concepts are represented and manipulated by the machine.

the medium is the message
syntax affects the way you can use and reason about a language,
so it's unreasonable to separate a language from its syntax
## what is the foreign function interface (FFI)
* can functions easily be implemented in C/rust
what does it look like to call an external program?

# tooling and ecosystem
## installation / updating / versioning
is there a standard way to:
* version/update the toolchain
* version/download/publish libraries
* have multiple versions of the toolchain installed (virtual env)
* version/install/uninstall compiled code
* cross-compile
is it possible to have multiple versions of the runtime and/or libraries active at the same time?
is the toolchain available on system package managers (apt, pacman, homebrew, etc.)
## tutorials
Do you have tutorials?
Who is the target audience of your tutorials?
* programming beginners
* existing programmers
    * generically
    * those familiar with a specific language family
    * those familiar with a specific problem domain
### mechanics
* [semantic versioning](https://semver.org/)
## build tools / runtime / repl
how easy is it to save a repl session and edit it down into real code?
can we trace which lines (from repl session) have effects and prune to those before outputing?
## editing
do you have a language server
do you have emacs/vim integrations
## testing
do you have a standard testing framework
## documentation generator
can we automatically embed documentation in your language, perhaps its understood by AST?
Is there a convention for writing comments in a way that gets extracted by tools like [doxygen](https://www.doxygen.nl/index.html)
can we easily support [literate programming](https://en.wikipedia.org/wiki/Literate_programming) or jupyter style notebooks?
## logging
## debugger
how different is the debugger from the repl?
is it easy to debug concurrent programs
## linter / formatter
is there a language wide style or is it up to convention?

# semantics
what is the **intended use** of your language?
Is it primarily for:
* string manipulation
* array manipulation
* math
* glue-code
* high level code
* low level code
* meta-programming

## types
what are the natively supported types? Are functions first-class?
what happens when a computation has no result? do you have (Null nil NaN None)?
what values are considered false? perhaps (null 0, '')?

## scope
* local scope
* how does global scope behave? especially when threaded
* lexical(static) vs dynamic scope, closures
* do you have file-local or other scopes?

## parallelism concurrency
* what is the interface for concurrent threads?
* system threads vs language threads
* Global Interpreter Lock (GIL)

## flow control
* if, else, elif, case
* while, for, do-until, (recursive call)
* linear flow (newline)
* try, catch, finally

## memory management
* malloc/free
* garbage collection
* known variable lifetimes
### heap vs stack
## typing
* dynamic (duck)
* static
* hinting
* mixed, or static typing but default to Any
### mechanics
* [hindley-milner](https://en.wikipedia.org/wiki/Hindley%E2%80%93Milner_type_system)
## user input
how do you request input while the program is running
## gui/tui
# mechanics
* what platforms do you target
* what's the foreign function/memory [interface](https://en.wikipedia.org/wiki/Foreign_function_interface) like
* how do you interact with external programs and/or env
* what's your minimum memory usage
* hows the performance

can you transparently use hardware when its available, or scale back when it isn't?
* GPU
* cores
* extra memory
# syntax
## literal types
* strings
* numbers
* lists, dicts, sets
    `obj.{a,b,c}` returns dict {'a':obj.a, 'b':obj.b, 'c': obj.c}
    `obj.[a,b,c]` returns list ['a':obj.a, 'b':obj.b, 'c': obj.c]
* lambdas
## parsing
* [precedence climbing](https://eli.thegreenplace.net/2012/08/02/parsing-expressions-by-precedence-climbing)
[hn:parsing](https://news.ycombinator.com/item?id=31311218#31312473)
### statements vs expressions
### mechanics
* [overview](https://stereobooster.com/posts/an-overview-of-parsing-algorithms/)


# regex

[regex-vis](https://regex-vis.com/?r=%2F%5E%28%28%5BhH%5Dacker%29%5B+%5D%3F%28%5BnN%5Dews%7Cnewsletter%29%29%24%2F)
[discussion regex-vis](https://news.ycombinator.com/item?id=31307123)
[regex101](https://regex101.com/)

# embedded DSL
embedding micro-languages within full  programming languages.
clusters of functionality that get libraries and/or special syntax

first, consider a language like lisp, with minimal syntax. All functionality in the language must be added by defining
functions, but other languages offer access to functions through special syntax.

# common embeddings
* basic math
* boolean logic
* json
* regex
* cron spec
* sql
* documentation / comments

# unusual embeddings
might have utility
* apl-like function lifting and array manipulation (filter/map/reduce)
* unpacking/argument manipulation

# weird combo
unify sql and apl ways of thinking


# special strings syntax
* %     - 'the value of var is %s' % var; %'%s'(var)
* format- f'the value of var is {var}' or 'the value of var is {}'.format(var)
* regex - r'^(.\*)$'.match(var) or regex('^(.\*)$').match(var)
    * how to represent sed-like expressions? - s's/\(.\*\)/(\1)/'
* apl
    * a'+/'(...) or sum(...)
    * a'i'(...) or range(...)
    * sum(range(...)) - a'+/⍳'(...)
    - use ascii letters instead of strange unicode and greek letters
    - core - compact array manipulation
* sqlite- q'select {col_name} from asf where ...'
    - core - describing what you want (from tabular data), and not how to get it. which lets the query planner work.

`obj.{a,b,c}` returns dict {'a':obj.a, 'b':obj.b, 'c': obj.c}
`obj.[a,b,c]` returns list ['a':obj.a, 'b':obj.b, 'c': obj.c]

    
## format specifiers
* include capabilities of all the usual c::printf() stuff (%s specifiers)
* also include 'escape' capability which behaves differently depending on string type
    * normal strings get quoted (double for double quoted strings, single for single)
    * sql
## unity
unifying similar language level concepts to produce a simplified (but no less powerful) experience.

* repl/debugger
* logging/printing
* sql/apl
* regex/sed/match
* looping control flow
* branching control flow

* object/dictionary

# inbox
[crafting interpreters](https://craftinginterpreters.com/)
is your language simple enough to embed in other contexts (like lua)?
Does a market for your language exist or is there already something similar?
* Is your language a meme?
* How long do you expect it to take for a competant programmer who's not familiar with the language to become productive?
* How do we minimize the cost associated with changing desicisions? Especially those made in the begining of a project? Can this even be a feature of the language, or only of the design pattern?
algebraic effects
* static numerical analysis
* [where's the config?](https://news.ycombinator.com/item?id=36465886)
* does your language use hard to type symbols(apl)? this probably hinders adoption
* what form of type inference?
* [where to start](https://claucece.github.io/2020/06/05/programming-language-design-and-compilers.html)
* scrapscript
* is there a separate list type with uniform element types `Array<T>`
* what's the process for RFC/[PEP](https://peps.python.org/)
* ergonomics
    * correctness through the easy path (good defaults)
    * write only what's necessary (good defaults)
    * powerful primitives
    * readability
    * helpful error messages
* efficiency of generated binary
    * time/space/compute
* [notation as a tool of thought](https://www.jsoftware.com/papers/tot.htm)


========================================================

# compunomicon
I've been obsessing lately over the idea that there's no good reason why there is more than a single implementation of sort present on a single computer.
Why is it that we need sort implemented in C, python, javascript, etc. each with a (potentially) different and arbitrary choice of algorithm?

Can a single language be simple enough at its core to compile it by hand (a la. [Ken Thompson's great story](https://en.wikipedia.org/wiki/TMG_(language)))
but that can meta-program itself well enough to be viable on all levels of the stack?

I'm imagining a hyper-monolith that is compiler, operating system, scripting language, browser, and javascript all in one.
It would run on desktops, tablets, super-computers, smartphones, and micro-controllers. It's meta-algorithms would select
the appropriate way to sort given what it knows about its resource constraints, and the data it is sorting.

The data it collects on what is sorted, how often and how much, would be compiled. It would know its own strengths and weaknesses.
This data can be used tune the meta-algorithm. Perhaps that tuning would inform the next generation of chip design.
The monolith can compile real world performance analytics into verilog, to produce a chip that will perform faster.

The monolith generates its own documentation from its own source with the right flag.

I believe all the pieces exist, in one form or another. The only question is if they all fit together in a useful shape.

# computer literacy
the day everyone has a basic understanding of computing we will see a fundamental shift in our society similar to the shift seen in preliterate to literate.
It think it may be useful to develop a lingua franca for this situation while we have the opportunity.

# a case for small, composable orthogonal DSLs that build up to a general language
* a data language defines data literals
    * understand a small set of widely used 
* deliberately avoid making a DSL turing complete.
    * Having multiple ways to do general computing creates an extra burden in writing and understanding.
    * by having 'one true' way to 

base types
* text - every supported format should be representable by one type.

# It's not just sort
the same ideas recur, with varying levels of sophistication, in widely different contexts.

[IPC](https://en.wikipedia.org/wiki/Inter-process_communication) is just [networking](https://en.wikipedia.org/wiki/Computer_network).

ISAs are DSLs

everything turing complete is equivalent.

The browser is a desktop environment with better ergonomics for how it installs programs (websites are turing complete after all)

Caching happens in the processor (from memory), in memory (from the disk), in the disk (from the network) and in the CDN (from the site).
If a program can be programmatically re-installed or updated when needed, how is that different than a cached web resource?
Even a compiled binary could be considered a cache of the source (again if it could be dynamically recompiled when needed).

compilation and compression are intimately linked.


# novel(ish) language ideas
* context free functions (pure, or only manipulating memory already exclusively allocated to that process) have only
    a single meta-algorithm, which is available throughout the whole stack.
    * the compiler should be aware if someone effectively reimplements a algorithm by hand and warn them to use the standard version
    * The same thing could be implemented multiple times as a learning exercise. Readable (but not performant) versions should be left in 
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
* pure functions as equivalent to (potentially infinite) data structures
* are zipped iterators synced or not? what are the applications of each
* deriving types from properties? Generics over properties?
* APL-like 'lifting' types, implicitly map over collection of higher rank
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
* seamless transition between compute environments
  * cpu, gpu, threaded, cloud compute
  * suitable functions (based on length hints, access patterns, derived purity) should automatically be sent to the gpu
  * for distributed compute, 
    * autogenerate networking security boundaries.
    * encryption, networking, serialized data format, consistency, defunctionalization (serializing function objects safely)
    * what are the available sync primitives?
* reduce the number of core concepts
  * expression only, no statements
  * code blocks are equivalent to immediate anonymous functions.
    * variables that are accessed in the block are parameters, variables that are set are return values.
      * the language should treat these as equivalent and be able to extract or inline functions in the editor
        with no change to lexical scoping rules
  * no garbage collection, use rust style borrow ref to determine lifetimes and collect statically
* extended language constructs
  * consider integration into the development environment as part of the language
  * documentation generator
  * editor
  * package manager
  * versioning
  * testing
  * debugging
# library topics
* desktop niceties
    * clipboard (copy and paste) - how does this tie into IPC and pipes
    * notifications
* compression
* encryption
* realtime collaboration
* data structures (efficient CRUD)
* impedance matching (data transformation)
* scheduling
* auth
    * permission models (files, people, apps, etc.)
* consensus/networking/ipc
* array of structs <=> struct of arrays (a la. JAI)


# related
* [](http://catern.com/caternetes.html)

## language design
* [Racket](https://racket-lang.org/) has probably done the most on "langauge-oriented" programming, or meta-programming
    as an explicit strength of a language.
* Lisp is the OG as far as [homoiconicity](https://en.wikipedia.org/wiki/Homoiconicity) and self-modifying programs


