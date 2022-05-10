<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ideas</title>
</head>
<body>
<div .page-content>
<p>post/project ideas</p>
<ul>
<li>depth of learning<ul>
<li>let this repo be the 'textbook' level, with full research, external links, and more powerful, computer-aided data manipulations</li>
<li>let the notebook be more of a work in progress, include some personalizations</li>
<li>make the esoterica for the final version, fully personalized</li>
<li>internal memory is based on esoterica</li>
</ul>
</li>
<li>journey - method of loci</li>
<li>explicit theory</li>
<li>theory of mind / theory of learning</li>
<li>memory</li>
<li>
<p>mechanical reasoning <a href="https://en.wikipedia.org/wiki/TRIZ"></a></p>
<ul>
<li>the tricky part of seeing the beauty of mathematical proof is knowing enough to know which parts are mechanical thought
    and which are leaps of insight</li>
<li>by automatically generating links between related ideas with no assistance from a human, a computer can suggest previously unknown associations</li>
</ul>
</li>
<li>
<p>A <a href="https://web.stanford.edu/~engler/tickc.pdf">tcc</a> <a href="http://canonical.org/~kragen/bytebeat/">bytebeat</a> interpreter/sample generator</p>
</li>
<li>treadmill problem - given that the human senses are all limited by an <a href="https://en.wikipedia.org/wiki/Absolute_threshold">absolute threshold</a>
    some small force could be applied to the body which would be guaranteed to be unnoticeable.
    Additionally, there is a maximum force that the human body can exert.
    If we built an omni-directional treadmill (or equivalent harness for 3d), which accelerated below that threshold in
    order to dynamically keep it's user in the center, that would lay the framework for effectively infinite/boundaryless
    virtual spaces (since in all cases the 'corrective' force applied to the user would be undetectable).<ul>
<li>Given that these limits exist, how large does the treadmill need to be?</li>
<li>The max force limit depends on the max speed being finite and small, so simulated vehicles might be problematic, though
    relative force perception sensitivity decreases as absolute force increases, so perhaps this could be fudged.</li>
<li>the treadmill will essentially need to run some sort of <a href="https://en.wikipedia.org/wiki/PID_controller">PID</a> loop based on the users location.</li>
</ul>
</li>
<li>trilateration problem - might be more readable with <a href="https://github.com/KaTeX/KaTeX">KaTeX</a>.</li>
<li><a href="https://www.youtube.com/watch?v=cyW5z-M2yzw">discordant</a> <a href="https://en.wikipedia.org/wiki/Hausdorff_dimension">fractals</a>.
    Does harmony have a visual analog in fractals, or do fractals with Hausdorff dimensions close to simple fractions
    appear more orderly or aesthetic? Is there a way to generate diverse fractals with a specific hausdorff dimension?</li>
<li>
<p>can an EEG placed on the back of the neck do eye tracking based on detecting unconscious neck muscle twitches that correlate to eye movement?
    This could offer a way to do eye tracking 'in the field' where you don't have anything obstructing the field of view.
    If combined with a body cam, can you accurately locate the gaze on objects in the environment?
    search cervico-ocular reflex</p>
</li>
<li>
<p>areas of (possibly ad hoc) computer research/development that most things fall into.</p>
<ul>
<li>algorithmic - applied math. How can computers do things correctly and efficiently?</li>
<li>ergonomic - how can the language/tools/etc we use be more expressive/powerful/high-level/transparent/learnable
    and help us avoid pitfalls.<ul>
<li>whereas algorithms can be as esoteric and complicated as they need to be, the tools we use cannot be because we are only human.
    It must be possible to package performance code into a library with a relatively simple interface so that
    most people won't have to interact with that complexity most of the time.</li>
<li>all (most) of the effort being put into new languages (or the constant rotation of new javascript frameworks) belongs here.</li>
</ul>
</li>
<li>hardware - applied physics. how do we put lightning in a bottle?</li>
<li>legal - licensing, right to privacy, right to repair, ethical hacking,</li>
<li>social - how do you manage a project? How do you manage project lifetimes, or attract maintainers? codes of conduct?
    diversity and inclusion?</li>
<li>domain understanding - understanding a clients needs well enough to represent domain specific knowledge in a program.</li>
</ul>
</li>
<li>
<p>there are a few classes of problems in computer science and engineering that get solved repeatedly in adhoc ways.</p>
<ul>
<li>The huge prevalence of copypasta code is a testament to the failure to capture complexity in a library.</li>
<li>can we use stats on copied code from StackOverflow as a way to design libraries/languages and better cover common complexity?</li>
</ul>
</li>
<li>
<p>there's a very important class of computation that translates one set of symbols into another, sometimes called compiling or compilation.</p>
<ul>
<li>we can think of compiling abstractly as a translation (reversible or lossy) of a structured set of symbols into another.</li>
<li>The elements of the input don't necessarily need to be from the same set as elements in the output, nor does their structure (list, tree, etc) need to be the same.</li>
<li>my point is that there is a structural similarity between json-munging and compilers, between Terraform and LLVM.<ul>
<li>Perhaps this structure could be exploited to propagate optimizations up and down the tech stack (manually).
    What can compiler developers learn from web developers, and vice versa?</li>
<li>Perhaps also this could be used to define a 'core' compute engine that self-optimizes (self-compiles?) based on properties
    of the input and output  <a href="https://en.wikipedia.org/wiki/Category_theory">languages</a>, but is capable of running
    in a number of environments (bare metal, posix, JVM, etc.)</li>
<li>could we describe the various instruction sets and the translations between them in a unified, rigorous way?
    all the way through logic gates -&gt; x86 -&gt; system calls -&gt; JVM -&gt; javascript. Could a monolithic 'compiler'
    understand how to optimize in each of these contexts?</li>
</ul>
</li>
<li>example applications:<ul>
<li>compiling typescript to javascript</li>
<li>compiling javascript to bye code</li>
<li>generating configuration on the fly (aka turing complete wrappers for inept 'no code' tools)</li>
<li>translating between human languages</li>
<li>parsing a string into json</li>
<li>data normalization in general</li>
</ul>
</li>
</ul>
</li>
<li>
<p>the study of magic and magical thinking is useful because people turn towards alternative solutions when</p>
<ul>
<li>they can't or haven't been able to formulate the issue they're facing distinctly enough to address it directly</li>
<li>there isn't an accepted/comprehensible/workable solution to the problems they face</li>
<li>the magic works in some sense, though not necessarily through the proposed mechanisms.
    Most likely for psychological or social issues.</li>
<li>in all cases</li>
</ul>
</li>
<li>
<p>tulpa/rapscallion/servitor</p>
<ul>
<li>https://en.wikipedia.org/wiki/Tulpa</li>
<li>https://tulpanomicon.guide/</li>
</ul>
</li>
<li>
<p>the point of metaphysics isn't truth but ease of reasoning about physics</p>
<ul>
<li>this is why occam's razor is so powerful</li>
<li>given two models that 'effectively' give the same predictions, using the one that requires less computation
    allows us to predict more. and is therefore more pragmatic</li>
<li>it isn't just about getting the right answer, but also doing so in time, with our limited brains</li>
<li>once we move beyond the edge of where we can effectively find a 'correct' answer (which isn't very far)
    we need to consider answers which instead have desirable consequences
    (desirable here being subjective, and subject to manipulation)</li>
<li>occam's razor then gives us a tool by which we can reason about belief.</li>
<li>complex metaphysics are less performant and so would naturally be selected against (memetics) unless they had a hidden benefit.</li>
</ul>
</li>
<li>
<p><a href="https://store.steampowered.com/app/556180/Mysterium_A_Psychic_Clue_Game/">mysterium</a> (basically a simplified Clue)
    but instead of visions you have to send out a limited number of emojis. Could be played in chat with a bot or something.</p>
</li>
<li>
<p>explore gemini/gopherspace?</p>
</li>
<li>
<p>nomography with <a href="https://en.wikipedia.org/wiki/Cistercian_numerals">Cistercian numerals</a> to make functional and aesthetic 'magic' diagrams</p>
<ul>
<li><a href="https://www.goodreads.com/book/show/17744.The_Visual_Display_of_Quantitative_Information">The Visual Display of Quantitative Information</a></li>
<li><a href="https://deadreckonings.com/category/nomography/">nomography</a></li>
<li><a href="https://music.ishkur.com/">Iskur's Guide to Electronic Music</a> is an excellent example of dense data visualization.</li>
<li>Roche metabolic pathways map</li>
<li>culinary nomogram - imperial/metric volume on left, imperial/metric weight on right, densities of common ingredients on middle line<ul>
<li>perhaps include an unrelated Fahrenheit/Celsius temperature line</li>
<li>how to make it physically easy to read with one hand? maybe a simple pivot lock on material?</li>
</ul>
</li>
<li>DnD nomogram to represent enemy stats, percentage to make various dice checks<ul>
<li>can we represent game state with dice / rulers placed on a a nomogram</li>
</ul>
</li>
</ul>
</li>
<li>
<p>fortune telling as rorschach test</p>
<ul>
<li>many historical magics fall into this category<ul>
<li>astrology</li>
<li>tarot</li>
<li>bibliomancy (I Ching)</li>
<li><a href="http://www.princeton.edu/~ezb/geomancy/geohome.html">geomancy</a></li>
<li><a href="https://en.wikipedia.org/wiki/Astragalomancy">astragalomancy</a></li>
<li>flipping a coin to see if you're disappointed with the result</li>
</ul>
</li>
<li>shared characteristics<ol>
<li>starting with some random process.</li>
<li>Each possible result is associated with a huge variety of attributes/archetypes</li>
<li>interpretation is largely subjective, despite sometimes being legitimized through complicated process.<ul>
<li>it forces the brain to have an emotional response to a 'reality' rather than a 'possibility'</li>
</ul>
</li>
</ol>
</li>
</ul>
</li>
<li>
<p>'the sea isn't maliciously trying to kill you, it's just completely indifferent, which is worse'</p>
<ul>
<li>eldritch</li>
</ul>
</li>
<li>
<p>practices of collective imagination/storytelling</p>
<ul>
<li>D&amp;D</li>
<li>dream culture</li>
<li>mysterium</li>
</ul>
</li>
<li>
<p>enabling environments</p>
<ul>
<li>designing spaces not necessarily for the physical activities they enable, but the mental processes they enable.</li>
<li>what is the long term mental effect of living in a particular place?</li>
<li>eudaimonia machine - david dewane via cal newport</li>
<li>adaptation facilitation machine - bioneer</li>
<li>what is the psychological effect of having a library at home instead of a tv?</li>
</ul>
</li>
</ul></div>

</body>
</html>