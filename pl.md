{{?.note}}
# Programming Language Design
what is a programming language?
or So you want to design a language.
and bits and pieces to consider when designing a language

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
Is your language a meme?
How long do you expect it to take for a competant programmer who's not familiar with the language to become productive?
