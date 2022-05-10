<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Compendium</title>
</head>
<body>
<div .page-content>
<p>title: Compunomicon</p>
<p>I've been obsessing lately over the idea that there's no good reason why there is more than a single implementation of sort present on a single computer.
Why is it that we need sort implemented in C, python, javascript, etc. each with a (potentially) different and arbitrary choice of algorithm?</p>
<p>Can a single language be simple enough at its core to compile it by hand (a la. <a href="https://en.wikipedia.org/wiki/TMG_(language)">Ken Thompson's great story</a>)
but that can meta-program itself well enough to be viable on all levels of the stack?</p>
<p>I'm imagining a hyper-monolith that is compiler, operating system, scripting language, browser, and javascript all in one.
It would run on desktops, tablets, super-computers, smartphones, and micro-controllers. It's meta-algorithms would select
the appropriate way to sort given what it knows about its resource constraints, and the data it is sorting.</p>
<p>The data it collects on what is sorted, how often and how much, would be compiled. It would know its own strengths and weaknesses.
This data can be used tune the meta-algorithm. Perhaps that tuning would inform the next generation of chip design.
The monolith can compile real world performance analytics into verilog, to produce a chip that will perform faster.</p>
<p>The monolith generates its own documentation from its own source with the right flag.</p>
<p>I believe all the pieces exist, in one form or another. The only question is if they all fit together in a useful shape.</p>
<h1>computer literacy</h1>
<p>the day everyone has a basic understanding of computing we will see a fundamental shift in our society similar to the shift seen in preliterate to literate.
It think it may be useful to develop a lingua franca for this situation while we have the opportunity.</p>
<h1>a case for small, composable orthogonal DSLs that build up to a general language</h1>
<ul>
<li>a data language defines data literals<ul>
<li>understand a small set of widely used </li>
</ul>
</li>
<li>deliberately avoid making a DSL turing complete.<ul>
<li>Having multiple ways to do general computing creates an extra burden in writing and understanding.</li>
<li>by having 'one true' way to </li>
</ul>
</li>
</ul>
<p>base types
* text - every supported format should be representable by one type.</p>
<h1>It's not just sort</h1>
<p>the same ideas recur, with varying levels of sophistication, in widely different contexts.</p>
<p><a href="https://en.wikipedia.org/wiki/Inter-process_communication">IPC</a> is just <a href="https://en.wikipedia.org/wiki/Computer_network">networking</a>.</p>
<p>ISAs are DSLs</p>
<p>everything turing complete is equivalent.</p>
<p>The browser is a desktop environment with better ergonomics for how it installs programs (websites are turing complete after all)</p>
<p>Caching happens in the processor (from memory), in memory (from the disk), in the disk (from the network) and in the CDN (from the site).
If a program can be programmatically re-installed or updated when needed, how is that different than a cached web resource?
Even a compiled binary could be considered a cache of the source (again if it could be dynamically recompiled when needed).</p>
<p>compilation and compression are intimately linked.</p>
<h1>novel(ish) language ideas</h1>
<ul>
<li>context free functions (pure, or only manipulating memory already exclusively allocated to that process) have only
    a single meta-algorithm, which is available throughout the whole stack.<ul>
<li>the compiler should be aware if someone effectively reimplements a algorithm by hand and warn them to use the standard version</li>
<li>The same thing could be implemented multiple times as a learning exercise. Readable (but not performant) versions should be left in 
    so they can be available for the book/learning version.</li>
<li>competing ways of doing the same task should be maintained, especially if they prioritize competing performance metrics.
    They can be tested for correctness against each other, and context aware compilation can pick one over the other.</li>
</ul>
</li>
<li>top-level applications mark which functions a human user will be waiting on (real-time, human-facing IO) versus functions
    on which performance is not hyper noticeable.<ul>
<li>this allows meta-algorithms to experiment with various implementations in contexts where no one will notice to gather real performance statistics
    on the current context.</li>
<li>real performance statistics are used to find the optimal algorithm to apply in the human-facing scenario</li>
<li>this optimization / recompilation happens in the background</li>
</ul>
</li>
<li>
<p>truly DAG filesystems or tag based systems</p>
<ul>
<li>use 'everything is a file' paradigm to expose dag query api</li>
</ul>
</li>
<li>
<p>strong separation between persistent state and intermediate representations</p>
</li>
<li>what if we handle persistence as a type property?</li>
<li>strong separation between state transitions and data transformations</li>
<li>state transitions &lt;-&gt; state &lt;-&gt; transformations &lt;-&gt; IO</li>
<li>pure functions as equivalent to (potentially infinite) data structures</li>
<li>are zipped iterators synced or not? what are the applications of each</li>
<li>deriving types from properties? Generics over properties?</li>
<li>APL-like 'lifting' types, implicitly map over collection of higher rank</li>
<li>SOA/AOS implicitly convert data model from array of structs to struct of arrays based on length hints and static analysis of access patterns</li>
<li>easy convert between call styles</li>
<li>immediate call, callback/continuation, partial/delayed</li>
<li>consider the entire programming environment as 'part of the language'</li>
<li>package manager<ul>
<li>versioning</li>
<li>installation</li>
</ul>
</li>
<li>editor integration<ul>
<li>language designed for powerful refactoring? </li>
</ul>
</li>
<li>language hooks/interop</li>
<li>seamless transition between compute environments</li>
<li>cpu, gpu, threaded, cloud compute</li>
<li>suitable functions (based on length hints, access patterns, derived purity) should automatically be sent to the gpu</li>
<li>for distributed compute, <ul>
<li>autogenerate networking security boundaries.</li>
<li>encryption, networking, serialized data format, consistency, defunctionalization (serializing function objects safely)</li>
<li>what are the available sync primitives?</li>
</ul>
</li>
<li>reduce the number of core concepts</li>
<li>expression only, no statements</li>
<li>code blocks are equivalent to immediate anonymous functions.<ul>
<li>variables that are accessed in the block are parameters, variables that are set are return values.</li>
<li>the language should treat these as equivalent and be able to extract or inline functions in the editor
    with no change to lexical scoping rules</li>
</ul>
</li>
<li>no garbage collection, use rust style borrow ref to determine lifetimes and collect statically</li>
<li>extended language constructs</li>
<li>consider integration into the development environment as part of the language</li>
<li>documentation generator</li>
<li>editor</li>
<li>package manager</li>
<li>versioning</li>
<li>testing</li>
<li>debugging</li>
</ul>
<h1>library topics</h1>
<ul>
<li>desktop niceties<ul>
<li>clipboard (copy and paste) - how does this tie into IPC and pipes</li>
<li>notifications</li>
</ul>
</li>
<li>compression</li>
<li>encryption</li>
<li>realtime collaboration</li>
<li>data structures (efficient CRUD)</li>
<li>impedance matching (data transformation)</li>
<li>scheduling</li>
<li>auth<ul>
<li>permission models (files, people, apps, etc.)</li>
</ul>
</li>
<li>consensus/networking/ipc</li>
<li>array of structs &lt;=&gt; struct of arrays (a la. JAI)</li>
</ul>
<h1>related</h1>
<ul>
<li><a href="http://catern.com/caternetes.html"></a></li>
</ul>
<h2>language design</h2>
<ul>
<li><a href="https://racket-lang.org/">Racket</a> has probably done the most on "langauge-oriented" programming, or meta-programming
    as an explicit strength of a language.</li>
<li>Lisp is the OG as far as <a href="https://en.wikipedia.org/wiki/Homoiconicity">homoiconicity</a> and self-modifying programs</li>
</ul></div>

</body>
</html>