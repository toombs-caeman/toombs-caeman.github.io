{{?.note}}
# Notebook System

I've kept [:physical notebooks](pens) for over a decade now, I've used various analog task-tracking/planner systems and for the past five years or so I've been working on a project I call the **primer**. I'll spare you the [:origin story](#story) and just focus on the method I use now.

Every notebook gets the same setup:
* With the front of the notebook up, write along fore-edge in black.
    * The name of the book goes on the left and its number goes on the right.
    * The name is usually the year in which it's started and the role it plays.
    * The number just goes in sequence.
* Title page - the first page (on the right side) gets my name, contact info, and the name of the notebook. This is page zero.
* Even number pages are numbered in the top right corner (zero is even).
* Index spread - the first two page spread is for the Index.
    * Pages are referenced like `title:20`. Title *then* page number, so theres' room add more pages later.
* Page titles are centered.

I usually have a few notebooks active at any given time. The division isn't so much topical as it is related to the context in which I would want to look back at something I've written.
Right now I've got:
* a journal/planner
* one for extended notes (usually for the primer)
* one for D&D stuff

Everything of importance is written into the notebooks. This ensures no writing can get lost without it being very obvious and also ensures that everything can be referenced in a uniform way.

## References
References are written shorthand that [:links](#link) things together.
I try to keep the topic of each page **atomic** so that references point to a [:single idea](#single).

here are some examples:
* `71` or `(71)` - page 71 in the current notebook
* `7.71` - page 71 in notebook 7
* `(dune 106)` - page 106 of the book [:Dune](dune). (at least of my copy, and if I care to reference it I probably have one)
* `^site` - a bookmarked website. I don't write the url, but a keyword or something
* `/file/path` - file in `~/Documents/`
* `gg project/path` - a git repo, or a file in one
    * this is a reference to the tool `gg` I wrote for navigating git projects, which is itself a reference to vim's "go to top" command `gg` and golang's `go get`, both of which inspired the tool.
* `YYYY-MM-DD` - date format

### Referencing Physical Locations
I'm still working on this. It's a written shorthand used to identify locations in my own house.

Place names should be:
* easy to create in an adhoc way
* effective to navigate to an object
* unambiguous, but not necessarily unique
* unambiguous even when spoken
* succinct to write

The basic idea is that an identifier should read as directions leading to the location in question, since that is how it will be used. The natural structure for this is to start at the largest division and get [:increasingly specific](#address).

Parts of a name:
* General areas (rooms usually) get unique [:names](#names). 
* common things get generic shorthand.
    * [:closets, shelves, etc.](#structures)
    * [:relative direction](#direction)
    * [:counts](#count)

Examples:
* `k_3+` (kitchen, floor, 3rd, cabinet) third cabinet from the left, of the lower cabinets in the kitchen
    * this could also be `kv3+`, but not `k3v+`
* `2v-v` (2nd, down, shelf, front) second shelf down (count from the top) in the front
* `2<+^` (2nd, count from right, cupboard, back) second cupboard from the right in the back
* `m<c_<` (master bedroom, leftmost, closet, floor, leftmost) on the floor of the leftmost master bedroom closet, to the left
* `oc_3x` (office, closet, floor, 3rd from left, box) in the third box from the left on the floor of the office closet


# :x addresses
For some reason neither physical addresses or URLs use the convention

# :x names
These should be short, memorable, and unambiguous.

Example:
* `m` master bedroom
* `b` master bathroom
* `gb` guest bath
* `k` kitchen
* `i` kitchen island - this isn't a room, but it gets a name to differentiate `k+` and `i+` in my house
* `w` workshop
* `o` office
* `cc` coat closet
* `lc` linen closet

# :x structures
Example:
* `_` floor
* `/` wall
* `-` shelf
* `c` closet
* `+` cupboard (shelf with a door)
* `n` table
* `x` box

# :x direction
Does 'left' mean 'from the left' or 'to the left' which is the exact opposite?

Relative directions (left, right) are given to in relation to your orientation entering the room, or when looking at a shelf.
It's ambiguous if there are multiple ways to enter a room, so just pick a 'canonical' orientation.

directions:
* `^` highest | count from the bottom | backmost | count from the front
* `v` lowest | count from the top | frontmost | count from the back
* `<` leftmost | count to the right
* `>` right most | count from the left
* `*` middle

# :x count
first, second, etc.

When giving a count I often omit the direction in which to count if it's the 'natural' direction.
* left to right
* bottom to top (lowest shelf is 1)
* front to back

you can extend this to 2d if you have a grid of shelves, but you have to decide which is the major and minor axis.
`3.4` would refer to the third major and 4 minor division.

# :x story
I started out using the **Bullet Journal** method but found it didn't suit me.
* calendar bound tasks are better tracked on an electronic calendar which can send notifications (push rather than poll)
* some of the journaling and writing I do is worth revisiting but most of my day to day tasks are not. Keeping the two interspersed diluted both efforts. I keep two separate notebooks now.
* migration, which is central to the method, seemed wasteful and tedious.

While I still use something like the bullet journal method of marking tasks, the higher level process is much more in the style of **Getting Things Done**.

# :x single ideas
This is tricky when some 'single ideas' are actually a connection between other ideas, some sort of narrative, or an argument that connects ideas in sequence. If an idea is worth refering to in isolation it gets its own page (and a backlink from the sequence).

## :x folders vs tags vs links
In the messy world of ideas, I've found that organizing things is a struggle.

The idea of tagging generally implies a duality between the task of generating content and categorizing it. One side or the other inevitably gets neglected, and ultimately it's a false duality anyway, since metadata is just data. What happens if you have thoughts on the category as a whole? Is there a privileged index which is somehow special? Pretty soon you'll have [:ten thousand kinds of data](tao#42).

Categories are like tags but worse, since they also enforce an unwarrented heirarchy. Also, because namespaces within two categories are separate, you must always copy the whole path to disambiguate references

I haven't gotten completely away from these problems with this reference system, but it's simple enough to keep using. References are unintrusive as possible. 'Categories' or 'Collections' and even the 'Index' are just pages that are referenced like any other.



