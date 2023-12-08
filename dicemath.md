{{?.note}}
<link rel="stylesheet" href=".LDT.css" type="text/css">

# Dice math

<div><canvas #myChart></canvas></div>
<button #update-chart>run chart</button>
<textarea #codeArea .ldt></textarea>

<script src="https://code.jquery.com/jquery-3.7.1.slim.min.js" integrity="sha256-kmHvs0B+OpCW5GVHUNjv9rOmY0IvSIRcf7zGUDTDQM8=" crossorigin="anonymous"></script>
<script src=".LDT.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = $('#myChart')[0];
    var chart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: ['Red', 'Blue', 'Yellow', 'Green', 'Purple', 'Orange'],
        datasets: [{
          label: '# of Votes',
          data: [12, 19, 3, 5, 2, 3],
          borderWidth: 1
          },{
          label: '# of Votes',
          data: [12, 16, 3, 5, 2, 3],
          borderWidth: 1
        }]
      },
      options: { scales: { y: { beginAtZero: true } } }
    });
    var parser = new Parser({
        newline: /\n/,
        whitespace: /\s+/,
        die: /d\d+|f/,
        num: /\d+/,
        tag: /[/\\]/,
        agg: /[+#]/,
        other: /\S+/,
    });
    var ldt = new TextareaDecorator( $('#codeArea')[0], parser );
    function range(size, startAt = 0) {
        return [...Array(size).keys()].map(i => i + startAt);
    }
    $("#update-chart").on("click", function() {
        var tokens = parser.tokenize($('#codeArea').val());
        var label = "";
        var dice = [];
        for (const token of tokens) {
            console.log(token);
            console.log(parser.identify(token));
        }
        // memoize?
        // generate datasets to place in chart.data.datasets[]
        chart.update();
    });
</script>
<style>
/* styles applied to comment tokens */
.ldt .comment { color: silver; }
.ldt .string { color: green; }
.ldt .die { color: royalblue; }
.ldt .num { color: blue; }
.ldt .tag { color: green; }
.ldt .agg { color: forestgreen; }
.ldt .other { color: darkorange; }
.ldt {
	width: 100%;
	height: 300px;
	border: 1px solid black;
}
.ldt pre { background: rgba(0,0,0,0); }
</style>

# DSL (Dice Specific Language)
* `<count><type>` designates `count` dice of `type`
    * `<count>` is a number
    * normal numerical dice are written as `d6` (6-sided dice, faces valued at 1 to 6).
    * fate dice are designated `f`
    * if no type is given, count is taken to be a flat modifier (perhaps negative)
* aggregate modes
    * sum `+` adds the values together
    * advantage `^` takes the highest value of any die
    * count `#/<target>` or `#\<target>` counts the dice that roll over or under target
    * target `/<target>` or `\<target>` successful if the previous
    * examples
        * `+ /15` - add dice together. Success is greater or equal to 15
        * `#\3 /4` - count the number of dice that rolled under 3, looking for at least 4
    * concatenate, as in for d66 tables
* names `<name> =` gives a name
* unknown `?` designates a number which should be left as an input box

# aggregates
`+` sum (default)
`#` count of faces (pool)
`= > < >= <= !=` target
# operators
`+` add
`^` `!^` advantage/disadvantage
`name` name
* exploding dice
# values
`f` fate/fudge dice
`d` numerical dice
`p` pips
`%` previous dice set


# Rolling with Advantage
[:numberphile video](https://www.youtube.com/watch?v=X_DdGRjtwAo)

probability for any number x in 2dN^ `p(x) = (2x-1)/N**2`
average for 2dN^ `(N+1)*(4N-1)/(6N)` ~2/3
average for 3dN^ ~>3/4

# d10
d10 vs 2d10^ vs 2d10%2
2d10 vs d100

# d6
pips can modify the face of a die (star wars d6)


# ref
* [mental rolls](https://groups.google.com/g/sci.math/c/6BIYd0cafQo/m/Ucipn_5T_TMJ)
