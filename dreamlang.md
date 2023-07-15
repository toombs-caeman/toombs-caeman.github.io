{{?.note}}
# Features of a Dream Language
my dream answer to the questions of [:programming language design](pl)

# feature list | elevator pitch
* 
# TOC
* [values](#values)
* [syntax](#syntax)
* execution
    * [distributed](#distributed)
    * [parallel](#concurrency)

# base properties
## value properties
* lazy, symbol, async
## variable properties
* &reference, * dereference
* persistent, mutable
## type properties


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
* [mutex/semaphore](https://en.wikipedia.org/wiki/Semaphore_(programming))

## distribution
* highly parallel declarative functions should run on the gpu when it is efficient to do so. *This should not require any explicit change to the code*
* serialization & networking should be such configuring a cluster of CPUs to distribute a program is straightforward and does not require special handling (the same code will run threads locally or distribute threads to the cluster if one is configured and it is efficient to do so.)

# control flow
lets enumerate the types of control flow using the concept of an evaluation atom.
An atom consumes a [:single](#composite) value at the beginning and produces a [:single value](#return) at the end, and otherwise may be considered pure and atomic. The [:valence](https://en.wikipedia.org/wiki/Degree_(graph_theory)) of an atom is always 2.

**Note:** atoms only need to be *considered* pure and atomic, but this may not be literally true.

"Control Flow" usually refers to stuff like loops and ifs, but lets define it more exactly as any construct connects atoms together (like chemical bonds). 

## Boundary of Computation
Say a computer is hooked up to a light switch. The computer can both flip the switch and query its state.
You could say that the state of the switch acts as a single bit of 'switch memory', where writing that bit sets the state of the switch, and reading queries the state.

However, unlike memory a human could also flip the switch. Or the switch could be taped to the off position.

Therefore writing `1` to the 'switch memory' does not causally imply that reading the 'switch memory' will result in `1` in the same way as normal memory.

For the purpose of our model, the written and read value cannot be considered the same value. One value was written, and another was read, with only a tenuous correlational link between the two.

Thus we can meaningfully talk about values being 'created' as they enter the boundary of computation, and 'destroyed' as they exit. They are [:a posteriori](https://en.wikipedia.org/wiki/A_priori_and_a_posteriori).

## purity
A function is usually considered pure if the function alway evaluates to the same result given the same arguments.
The usual understanding is that 'arguments' refers to those explicitly passed.

## Input Flow
evaluation that produces a value 'from nothing'.
* values are 'created' through input to the program
* Literal values can be considered in this category, though they 'exist' within the boundary of computation as it is initialized.
* the result of a random function is intended to be causally independent from the program state and so has to be treated as information entering the boundary of computation, regardless of whether or not the function is truly random.

## Output Flow
Evaluation that consumes a value and does not produce one (within the boundary).
Evaluation can always be culled unless it potentially causes an effect outside the boundary.

## Sequential Flow
The simplest bond is to connect the output of one atom to the input of another atom.
The molecule may be considered itself an atom, as it has a single input and a single result.

This is like a list.

## Duplicating Flow
A single value is copied to the inputs of 2+ atoms
* forth's `dup` is a very direct example of this
* assignment is often used as preparation for duplication

## Parallel Flow
A single value may need to be routed to multiple independent atoms. These are explicitly copies, not references, as each atom must be independent.

## Aggregating Flow
Aggregation takes 2 or more and produces a single value.
* functions of multiple arguments `f(a, b, c)`
* dyadic operators
* This can be like python's `functools.reduce()`
* or simply `[x, y, z]` that produces a single list from many values

## Conditional Flow
Consumes
    * if - equivalent to case(true, false)
    * case 
    * match

* functions of one value, that return
* assignment gives a name to the end of a chain of atoms
* variables are a way of giving a name to a partial execution
* sequential flow (single atom) - order of execution impacts final result
    * line to line 'normal' flow
    * function calls (which *could* be inlined)
    * while loops - control is sequential until the condition returns
    * non-pure for loops
* parallel flow - the order of execution does not change the outcome
    * foreach (w/o break) (ie pure for loops)
    * atoms
* aggregating flow - multiple branch
let `if` be a special case of `match case`
unify `for` and `while` using lazy generators

This is like a dict

# dataflow based editing primitives
* find usage of a variable, push name up or down the evaluation flow
* intersect a computation, putting it on a new line and assigning a name


# :x composite
The 'single' value may be a composite or aggregate type. The idea is that all arguments must be prepared before any evaluation of the thread may take place.
Specifying 'one' value is useful so we can talk about aggregation separately.

# :x return
Again, the return type may be composite.
A thread may also mutate a reference rather than explicitly returning a value, however the reference must be exclusive (like rust's mutable reference), write-only, or otherwise unable to affect the result after evaluation has begun.

## : thread examples
Some examples:

## algebraic effects
[algebraic effects](https://overreacted.io/algebraic-effects-for-the-rest-of-us/)

## option for declarative function interfaces
* why let sql be the king of declarative syntax?
sql as an embedded dsl interacting with native types. APL with permanence and transaction guarantees


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
* [bi-directional type inference](https://whileydave.com/2022/06/15/type-checking-in-whiley-goes-both-ways/)
* formal verification/probabilistic verification?
    * verification of declared properties rather than full
* resumable exceptions are just calls to undefined functions? Unwind the call stack to find a namespace containing the matching signature, or a traditional try/catch
* un/boxing | splat | un/packing
    * ⊙ ∈ (set containing, or element of)
* [:function domain](https://en.wikipedia.org/wiki/Domain_of_a_function)
* [:information flow diagram](https://en.wikipedia.org/wiki/Information_flow_diagram)
* abstract away the order of evaluation (which is the focus of procedural programming)
    * focus on functions (composition?)
    * focus on data (causal flow?)

* comparators should return >0 if greater than, 0 if equal, <0 if less than
    * greater numbers hint at larger distances between values (relative to total type space).
    * for numbers, cmp(n, o) =: n-o
* [j nuvoc](https://code.jsoftware.com/wiki/NuVoc)
    * filter in terms of sieve, define sort in terms fo permute
        * slice is filter
* automatic function lifting (map) for `vector<T>` when `T` is expected
    * `f(T)->U` lifts to `f(vector<T>)->vector<U>`
* null types
    * `⊥` cannot appear in lists, so can map and filter are the same, a filtered out function returning `⊥`
* enums are numbers given names and treated as a distinct unit, finite const set?
* `count of element` operator defined for containers is equivalent to `contains` for sets
* list comprehensions
* partials + assignment allow for naming any stage of evaluation

* can we do auto AOS↔SOA conversion
* functions are closures, symbols are not
«a b c»

# operators (functions of one or two arguments)
|base   | dyadic    | monadic   | `/` prefix    | `!` prefix    | `:` prefix |
|-------|-----------|-----------|---------------|---------------|------------|
| `=`   | equation  |           | equal         | not equal     | assign     |
| `*`   | multiply  |           | and           | nand          | bit and    |
| `+`   | add       | abs       | or            | nor           | bit or     |
| `-`   | subtract  | invert    | xor           | xnor          | bit xor    |
| `/`   | divide    |           | int div       | modulo        |            |
| `<`   |           |           | less than     | not less than | lshift     |
| `>`   |           |           | greater than  | not less than | rshift     |
| `.`   | access    |           |               | safe access   |            |
| `&`   |           | ref to    |               | deref         |            |
| `!`   |           | not       |               |               | bit not    |
| `_`   |           | floor     |               | ceiling       |            |
| `|`   | map/filter| lambda    |               |               | mask       |
| `:`   |           |           | zip?          |               | parse      |
|-------|-----------|-----------|---------------|---------------|------------|

# special values
| name | usage              |
|------|--------------------|
| `!|` | filter out         |
| `$`  | mono argument      |
| `.$` | left argument      |
| `:$` | right argument     |
|------|--------------------|

# unused symbols
@#%^~\"

# literal types
| delimiter     | name              |
|---------------|-------------------|
| `(` `,` `)`   | block/group       |
| `[` `,` `]`   | list              |
| `{` `,` `}`   | set               |
|`{` `:` `,` `}`| dict              |
| `<` `>`       | symbol            |
| `'`           | string            |
| `` ` ``       | comment?          |
| `r'` `'`      | raw string        |
| `f'` `'`      | format string     |
| `R'` `'`      | regex             |
|---------------|-------------------|

# control flow
| delimiter     | name              |
|---------------|-------------------|
| if then else  | ternary           |
| `/?` `:` `:`  | cmp               |

# Fibonacci sequence
`fib := | $ !> 2 ? 1 : fib($-1) + fib($-2)`
