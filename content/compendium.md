title: Compunomicon

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


