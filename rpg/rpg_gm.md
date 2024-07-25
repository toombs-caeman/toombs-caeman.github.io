* general advice for gms
    * how to start, how to improve
    * how to run this system
    * how to not burn out: you don't have to be secretary, host and storyteller
    * tracks/clocks
    * chunks
    * rules of thumb
        * it's not really real until its directly referenced at the table. Don't be afraid to scrap your plans
    * scene card
    * oracles to replace gm for solo play, GMless play?
* solo mode/ oracle?
* economies (in-world currency, actions) and how to break them.
* running genre
    * mystery: the three clue rule. failing to get key information is never interesting. (GUMSHOE one-2-one GM guide)

(gumshoe) in a situation where the PCs are in no position to affect the outcome, simply decree that it happens. Don’t bother testing an NPCs ability. To do otherwise is to engage in false branching: you are creating unpredictability for yourself in a way that remains invisible to the players. They don’t get a chance to alter the outcome, and thus gain no benefit from the uncertainty you’ve introduced.

You should always understand the players intention when they get into a situation. Are they starting a fight? What do they hope the outcome to be? You should know. Ask them.



# dice probabilities
how does the math shake out for this system.

transpose results
```
\transpose results\
loop DICE over {1..7} {
 output (DICE d (d6 >= 4) > 0)+0 named "[DICE]d"
 output (DICE d (d6 >= 5) > 0)+2 named "[DICE]d"
 output (DICE d (d6 >= 6) > 0)+4 named "[DICE]d"
}
```
chance of at least mixed success (>= 5)
1d 33.33
2d 55.56
3d 70.37
4d 80.25
5d 86.83
6d 91.22
7d 94.15

chance of full success (= 6)
1d 16.67
2d 30.56
3d 42.13
4d 51.77
5d 59.81
6d 66.51
7d 72.09

expected effort if theres a success is ~1/2 pool size, but always at least 1

# cuts
cuts are taken out of the dice pool after rolling and modifying the roll in order to make the players feel exactly how close they were and what they lost.

# session 0
This is a prepatory gathering where certain decisions need to be made about the tone, setting, and other expectations about the game.

[ttrpg safety toolkit](https://bit.ly/ttrpgsafetytoolkit)
see kult: divinity lost or vampire the masquerade for how to present mature tones
* horror contract

to read: wizards, warriors and wellness: the therapeutic applications of role playing games bodhana group

# railroading
* plot is what the players do
* make situations, don't dictate what will happen during the scene
* never take control of the PCs out of the players hands. You can say that the PCs spend a few days traveling, but if the player wants to stop in the middle of that travel and go somewhere else, the characters can do that.

# the most important rule (OPR)
If the rules as you understand them are ambiguous in a case that comes up during a session, make a ruling and decide how it works. That ruling must be consistently applied for the rest of the session. You can look up the rule actually says later, and correct it for the next session if you want.

## XP, stats and association.
the XP mechanic is [disassociated](https://thealexandrian.net/wordpress/1545/roleplaying-games/dissociated-mechanic), while pips are intended to be associated.

The existance and use of XP isn't something that characters are aware of.
Its purpose is to control the pace and direction of the narrative from the player's perspective, rather than the character's.
Flashbacks themselves are not an action that the character takes. For them, it has always been so.
While a character should be vaguely aware of their growth through gaining skills or stats, the decision to spend XP is distinctly the player's. [Quantum Ogres](https://www.youtube.com/watch?v=yl0z5Z8bvro)

On the other hand, characters are aware of pips as a reserve of strength, resolve, energy, or whatever else.
A character knows that they can exhaust themselves now to push a little harder. When a stat hits zero, the character feels spent.
The decision by a player to spend pips is directly analogous to the characters decision to push themselves.

# GM section
* static target - the GM picks a number of hits, generally 2d6 = 1 hit
* dynamic target - the GM rolls dice to determine the target
setting target numbers
* most things either happen or don't. The target is one hit.
* larger tasks, like killing a tough enemy, may take multiple hits.
* some tasks can only be done all at once. The players must hit the target in a single roll or fail.
* for others progress can be made a little at a time.

advice
* if you don't know what your players are trying to accomplish with an action, find out before adjudicating that action (especially if you think that the action is obviously suicidal).
the descriptions you give of a room are not the same as would be given in a novel. Give general (but necessary) descriptions of a new room first, then describe the horrifying monsters within. This puts what the players will react to at the end, so their gut reaction (fight or flight) can match that of the PCs, rather than giving the players too much time to process by continuing with lesser (but necessary) detail.
[reaction point](https://www.youtube.com/watch?v=ec0L5_Hje_s)
https://ericwbailey.website/published/dungeons-and-dragons-taught-me-how-to-write-alt-text/

# anti-railroading
* only plan one session at a time
* always be ready to abandon facts not yet introduced.


## : GM intrusions
Intrusions offer a third option for controlling the pacing and difficulty.
Rather than deciding that reinforcements come (or that they don't), intrusions let the players decide if they want to take that on.
They can also make up for overly simplistic rules when it would be narratively poignant.

This is a counterpoint to the flashback, and should be about as bad (for the character) as the flashback is good (for the character). The purpose of an intrusion isn't to screw over players, but to inject XP and jazz up the scene with interesting complications. If the players are working hard to avoid them, then no one is jazzed. Only use an intrusion if you’ve got a really awesome (or really horrible) idea.

example intrusions:
* attacks of opportunity - obviously they could get a hit in as you're distracted. Don't use regularly, only if it's really flagrant
* the player drops their weapon. It gets stuck in the beasts tough hide!
* reinforcements come at the worst time.
* make a failure worse, or complicate a success, but don't negate a roll.
* an NPCs sudden but inevitable betrayal.
* that guard you were trying to knock out actually died. He had a family you know.
* you bow to the king and fart. Loudly.

[alexandrian on numenera](https://thealexandrian.net/wordpress/35499/roleplaying-games/numenera-the-art-of-gm-intrusions)
(FATE, cypher/numenera)

## narrative structures, player motivations
* non-local random encounters for things the players care about (stealing the ship)
* heist planning flashbacks (blades)
* dungeoncrawl / hexcrawl / pointcrawl
* downtime
* genre (romance, heist) vs tone vs setting
* dungeon, mystery, raids and heists, urban, into the wilds, racing (TORQ RPG)
* narrative types
    * town -> wilderness -> dungeon. danger, discovery, rewards. similar to a heist structure. typical dnd
    * doomed arc. for one shots. everyone dies at the end, but the horror/glory/sacrifice is worth experiencing
    * power fantasy, power scaling is king
    * slice of life, not really about progression, but exploring the vibes.
    * simpsonian, recurring starting situation and characters, but events don't usually matter or progress
    * biographical, following a character through until their death or retirement
    * grand project, the story revolves around a great discovery/invention/etc, not tied so much to individual characters
* exploration, combat, crafting, roleplay
* risus dirty pleasures
    * beat up goons
    * get that shiny loot
    * customizing loot
    * from foe to friend
    * thrill of the chase
    * weilding immense raw power
    * charming, intimidating, the perfect lie
    * eavesdropping
    * exercising authority
    * unquestionable competence
    * gloating "i told you so"
    * sparkling repartee
    * wonder and discovery, exploration
    * breaking the 4th wall
    * carnage, luxurious destruction
    * horror
    * springing a trap
    * getting caught in a trap
    * a glorious death
    * crafting
    * bragging rights
    * an unexpected windfall
    * reckless behaviour
    * honor, larger purpose
    * revenge
    * completing the quest
    * adulation & gratitude
* pacing
    * mission/downtime loop
    * speed of progression
    * the passage of in-world time
* what fantasies are fulfilled through roleplay?
    * imaginal play - the 'what if' of being a different person
    * exploring a beautiful/horrifying/fun world

# arc design (story beats, session beats)
ICRPG:
1. setup: get a job, decide to go be a hero, hear rumors of some juicy loot
2. get there: get supplies and travel there
3. initial action: start the adventure proper
4. test and escalate: things get more and more intense as difficulties mount and supplies run out
5. the resolution: defeat the baddy, find the treasure, save the princess
6. the return and downtime: enjoy the spoils, return to camp or catch wind of a new adventure

BitD
1. free play: characters gather information and choose a target/plan
2. the score: action & consequences, flashbacks, success or failure
3. downtime: payoff, heat, entanglements, vices

Blades has a very strong mechanical structure to that enforces this structure. Downtime is a series of steps that mostly deal with recovery, advancement, and the shifting web of your crews relationships.
The score has an entirely different structure, more like combat.

In contrast the ICRPG arc is a more general narrative structure, but is not enforced at all by the mechanics.

In addition to this mission structure, both games have a nesting method for larger arcs, ie character progression.
ICRPG leaves it at that, but Blades also includes factions and faction progression. This obviously ties into character growth
but provides additional layers to the narrative (as well as a neat hook to introduce new characters as necessary).
Crucially, Blades provides mechanics to deal with a characters eventual retirement, through stash, and the ghost mechanics.
What happens when the characters get old or tired of adventuring? Can the power scaling continue forever?


# skill progression
The GM ultimately decides on the exact name of skills that players gain but, skills should be directly based on the action that the player is trying to take.

A higher level skill should never totally replace the use of a low level one (ie. the one used when creating the high level skill).
A player with 'cook 2' should not be given 'culinarian 3'. While it's a fancier word, culinarian means almost exactly the same thing, and so could be used in all situations instead of 'cook 2'. 'bake 3' is a better progression. Lots of things are cooked which are not baked, but baked things are all cooked. In a cooking heavy story, 'baking' is also has about the right specificity for a level 3 skill.

General skill represents the potential for growth in that area.
This is because very specific skills are harder to progress and use.
This can be used to shape the overall power potential of a given category of skills.

If a character has 'swordsman 3', this represents the general efficacy of any action taken with any sword. Say the progression is to 'zweihander master 4'. This represents increased familiarity just with that kind of sword. If that character always has their trusty zweihander with them, then they can progress fairly easily by using it in a variety of sword related tasks, while still being limited if they're forced to use another sword.
However, if the progression is to 'stab 4', this indicates that you may also need 'slash 4' and 'sword parry 4' to really up your fighting potential. It also means that if 'stab 4' leads to 'desperate lunge 5', the rest of your swordly skills remain at level 4. This makes it a lot harder to match the power of 

Skills in the same category of the same level should have roughly the same level of specificity.
It doesn't make much sense to have 'zweihander master 4' and 'stab 4'.
It can also create power balance issues between players, if one character is given higher potential than another. While this could lead to good roleplay in a game where players choose the name of their skills, it can feel unfair when the GM makes that choice.

example skills by level:
1. 'do anything' is as general as it gets. It is the only level 1 skill most characters will have and most characters will have it.
2. fight, cook, study
3. swordsman, prepare hearty soup, lawyer
4. zweihander master, the best damn french onion soup you ever had, professor of tree law

A player with "the best damn french onion soup you ever had 4" can only use that skill to make french onion soup.
Other kinds of hearty soups can only use the level 3 skill.

You may prepare a skill tree ahead of time for categories of action you really want to get right.

summary
* child skills represent actions that are a subset of the parent skill.
* child skills should never totally replace the use of the parent skill.
* sibling skills with the same parent should have about the same generality.
* more general skills represent potential for growth in that category
* players that receive the same skill should probably do so at the same skill level

# improv exercises
* accents
practice describing action by narrating action movies (alexandrian) [action scenes](https://old.reddit.com/r/moviecritic/comments/17x1qlw/what_are_some_of_the_most_epic_and_best/)
record self reading boxed text
* giving speeches
* stilted yet realistic conversations (Impro 'Status')
* to improve descriptions of combat, watch great fight films and narrate the action as it happens (matrix, john wick, crouching tiger hidden dragon).
* NPC introductions
* environmental descriptions (action triggers)
    * give that which prompts players into action last, even if its naturally what you would notice first
* camera cuts for split parties, cuts to other concurrent events in the world (if players should know, but the PCs won't), cuts to flashbacks.
* [101 improv tips](https://improvclassesandcoaching.com/ultimate-guide-to-improv-101-improv-tips/)

'yes and' is a fairly common refrain in improv, but there is are extensions

the six results:
1. no and
2. no
3. no but
4. yes but
5. yes
6. yes and

The die system *could* be to map each of these results to all the possible outcomes of the dice, but that's a bit much.
Instead, a success is 'yes' and a mixed success is a 'yes but'.
* 6 - yes
* 5 - yes but
* 4 - no but
* 2/3 - no
* 1 - no and


# initiative, action economy
generally, play moves clockwise around the table, but this is a convention really that just eases bookkeeping for the GM.
What's really more important is that everyone gets an equivalent number actions during a round, and the opportunity to speak during downtime. The turn order doesn't need to be held precisely.
ICRPG has strong clockwise initiative
BitD doesn't

# targets
The ICRPG room target unifies to-hit values, room trap and skill checks. It keeps things simple and fast to use one number. The room target generally represents the difficulty of the current terrain.
Individual targets within the room may be harder or easier, but the room target sets the general tone, and represents that tone to the players.

# timers
* wildsea tracks - ⦻∅○+○○○
    * can progress forward and backward by crossing off circles (∅) and unmarking them
    * burn (⦻) - progress that is especially hard to undo.
    * breaks (○○+○○) - represents important stages along a track
* BitD progress clocks (⦻)
    * can progress forward and backward by filling in pie wedges
    * rising danger, long term projects, minutes to midnight
    * clocks represent the same thing as using a die timer, but are more durable, so suited for long term timers
* icrpg timers
    * have timers out in the open in order to drive suspense. Only sometimes tell the players what it's for.
    * players have the ability to affect the duration of timers. If the room is on fire and will collapse in 4 rounds, a fire extinguisher may buy them a round or two.
    * most timers count a number of rounds, but can also count turns to be especially brutal
    * timers can be used to indicate that an action doesn't need any more rolls to succeed, but will take some time. (to save time on rolling repeatedly) "you will decode the password in 4 rounds"



# reference
GM advice
* [The Alexandrian blog](https://thealexandrian.net/)
    * [advanced gamemastery series](https://www.youtube.com/playlist?list=PLPhDtszOpPZpWuheLzdxp5uVHuvxPkS0t)
* [Seth Skorkowsky](https://www.youtube.com/@SSkorkowsky)
* [the monsters know](https://www.themonstersknow.com/)
    * [basic monster tactics](https://www.themonstersknow.com/why-these-tactics/)

* [stars without number gm section](https://anyflip.com/ubdqk/zkza)
    * excellent tables for npcs (names by cultural heritage), corporations, political factions, religions, architecural styles, and room types, alien monsters.


