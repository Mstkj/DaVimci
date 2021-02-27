
DaVimci Projektet

Use LaTeX for academic documents and HTML for non-academic documents
Use as IDE for programming both small and large projects
or for writing emails, books, legal documents, academic/scientific papers, etc

There are instructions for my Makefile.

# Instructions

# Copyright

One line to give the program's name and a brief description
Copyright © 2020, Jorin Ryms

Permission to use, copy, modify, and/or distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

# Vim as full stack IDE and word processor/manuscript writer

## As a word processor/manuscript writer

The biggest Vim features you should have at your disposal are: (1) multi-lingual autocompletion, (2) spellcheck, (3) offline thesaurus, (4) multi-lingual dictionaries (5) minimal formatting, (6) full customization, (7) document conversion, (8) built-in terminal, (9) virtual tutor, (10) debugger, (11) compiler, (12) Git wrapper, (13) syntax highlighting, (14) &amp; sidebar file navigation

You should be able to use Vim as a full-stack development environment for Python, Java, C/C++, Shellscript, or Go.
Vim has a few modes with which you will become familiar as you use it:

+ NORMAL — `Esc`
+ INSERT — `Ins` or `i`
+ REPLACE — `Ins` while in INSERT
+ VISUAL — `v` while in NORMAL
+ VISUAL BLOCK — `Ctrl+v` while in NORMAL or VISUAL
+ VISUAL LINE — `Shift-v` in NORMAL or VISUAL
+ SELECT — ` `
+ TERMINAL — `:term` command in NORMAL

# Configuring Vim

+ Since the installation script is mostly automated, it should do most of the heavy lifting for you.
+ This setup will give Vim similar functionality to Writeroom
+ Convert/Compile with `pandoc book.md -o book.docx/pdf`
+ I also use `sv_se` and `sv` for when I am writing in Swedish.
+ When it comes to using Vim as an IDE, you will likely have to do at least some manual configuration in terms of problem solving.
+ You can rename files by adding another extension to get the desired syntax and autocompletion engine

There are a couple of extremely important steps to go over before you can start using your new IDE:

1. Open a terminal via `Ctrl+Alt+T`, navigate to the current directory and execute `make install`.
2. Enjoy

## Wrapping up

This setup works for both programming and prose
Exit insert mode and save with `:w` or in NORMAL mode, `ZQ` to save and exit
`:Goyo` to activate distraction-free writing mode
`:term` for terminal in Vim
sudo apt install texlive-xetex
install plugins for vim
run shell commands from vim terminal with `:term` from NORMAL mode.
Run `:make` in NORMAL mode to compile your program. Make is integrated directly into Vim, which is greatly useful.
Follow this with `:term` to launch a terminal to the correct directory from within Vim
Start with `nvim file.format`
You can use `]s` to skip to the next misspelled word and `[s` for the previous. Alternatively, you can use `]S` and `[S` respectively to skip minor errors such as regional spelling. To add a word to your dictionary, press `zg` in NORMAL mode. To remove a word from the dictionary, type `zug`. To change the language, simply type `:set spelllang=sv_se`, for example. The letters before are the language code and the letters after the underscore are the region code.
+ The following actually goes in the shellscript.
+ You will need LaTex `texlive-xetex`
+ Run command `nvim file.md` - markdown works better than plaintext for this.
+ In normal mode, find replacements with `z=` in NORMAL mode.
+ Autocomplete words with the `complete` option `:set complete+=s`
+ As you type in INSERT mode, use `Ctrl+n` to search for possible words based on * your spelling
+ you can add custom words to your dictionary by typing `:setlocal spell spelllang=en_us` to localize your spellcheck and `:set spell!` to turn on spellcheck without localizing it.

## packages are as follows

`sudo apt install vim neovim pandoc texlive-xetex`
Here is a script I've written for Debian-based distros that will automatically install everything you need.

## How to use your plugins

`:NERDTree` opens your IDE project window equivalent
`:packadd termdebug` enables your debugger and `:Termdebug` runs gdb in your terminal
`:term` launches a terminal in the current directory from vim
`:set spell!` turns on spellcheck.
`SyntasticCheck` turns on code syntax checking
`Ctrl+v` in NORMAL mode switches to Visual Block mode
In NORMAL mode, you can press `Tab` after `:` to toggle the command autocomplete menu.
Press `Ins` while in INSERT mode to switch to REPLACE mode and vice versa
`:syntax on`
`:set autoindent`
`:set smartindent`
`:set cindent`
`:shell` executes commands as shell
`set ruler`
`:hi clear SignColumn`
`:Tutor`
`:debug`
`:Tags`
`zc` enables code folding
`:Limelight` to turn on distraction-free writing & `:Limelight!` to deactivate
Install coc after running `:PlugInstall` with `:CocInstall`
Then, you can install extensions with `:CocInstall coc-snippets coc-python coc-java coc-vimlsp coc-clangd coc-html coc-css coc-sh coc-pairs coc-git`
`gd` goto definition when cursor over text
`zc` in VISUAL mode folds the code to hide distracting lines and `zo` to open
In NORMAL mode, `Shift+Q` enters Vim into Ex mode
vim-lexical
`Shift+[` and `Shift+]` navigate up and down the document by block
`Shift+K` opens the definition of anything highlighted by the cursor
For anything undocumented by your virtual tutor, you can type `:help` followed by the name of any vim plugin or function.
To enable the compose key for UNIX systems, enter `sudo dpkg-reconfigure keyboard-configuration` and `KBDOPTIONS=Compose:ralt` in `/etc/default/keyboard` to enable typing in multiple languages
Type `:PlugInstall` to install your plugins
change your keyboard autorepeat rate with `sudo kbdrate`
type `:new` for a new window. `:vsp` has a similar function.
For fzf (fuzzy finder), type leader f, usually `\f`

Split window with `Ctrl+w` and `v`
To switch between windows, run `Ctrl+w` followed by `h`, `j`, `k`, or `l`

Describe shortcuts from my vimrc (init.vim)
for coding in Java with Vim as an IDE, you will need to install Java jdk via `sudo apt install openjdk-14-jdk` as well as the runtime environment with `sudo apt install openjdk-14-jre`.

pressing `\` followed by `f` runs `:FZF` in Vim.
	# :PlugInstall

You can create references.bib with Zotero
All of your files must be in the working directory
Edit all of your files to make sure the publication suits your needs
learn to add custom templates to pandoc

If using wkhtmltopdf, pandoc will rasterize PDFs if using TTF.
When using HTML5 markdown, use HTML5 tags such as `<title>$title$</title>` if using pandoc template. Write manually if without template.

</template>
