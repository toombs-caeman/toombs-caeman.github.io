post/project ideas

* depth of learning
    * let this repo be the 'textbook' level, with full research, external links, and more powerful, computer-aided data manipulations
    * let the notebook be more of a work in progress, include some personalizations
    * make the esoterica for the final version, fully personalized
    * internal memory is based on esoterica
* journey - method of loci
* explicit theory
* theory of mind / theory of learning
* memory
* mechanical reasoning [](https://en.wikipedia.org/wiki/TRIZ)
    * the tricky part of seeing the beauty of mathematical proof is knowing enough to know which parts are mechanical thought
        and which are leaps of insight
    * by automatically generating links between related ideas with no assistance from a human, a computer can suggest previously unknown associations
        
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

* clean room compilers
  * what level of computing is it possible to audit and construct in 4 years (perhaps as a college degree) in order
    to circumvent the thompson attack? [Trusting Trust - Ken Thompson](https://www.cs.cmu.edu/~rdriley/487/papers/Thompson_1984_ReflectionsonTrustingTrust.pdf)
  * what gains could be made by having a vertically integrated hardware and software stack in the hands of an individual,
    including the tools/process needed to implement it? related to craft heritage.

* crafting heritage
  * manufacturing (the production of goods, including software) lies on a spectrum between totally manual and totally automated.
    * by manual I mean a single person (or small group) can create some functional version of the product with locally 
      available and unrefined materials
  * in all industries the extreme manual end can be done with very minimal tooling
  * in some industries, the automated end can become self-recursive / self-reliant 
    * using steel cauldrons to smelt steel
    * using compiled compilers to compile compilers
  * for a self-reliant goods, a failure to recurse necessitates a sudden shift toward the manual end.
  * In our current economy there is an extreme emphasis on automated production, because it scales better and is therefore more profitable.
  * In the case of hobbyists, most only have the resources to experiment with very manual production.
  * The middle ground is neglected. Lets call it 'semi-auto' or early industrial
  * *cue tinfoil hat*
  * this creates a potential for failure where a good is very self-reliant but unable to recurse for a short period.
  * in response its industry is unable to sustain itself at current levels, and cannot effectively scale back to
    early industrial levels because that 'middle knowledge' isn't actively kept by anyone.
  * If the failure is bad enough or the good sufficiently dependent on high quality recursion, it takes more than
    a generation to recover enough semi-auto capacity to start rebuilding fully automated capacities. 
  * at this point, not only has a generation been lost to re-industrialization, but the high end production knowledge
    has also degraded. Hopefully those running fully automated plants had the forethought to write down what they knew
    as the plants had to shut down. Hopefully that knowledge wasn't kept as an 'industry secret' for a company that
    could not possibly survive a full generation of reduced capacity.
  * *proceeds to solve a problem that probably doesn't exist*
  * support the working class of production by seizing... this isn't a shit post I swear.
  * create an industry conservatory that works to refine 'clean room' toolchains and regularly rebuilds tools from
    the ground up as a way to ensure that there's always someone around who has done it.

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

* the study of magic and magical thinking is useful because people turn towards alternative solutions when
    * they can't or haven't been able to formulate the issue they're facing distinctly enough to address it directly
    * there isn't an accepted/comprehensible/workable solution to the problems they face
    * the magic works in some sense, though not necessarily through the proposed mechanisms.
        Most likely for psychological or social issues.
    * in all cases

* tulpa/rapscallion/servitor
    * https://en.wikipedia.org/wiki/Tulpa
    * https://tulpanomicon.guide/
    
* the point of metaphysics isn't truth but ease of reasoning about physics
    * this is why occam's razor is so powerful
    * given two models that 'effectively' give the same predictions, using the one that requires less computation
        allows us to predict more. and is therefore more pragmatic
    * it isn't just about getting the right answer, but also doing so in time, with our limited brains
    * once we move beyond the edge of where we can effectively find a 'correct' answer (which isn't very far)
        we need to consider answers which instead have desirable consequences
        (desirable here being subjective, and subject to manipulation)
    * occam's razor then gives us a tool by which we can reason about belief.
    * complex metaphysics are less performant and so would naturally be selected against (memetics) unless they had a hidden benefit.
    
* [mysterium](https://store.steampowered.com/app/556180/Mysterium_A_Psychic_Clue_Game/) (basically a simplified Clue)
    but instead of visions you have to send out a limited number of emojis. Could be played in chat with a bot or something.
    
* explore gemini/gopherspace?

* nomography with [Cistercian numerals](https://en.wikipedia.org/wiki/Cistercian_numerals) to make functional and aesthetic 'magic' diagrams
    * [The Visual Display of Quantitative Information](https://www.goodreads.com/book/show/17744.The_Visual_Display_of_Quantitative_Information)
    * [nomography](https://deadreckonings.com/category/nomography/)
    * [Iskur's Guide to Electronic Music](https://music.ishkur.com/) is an excellent example of dense data visualization.
    * Roche metabolic pathways map
    * culinary nomogram - imperial/metric volume on left, imperial/metric weight on right, densities of common ingredients on middle line
        - perhaps include an unrelated Fahrenheit/Celsius temperature line
        - how to make it physically easy to read with one hand? maybe a simple pivot lock on material?
    * DnD nomogram to represent enemy stats, percentage to make various dice checks
        * can we represent game state with dice / rulers placed on a a nomogram
    
* fortune telling as rorschach test
    * many historical magics fall into this category
        - astrology
        - tarot
        - bibliomancy (I Ching)
        - [geomancy](http://www.princeton.edu/~ezb/geomancy/geohome.html)
        - [astragalomancy](https://en.wikipedia.org/wiki/Astragalomancy)
        - flipping a coin to see if you're disappointed with the result
    * shared characteristics
        1. starting with some random process.
        2. Each possible result is associated with a huge variety of attributes/archetypes
        3. interpretation is largely subjective, despite sometimes being legitimized through complicated process.
            * it forces the brain to have an emotional response to a 'reality' rather than a 'possibility'
* 'the sea isn't maliciously trying to kill you, it's just completely indifferent, which is worse'
    * eldritch

* practices of collective imagination/storytelling
    * D&D
    * dream culture
    * mysterium

* enabling environments
    * designing spaces not necessarily for the physical activities they enable, but the mental processes they enable.
    * what is the long term mental effect of living in a particular place?
    * eudaimonia machine - david dewane via cal newport
    * adaptation facilitation machine - bioneer
    * what is the psychological effect of having a library at home instead of a tv?
    
