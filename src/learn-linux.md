This is more about teaching than learning.

# learning X
Say a non-technical friend / family member comes to you and says 'I want to learn X'.
Presumably they came to you because you're something of an [expert](https://www.youtube.com/watch?v=BKorP55Aqvg)

Usually the first step is to figure out the motivation. Are they looking for deep knowledge or is the learning 
instrumental to some other goal?
Is what they're asking for actually what you, as someone with domain knowledge, hear them asking for?
I've found this takes some conversation.

There's usually a tutorial you can point them to if their goals are specific enough.
Tutorial spam can be brutal though, especially when you're learning yourself, and don't quite know what words to search.
It's really hard to bootstrap learning so that you can find high quality information on the subject by yourself.
Asking good questions is hard.

I think there's a need for 'introductory' 'tutorials' that point out how and where to find quality information within
a field, for those outside the field that don't have the vocabulary to get started.
In a sense, this is akin to a course outline or syllabus, but broader and shallower. You don't need to spend a semester
studying marine biology if your real goal is infotainment, but the key search terms and sources might be the same in both cases.
Leaf Sheep are weird and wonderful, but I digress.

Maybe I've just missed it, but I'll take a crack at it myself for something I'm a little familiar with.

# Where X = Linux

First off, there's a few things you could mean by 'learning linux':
* comparatively, in its contrast to windows, usually just as a curiosity / superficial interest
* how to use 'the linux operating system' casually as a user.
* how to use a specific application (which happens to run on linux).
* how to use it as a power-user, usually as a transition from heavy windows use, but also from casual linux use.
* about the internal design of linux as an operating system
* about the history of unix
* how to 'program', either for a specific task or generally.

## Where X = using Linux as a user
I usually point people to download [ubuntu](https://ubuntu.com/download/desktop)
Their tutorial is pretty good for [trying before you install](https://ubuntu.com/tutorials/try-ubuntu-before-you-install).
It's also helpful to walk them through the first few minutes by putting them through the paces:
* connect to the internet
* launch the browser (show them [stackoverflow](https://stackoverflow.com/) maybe)
* install an app
* list installed apps
* launch an app
* remove an app
* update the system (or enable/trigger automatic updates, the point is to trigger a password request, so they know what it looks like)
* customize the desktop
* lock/unlock the screen
* reboot/logout

## Where X = using Linux as a poweruser
The shortest answer in this case is `man man`, but that's not really useful.
Even this requires a little background knowledge
* how to get a live linux environment (download ubuntu, flash usb and boot)
* how to open a terminal (ctrl-alt-enter sometimes, or go through app launcher)
* how to control the pager (arrow keys or d and u, q to quit, h for help)
* how to find the name of commands you might be interested in (`ls ${PATH//:/ }`, `bash -c help`)
* how to investigate commands which don't have man pages (-h --help -help -?)

The answer to most of these questions (if your learner knows to ask them) could easily be to google it, but we can do better.
There's too much tutorial spam.

# ref
* [programming languages](https://learnxinyminutes.com/)
* [how to help someone use a computer](https://pages.gseis.ucla.edu/faculty/agre/how-to-help.html)
