{{?.note}}
# Features of a Dream Language
my dream answer to the questions of [:programming language design](pl)

# TOC
* [values](#values)
* [syntax](#syntax)
* execution
    * [distributed](#distributed)
    * [parallel](#concurrency)


# variables | variable flags
variables are references to values
types are (potentially infinite) sets of values with common properties
## values
kinds of values:
* `immediate` - value is evaluated when defined (assigned).
* `symbol` - value is an ast, which must be explicitly evaluated
    * this is the homoiconic type, like lisp quote
    * syntactically, symbols are functions of zero arguments
* `lazy` - value is implicitly evaluated when required, but not when defined.
    * Current thread blocks during evaluation.
    * implicitly memoized (threadsafe eval once? unless marked pure)
    * can be used to create infinite lists and such
    * how about pythonic [descriptors](https://docs.python.org/3/howto/descriptor.html)?
    * laziness is [:transparent](https://en.wikipedia.org/wiki/Referential_transparency).
* `async`
    * computation starts in a separate thread when the value is defined
    * unlike a lazy value, all async values will be evaluated eventually (unless program hard exits without join).
    * current thread will block if async value isn't ready
    * need an operator to check if a value has finished computing.

## references
reference flags:
* `persistent` initialized to types zero value or saved value. guaranteed to save to disk on program exit.
* `mutable` like rust.
* `scope` change the scoping of the reference (local)

## memory management
* rusty borrowing?


## types | properties
types can be derived from 'properties' which may be interfaces, or may give guarantees about behavior.
Properties themselves may be derived from implementations.
* Compile-time exception when there is no implementation that matches the requested property
* Compiler chooses among options when multiple implementations exist.

property types:
* `interface` type implements some method(s)
* `algebraic` type has algebraic property (eg [:commutative](https://en.wikipedia.org/wiki/Commutative_property))
    * in order to enable compile-time optimizations by symbolic algebra
* `side effect` type mutates global reference, depends on IO, or is pure.
    * functions may be `idempotent` even if they aren't pure
* `threadsafe`
* `ordering` type exhibits certain [:ordering properties](https://en.wikipedia.org/wiki/Total_order)
* `scale` efficient implementation may depend on the size of the input
    * a hash map may use a simpler hashing function for ~10 keys than ~10k
    * a list that's < n items might sort faster with [insertion sort](https://en.wikipedia.org/wiki/Insertion_sort)
    * 10 threads may run faster on a single cpu, while 10k threads may be faster to run on a distributed cluster (if one is available)
    * base on collecting runtime statistics?
    * efficiency depends on size of input, but also number of cpu cores

## builtin types
* `ast` lisp's quote type
* `number` the programmer shouldn't have to decide if 32f or 64i unless they care
* `collection` like python's collections

# execution
## repl | compile-time | reflection
* [pure compile time](https://en.wikipedia.org/wiki/Compile-time_function_execution)
* homoiconic
* the full language should be available in compile-time macros
* the repl is the compiler. Pausing the repl to create an executable

## concurrency
* [fibers oh my](https://graphitemaster.github.io/fibers/)
* [go channels](https://go.dev/tour/concurrency/2)
* [mutex/semaphore](https://en.wikipedia.org/wiki/Semaphore_(programming)#Semaphores_vs._mutexes)

## distribution
* highly parallel declarative functions should run on the gpu when it is efficient to do so. *This should not require any explicit change to the code*
* serialization & networking should be such configuring a cluster of CPUs to distribute a program is straightforward and does not require special handling (the same code will run threads locally or distribute threads to the cluster if one is configured and it is efficient to do so.)

# control flow
let `if` be a special case of `match case`
unify `for` and `while` using lazy generators
## algebraic effects
[algebraic effects](https://overreacted.io/algebraic-effects-for-the-rest-of-us/)

## option for declarative function interfaces
* why let sql be the king of declarative syntax?


# syntax
* modify syntax at compile-time

# = | := | ==
* `==` is equality
    * returns true if the left and right values are the same otherwise returns false
    * `1 == 1` returns true
* `:=` is assignment
    * the left expression is made to be equal to the right expression at the time of evaluation.
    * as an expression, return the left expression.
    * equality may not hold as values are re-assigned.
    * `x := 3` returns `'x` and the value of `x` is 3
```
x := 3
y := x - 1
x := 2
x # 2
y # 2
```
* `=` is a bi-directional constraint
    * the left expression will always equal the right expression (within the current scope)
    * functions on the left and right expressions must have an algebraic inverse
    * underdetermined systems of equations are considered uninitialized
    * adding a contradictory constraint is an error
```
x := 3
y = x - 1
x := 2
x # 2
y # 1 !!!
y := 3
x # 4 !!!
2 * a + 5 * b = 19
a - 2 * b = -4
a # 2
b # 3
```
# tooling | ecosystem
* source uses [utf-8](https://en.wikipedia.org/wiki/UTF-8)
* imports like golang
    * vendoring?
    * versioning freezing
* git aware
    * should be able to prove that all required source/resources are tracked in git
    * [report config files](https://news.ycombinator.com/item?id=36465886)
* 'make'-like runbook
* syntax highlighting lsp
* linter
* official color theme?
* official standard setup for common editors
* documentation generator / comment syntax
* serialization
* repl, despite having static types
* testing framework
* logging
* debugging
* FFI, calling shell utilities
* cross compiling
* a page like [learnxiny](https://learnxinyminutes.com/)

# inbox
* [: a real engineer doesn't want just a religion about how to solve a problem](https://youtu.be/HB5TrK7A4pI?t=2346)
    * strangeloop 2011 gerald sussman [:summary](https://youtu.be/HB5TrK7A4pI?t=3701)
    * how can differing paradigms all fit into a language and talk, so the type of programming matches the thing it models
    * [constraint propogation (bi-directional equations)](https://youtu.be/HB5TrK7A4pI?t=2431)
    * advances in science are based on useful lies
    * hardware design that implements information propogation instead of logic gates. Highly parallel machines that don't need to sync
* pointers?
* memoized functions
* assume lazy or assume eager? probably not assume async
    * pure values assumed lazy. non-local or threadsafe references assumed eager. IO is ordered async
