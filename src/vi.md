---
title: vi
---
# Learning Vim

# What is Vim
A venerable editor with a long history and a few different versions.

[ex](https://en.wikipedia.org/wiki/Ex_(text_editor)) ->
[vi](https://en.wikipedia.org/wiki/Vi_(text_editor)) ->
[vim](https://www.vim.org/) ->
[neovim](https://neovim.io/)

# Why learn (Neo)Vim?
* If you spend a lot of time writing / editing text
* If you want to use the mouse less.
* If you program:
    * It is a powerful editor that can replicate all the features of a 'modern' IDE while being totally free, infinitely more configurable.
    * It is (strictly, objectively) better than nano, and is almost always already available in any situation where one would use nano, such as in a restricted environment.
* you can learn the basics of vim while using another editor by using a plugin (in vscode or intellij)
    * https://www.youtube.com/watch?v=X6AR2RMB5tE

## When not to learn vim
* You rarely need to edit text. Vim does have a bit of a learning curve, and it takes consistent practice in the beginning to "get it".
* Sublime text is everything you want from your editor.
* you don't have time to learn about and configure your tools.


# Learning Vim
0. install neovim
    * `winget install Neovim`
    * `apt install neovim`
    * optionally install a [gui](https://neovim.io/doc/user/gui.html#third-party-guis)

1. In a terminal, run `nvim +Tutor`, then complete the tutorial.

2. Take a coffee break. You've earned it!
    * You can stop here if you want. It's good to understand the defaults configuration and it's definitely usable but half the power of nvim is the ability to add plugins and your own configuration.

3. Kickstart your own configuration with [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
    * follow the installation instructions in the README

4. Read kickstart's init.lua
    * Go read the init.lua that kickstart installed. Having the best config in the world won't help you if you don't understand what it can do.
    * Neovim (but not vim) is configured using the [Lua Programming Language](https://www.lua.org/).
        * If you have prior programming experience, but are unfamiliar with lua, check out [learnXinY:lua](https://learnxinyminutes.com/lua/)

# Finding Plugins
After you've settled into using vim for a while, you may be looking for additional plugins. Here's a short list of where to find the goodies.

* nvim distributions package many plugins together. You may want to fully adopt one that aligns with what you want, or you can just explore what plugins they package, and copy the parts you like.
    * [lazyvim](http://www.lazyvim.org/)
    * [nvchad](https://nvchad.com/)
    * [lunarvim](https://www.lunarvim.org/)
    * [mini](https://github.com/echasnovski/mini.nvim) doesn't market itself as a distribution, but it pretty much is.
* [vim plugin shortlist](https://github.com/akrawchyk/awesome-vim)
* With a history of quality plugins: [tpope](https://github.com/tpope?tab=repositories)
* Creator of the package manager lazy.nvim [folke](https://github.com/folke?tab=repositories)
* Explore the [mini library](https://github.com/echasnovski/mini.nvim/tree/main/readmes)
* You can copy [other peoples dotfiles](https://github.com/search?q=vim%20dotfiles&type=repositories)
    * you can copy [mine](https://github.com/toombs-caeman/dotfiles) too

# advanced topics
* marks
* macros
* vim.ui.select

# Wrapping Up
What's more to be said? Nvim rocks
