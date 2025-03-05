# @
I'm designing a system for naming locations in the home where things are stored,
like a filing system for papers, but in 3d space.

It should be:
* easy to create in an adhoc way, like how you would direct someone to it by speaking
* effective to navigate to an object
* unambiguous even when spoken
* succinct to write

status: not used, not tested
# heirarchy
Give rooms unique names like `master` or `B` for the master bedroom.
levels of a heirarchy are separated with `.`, starting with the largest division.

# names
give name such that the structure abbreviations will be obvious. Generally each room will have a name.
* `m` master bedroom
* `mb` master bathroom
* `gb` guest bath
* `k` kitchen
* `i` kitchen island - this isn't a room, but it gets a name to differentiate `k+` and `i+`
* `w` workshop
* `o` office
* `cc` coat closet
* `lc` linen closet

# axis
cupboards are counted left to right.
shelves are counted from the floor up.
you can extend this to 2d if you have a grid of shelves, but you have to decide which is the major and minor axis.
`3.4` would refer to the third major and 4 minor division.

relative directions (left, right) are given to in relation to your orientation entering the room, or when looking at a shelf.
floors are counted normally.

# generic abbreviations
use `.` as a separator if needed
structures
* `_` floor
* `/` wall
* `-` shelf
* `c` closet
* `+` cupboard (shelf with a door)
* `n` table
* `x` box

counts - before what they describe
* `2-` second shelf (shelfs are implicitly counted from the bottom)
* `2v` second from the top or second from the back

directions - after what they describe (these are arrows)
* `^` highest | count from the bottom | backmost | count from the front
* `v` lowest | count from the top | frontmost | count from the back
* `<` leftmost | count to the right
* `>` right most | count from the left
* `*` middle
# examples
counts are given before the thing being counted (as you would when speaking)
* `2v-v` second shelf down (count from the top) in the front
* `2<+^` second cupboard from the right in the back (2nd, count from right, cupboard, back)
* `m<c_<` (master bedroom, leftmost, closet, floor, leftmost) = on the floor of the leftmost master bedroom closet, to the left
* `o.c_3x` (office, closet, floor, 3rd from left, box) = in the third box from the left on the floor of the office closet

