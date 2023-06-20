{{?.note}}
# Features of a Dream Language
my dream answer to the questions of [:programming language design](pl)

# core
## coroutines | fibers | green threads, channels
[fibers oh my](https://graphitemaster.github.io/fibers/)
[go channels](https://go.dev/tour/concurrency/2)

## laziness, generators, async
* 'lazy' values aren't computed until 'required'. This should allow for infinite generators and such
* async values are computed in parallel threads. They aren't lazy, but execution will wait for them to finish as if they were

## algebraic effects
[algebraic effects](https://overreacted.io/algebraic-effects-for-the-rest-of-us/)

## option for declarative function interfaces
* why let sql be the king of declarative syntax?
* if there are multiple implementations of how to select which one to use by collecting runtime statistics.
* efficiency depends on size of input, but also number of cpu cores
* highly parallel declarative functions should run on the gpu when it is efficient to do so. *This should not require any explicit change to the code*

## repl | compile-time
* the full language should be available at compile-time

## memory management
* rusty?

# syntax

# tooling | ecosystem
* imports like golang
    * vendoring?
    * versioning freezing
* git aware
    * should be able to prove that all required source/resources are tracked in git
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
* FFI
* cross compiling
* a page like [learnxiny](https://learnxinyminutes.com/)
