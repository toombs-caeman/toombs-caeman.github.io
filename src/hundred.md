[The Hundred-Year Language (pg)](https://www.paulgraham.com/hundred.html)
[The Hundred-Year Programming Language (codefol)](https://codefol.io/posts/the-hundred-year-programming-language/)
Some terms to get started
* lHCI - logic-system based human-computer interface, wherin a user describes what they want to happen logically. a 'hard' interface. basically any programming language
* iHCI - intent-based human-computer interface, wherein a user selects among options the computer offers, or describes what they want to accomplish in a way that doesn't have to be logically consistent, AI based programming tools, GUIs

Premise 1: In 100 years, computers will be incredibly powerful when compared to the computers of today.
Premise 2: Computers will still be 'programmed' through some form of formal-logic system which communicates human intent to the computer.

Counter-Premise 2: Current trends in AI suggest that the interface between human and computer may not necessarily be a formal-logic system. These interfaces in effect democratize the creation of programs (a strictly more powerful HCI than simple computer use) by side-stepping the need for the user to understand the lHCI.

Counter-Counter-Premise 2: while iHCI exists now, and will get more powerful over time, it will not fully replace lHCI for technical.

History 1: The computers of today are incredibly powerful compared to the computers of ~50 years ago. This has resulted in a shift in focus in language design from 'low level' to 'high level' languages which trade pure performance for expressivity and ease of use. The developer's time is generally considered more important than the computer's time now, and that trend is likely to continue.


Present: Much of language research is currently centered around 'tightening' the constraints of the lHCI by, for example, introducing type systems, and rust's memory safety focus, such that these systems can guarantee that expressions within the logical system are actually computable.

within lHCI
* expressions within the system must be actually computable.
* a given expression within the system has exactly one computable interpretation


Conclusion 1: Programming languages

