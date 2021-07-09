title:Ideas
===

post/project ideas

* A [tcc](https://web.stanford.edu/~engler/tickc.pdf) [bytebeat](http://canonical.org/~kragen/bytebeat/) interpreter/sample generator
* treadmill problem - given that the human senses are all limited by an [absolute threshold](https://en.wikipedia.org/wiki/Absolute_threshold)
    some small force could be applied to the body which would be guaranteed to be unnoticeable.
    Additionally, there is a maximum force that the human body can exert.
    If we built an omni-directional treadmill (or equivalent harness for 3d), which accelerated below that threshold in
    order to dynamically keep it's user in the center, that would lay the framework for effectively infinite/boundaryless
    virtual spaces (since in all cases the 'corrective' force applied to the user would be undetectable).
    * Given that these limits exist, how large does the treadmill need to be?
    * The max force limit depends on the max speed being finite and small, so simulated vehicles might be problematic, though
        relative force perception sensitivity decreases as absolute force increases, so perhaps this could be fudged.
    * the treadmill will essentially need to run some sort of [PID](https://en.wikipedia.org/wiki/PID_controller) loop based on the users location.
* trilateration problem - might be more readable with [KaTeX](https://github.com/KaTeX/KaTeX).
* [discordant](https://www.youtube.com/watch?v=cyW5z-M2yzw) [fractals](https://en.wikipedia.org/wiki/Hausdorff_dimension).
    Does harmony have a visual analog in fractals, or do fractals with Hausdorff dimensions close to simple fractions
    appear more orderly or aesthetic? Is there a way to generate diverse fractals with a specific hausdorff dimension?
* can an EEG placed on the back of the neck do eye tracking based on detecting unconscious neck muscle twitches that correlate to eye movement?
    This could offer a way to do eye tracking 'in the field' where you don't have anything obstructing the field of view.
    If combined with a body cam, can you accurately locate the gaze on objects in the environment?
    search cervico-ocular reflex

* areas of (possibly ad hoc) computer research/development that most things fall into.
    * algorithmic - applied math. How can computers do things correctly and efficiently?
    * ergonomic - how can the language/tools/etc we use be more expressive/powerful/high-level/transparent/learnable
        and help us avoid pitfalls.
        * whereas algorithms can be as esoteric and complicated as they need to be, the tools we use cannot be because we are only human.
            It must be possible to package performance code into a library with a relatively simple interface so that
            most people won't have to interact with that complexity most of the time.
        * all (most) of the effort being put into new languages (or the constant rotation of new javascript frameworks) belongs here.
    * hardware - applied physics. how do we put lightning in a bottle?
    * legal - licensing, right to privacy, right to repair, ethical hacking,
    * social - how do you manage a project? How do you manage project lifetimes, or attract maintainers? codes of conduct?
        diversity and inclusion?
    * domain understanding - understanding a clients needs well enough to represent domain specific knowledge in a program.

* there are a few classes of problems in computer science and engineering that get solved repeatedly in adhoc ways.
    * The huge prevalence of copypasta code is a testament to the failure to capture complexity in a library.
    * can we use stats on copied code from StackOverflow as a way to design libraries/languages and better cover common complexity?

* there's a very important class of computation that translates one set of symbols into another, sometimes called compiling or compilation.
    * we can think of compiling abstractly as a translation (reversible or lossy) of a structured set of symbols into another.
    * The elements of the input don't necessarily need to be from the same set as elements in the output, nor does their structure (list, tree, etc) need to be the same.
    * my point is that there is a structural similarity between json-munging and compilers, between Terraform and LLVM.
        * Perhaps this structure could be exploited to propagate optimizations up and down the tech stack (manually).
            What can compiler developers learn from web developers, and vice versa?
        * Perhaps also this could be used to define a 'core' compute engine that self-optimizes (self-compiles?) based on properties
            of the input and output  [languages](https://en.wikipedia.org/wiki/Category_theory), but is capable of running
            in a number of environments (bare metal, posix, JVM, etc.)
        * could we describe the various instruction sets and the translations between them in a unified, rigorous way?
            all the way through logic gates -> x86 -> system calls -> JVM -> javascript. Could a monolithic 'compiler'
            understand how to optimize in each of these contexts?
    * example applications:
        - compiling typescript to javascript
        - compiling javascript to bye code
        - generating configuration on the fly (aka turing complete wrappers for inept 'no code' tools)
        - translating between human languages
        - parsing a string into json
        - data normalization in general

* a theory of note taking is a partial theory of mind
    * the purpose of notes is to extend the memory / reasoning ability of the user
    * this is equivalent to a theory of how the mind can efficiently digest, retain and share information about the world
    * qualities
        - ease of creation
        - ease of recovery (search/sort/structure)
            * auto-indexing, full text search, deduplication and crosslinking
            * mnemonic structure
        - ease of sharing (external reference/permanence/jargon) (use by others, rather than by older you)
        - appropriate depth placement (according to discovery/memorization/practice/identity structure)
    * ref
        - [memex](https://www.w3.org/History/1945/vbush/)
        - https://thesephist.com/posts/inc/
        - https://notes.andymatuschak.org/About_these_notes?stackedNotes=zUw5PuD8op9oq8kHvni6sug6eRTNtR9Wqma

* the study of magic and magical thinking is useful because people turn towards alternative solutions when
    * they can't or haven't been able to formulate the issue they're facing distinctly enough to address it directly
    * there isn't an accepted/comprehensible/workable solution to the problems they face
    * the magic works in some sense, though not necessarily through the proposed mechanisms.
        Most likely for psychological or social issues.
    * in all cases

* tulpa/rapscallion/servitor
    * https://en.wikipedia.org/wiki/Tulpa
    * https://tulpanomicon.guide/