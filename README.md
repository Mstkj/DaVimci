
2021-03-17 14:25

Jorin's (a.k.a., Mstkj &amp; Melthsked) DaVimci or Vim (Neovim) Riced bootstrapping program/script
Use LaTeX for academic documents and HTML for non-academic documents
Use as IDE for programming both small and large projects
or for writing emails, books, legal documents, academic/scientific papers, etc

Copyright © 2021 Jorin Ryms (Mstkj). All Rights Reserved.

There are instructions for my Makefile.

# Vim as full stack IDE and word processor/manuscript writer

## As a word processor/manuscript writer

The biggest Vim features you should have at your disposal are: (1) multi-lingual autocompletion, (2) spellcheck, (3) offline thesaurus, (4) multi-lingual dictionaries (5) formatting, (6) full customization, (7) document conversion, (8) built-in terminal, (9) virtual tutor, (10) debugger, (11) compiler, (12) Git wrapper, (13) syntax highlighting, (14) &amp; sidebar file navigation

# Configuring Vim

+ This setup will give Vim similar functionality to Writeroom
+ I also use `sv_se` and `sv` for when I am writing in Swedish.
+ You can rename files by adding another extension to get the desired syntax and autocompletion engine
There are a couple of extremely important steps to go over before you can start using your new IDE:
run shell commands from vim terminal with `:term` from NORMAL mode.
Run `:make` in NORMAL mode to compile your program. Make is integrated directly into Vim, which is greatly useful.
Follow this with `:term` to launch a terminal to the correct directory from within Vim
Start with `nvim file.format`
To change the language, simply type `:set spelllang=sv_se`, for example. The letters before are the language code and the letters after the underscore are the region code.
+ Autocomplete words with the `complete` option `:set complete+=s`
+ you can add custom words to your dictionary by typing `:setlocal spell spelllang=en_us` to localize your spellcheck and `:set spell!` to turn on spellcheck without localizing it.
`SyntasticCheck` turns on code syntax checking
`Ctrl+v` in NORMAL mode switches to Visual Block mode
`:set autoindent`
`:set cindent`
`:shell` executes commands as shell
`:hi clear SignColumn`
`zc` enables code folding
Install coc after running `:PlugInstall` with `:CocInstall`
Then, you can install extensions with `:CocInstall coc-snippets coc-python coc-java coc-vimlsp coc-clangd coc-html coc-css coc-sh coc-pairs coc-git`
`gd` goto definition when cursor over text
`zc` in VISUAL mode folds the code to hide distracting lines and `zo` to open
In NORMAL mode, `Shift+Q` enters Vim into Ex mode
vim-lexical
`Shift+K` opens the definition of anything highlighted by the cursor
For anything undocumented by your virtual tutor, you can type `:help` followed by the name of any vim plugin or function.
For errors, you can do, for example, `:h E319`
To enable the compose key for UNIX systems, enter `sudo dpkg-reconfigure keyboard-configuration` and `KBDOPTIONS=Compose:ralt` in `/etc/default/keyboard` to enable typing in multiple languages
Type `:PlugInstall` to install your plugins
change your keyboard autorepeat rate with `sudo kbdrate`
type `:new` for a new window. `:vsp` has a similar function.
Split window with `Ctrl+w` and `v`
To switch between windows, run `Ctrl+w` followed by `h`, `j`, `k`, or `l`
Edit all of your files to make sure the publication suits your needs
learn to add custom templates to pandoc
