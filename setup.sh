#!/bin/sh -x

# This script will install and configure vim as an IDE and word processor/manuscript writer.
# DaVimci bootstrap script

# Should be automated, interactive, portable, narrowly POSIX-compliant, and compatible with both OSX and Arch systems.

# _00xfe9(

# make script find user home and neovim installation location on drive and store as variable
acquire_home() {
USR=$(grep ":1000:" /etc/passwd | awk -F '/' '/1/ { print $3 }' | sed 's/://g' | head -1)
DIR=/home/$USR/.config
}

# Script requires sudo
su_req() {
[ "$(whoami)" != "root" ] && exec sudo "$PWD"/setup.sh "$0" "$*"
}

invrep() {
	echo "Invalid entry." ; sleep 2.0
}

# Menu for neovim
# This menu is buggy
menu() {
echo "Start neovim?"
read -r REPLY
[ "$REPLY" = "y" ] && echo "You chose \"$REPLY\"" ; sleep 1.5 ; nvim & exit 0
[ "$REPLY" = "n" ] && echo "You chose \"$REPLY\"" ; sleep 1.5 ; exit 0
[ ! "$REPLY" = "y" ] && [ ! "$REPLY" = "n" ] && invrep ; menu
}

# ask what development tools you want. Are you programming in shellscript? Java? C++?
# for citation management, I recommend zotero or mendeley
# do you want to install java jdk, runtime, gradle...?
programs() {
	[ ! "$(command -v git)" ] && apt install -y git
	[ ! "$(command -v curl)" ] && apt install -y curl
	[ ! "$(command -v pandoc)" ] && apt install -y pandoc
	[ ! "$(command -v nvim)" ] && apt install -y neovim
	[ ! "$(command -v shellcheck)" ] && apt install -y shellcheck
	[ ! "$(command -v cmake)" ] && apt install -y cmake
	[ ! "$(command -v ctags)" ] && apt install -y ctags
	[ ! "$(command -v python3.8)" ] && apt install -y python3.8
	[ ! "$(command -v npm)" ] && apt install -y npm
}

# Test if folders in section 2 exist
git_clone() {
	[ -e "$DIR"/nvim/vim-devicons ] && git clone https://github.com/ryanoasis/vim-devicons "$DIR"/nvim/vim-devicons
	[ -e "$DIR"/nvim/vista ] && git clone https://github.com/liuchengxu/vista.vim.git "$DIR"/nvim/vista
	[ -e "$DIR"/nvim/vim-polyglot ] && git clone https://github.com/sheerun/vim-polyglot.git "$DIR"/nvim/vim-polyglot
	[ -e "$DIR"/nvim/vim-plug ] && git clone https://github.com/junegunn/vim-plug.git "$DIR"/nvim/vim-plug
	[ -e "$DIR"/nvim/vim-airline ] && git clone https://github.com/vim-airline/vim-airline.git "$DIR"/nvim/vim-airline
	[ -e "$DIR"/nvim/vim-snippets ] && git clone https://github.com/honza/vim-snippets.git "$DIR"/nvim/vim-snippets
	[ -e "$DIR"/nvim/vim-YouCompleteMe ] && git clone https://github.com/ycm-core/YouCompleteMe.git "$DIR"/nvim/YouCompleteMe
	[ -e "$DIR"/nvim/syntastic ] && git clone https://github.com/vim-syntastic/syntastic.git "$DIR"/nvim/syntastic
	[ -e "$DIR"/nvim/vim-fugitive ] && git clone https://github.com/tpope/vim-fugitive.git "$DIR"/nvim/vim-fugitive
	[ -e "$DIR"/nvim/vim-airline-themes ] && git clone https://github.com/vim-airline/vim-airline-themes.git "$DIR"/nvim/vim-airline-themes
	[ -e "$DIR"/nvim/goyo.vim ] && git clone https://github.com/junegunn/goyo.vim.git "$DIR"/nvim/goyo.vim
	[ -e "$DIR"/nvim/vimspector ] && git clone https://github.com/puremourning/vimspector.git "$DIR"/nvim/vimspector
	[ -e "$DIR"/nvim/ale ] && git clone https://github.com/dense-analysis/ale.git "$DIR"/nvim/ale
	[ -e "$DIR"/nvim/nerdtree ] && git clone https://github.com/preservim/nerdtree.git "$DIR"/nvim/nerdtree
	[ -e "$DIR"/nvim/gruvbox ] && git clone https://github.com/morhetz/gruvbox.git "$DIR"/nvim/gruvbox
	[ -e "$DIR"/nvim/coc-snippets ] && git clone https://github.com/neoclide/coc-snippets.git "$DIR"/nvim/coc-snippets
	[ -e "$DIR"/nvim/limelight ] && git clone https://github.com/junegunn/limelight.vim.git "$DIR"/nvim/limelight
	[ -e "$DIR"/nvim/fzf ] && git clone https://github.com/junegunn/fzf.git "$DIR"/nvim/fzf
	[ -e "$DIR"/nvim/fzf.vim ] && git clone https://github.com/junegunn/fzf.vim.git "$DIR"/nvim/fzf.vim
	[ -e "$DIR"/nvim/tagbar ] && git clone https://github.com/majutsushi/tagbar.git "$DIR"/nvim/tagbar
	[ -e "$DIR"/nvim/vim-pythonsense ] && git clone https://github.com/jeetsukumaran/vim-pythonsense.git "$DIR"/nvim/vim-pythonsense
	[ -e "$DIR"/nvim/auto-pairs ] && git clone https://github.com/jiangmiao/auto-pairs.git "$DIR"/nvim/auto-pairs
	[ -e "$DIR"/nvim/coc.vim ] && git clone https://github.com/neoclide/coc.nvim.git "$DIR"/nvim/coc.vim
	[ -e "$DIR"/nvim/coc-java ] && git clone https://github.com/neoclide/coc-java.git "$DIR"/nvim/coc-java
	[ -e "$DIR"/nvim/coc-python ] && git clone https://github.com/neoclide/coc-python.git "$DIR"/nvim/coc-python
	[ -e "$DIR"/nvim/neomake ] && git clone https://github.com/neomake/neomake.git "$DIR"/nvim/neomake
}

copy() {
	cp "$DIR"/nvim/vim-plug/plug.vim "$DIR"/nvim/autoload/plug.vim
	cp "$DIR"/nvim/vim-airline/plugin/airline.vim "$DIR"/nvim/autoload/vim-airline.vim
	cp "$DIR"/nvim/vim-snippets/plugin/vimsnippets.vim "$DIR"/nvim/autoload/vimsnippets.vim
  	cp "$DIR"/nvim/YouCompleteMe/autoload/youcompleteme.vim "$DIR"/nvim/autoload/youcompleteme.vim
	cp "$DIR"/nvim/syntastic/plugin/syntastic.vim "$DIR"/nvim/autoload/syntastic.vim
	cp "$DIR"/nvim/vim-fugitive/plugin/fugitive.vim "$DIR"/nvim/autoload/fugitive.vim
	cp "$DIR"/nvim/vim-airline-themes/plugin/airline-themes.vim "$DIR"/nvim/autoload/airline-themes.vim
	cp "$DIR"/nvim/goyo.vim/plugin/goyo.vim "$DIR"/nvim/autoload/goyo.vim
	cp "$DIR"/nvim/vimspector/plugin/vimspector.vim "$DIR"/nvim/autoload/vimspector.vim
	cp "$DIR"/nvim/ale/autoload/ale.vim "$DIR"/nvim/autoload/ale.vim
	cp "$DIR"/nvim/nerdtree/plugin/NERD_tree.vim "$DIR"/nvim/autoload/NERD_tree.vim # does not copy
	cp "$DIR"/nvim/vim-devicons/plugin/webdevicons.vim "$DIR"/nvim/autoload/webdevicons.vim # does not copy
	cp "$DIR"/nvim/gruvbox/autoload/airline/themes/gruvbox.vim "$DIR"/nvim/autoload/gruvbox.vim
	cp "$DIR"/nvim/coc-snippets/ftplugin/snippets.vim "$DIR"/nvim/autoload/snippets.vim
	cp "$DIR"/nvim/limelight.vim/plugin/limelight.vim "$DIR"/nvim/autoload/limelight.vim
	cp "$DIR"/nvim/vim-polyglot/plugin/sleuth.vim "$DIR"/nvim/autoload/sleuth.vim
	cp "$DIR"/nvim/vista.vim/plugin/vista.vim "$DIR"/nvim/autoload/vista.vim
	cp "$DIR"/nvim/fzf/plugin/fzf.vim "$DIR"/nvim/autoload/fzf.vim
	cp "$DIR"/nvim/fzf.vim/autoload/fzf/vim.vim "$DIR"/nvim/autoload/vim.vim
	cp "$DIR"/nvim/tagbar/autoload/tagbar.vim "$DIR"/nvim/autoload/tagbar.vim
	cp "$DIR"/nvim/vim-pythonsense/after/ftplugin/python/pythonsense.vim "$DIR"/nvim/autoload/vim-pythonsense/after/ftplugin/python/pythonsense.vim
	cp "$DIR"/nvim/vim-pythonsense/autoload/pythonsense.vim "$DIR"/nvim/autoload/pythonsense.vim
	cp "$DIR"/nvim/auto-pairs/plugin/auto-pairs.vim "$DIR"/nvim/autoload/auto-pairs.vim
	cp "$DIR"/nvim/coc.nvim/autoload/coc.vim "$DIR"/nvim/autoload/coc.vim
	cp "$DIR"/nvim/neomake/autoload/neomake.vim "$DIR"/nvim/autoload/neomake.vim
}

# The configuration stage should utilize while loops, if and case statements, subshells, and implicit statements for security
conf() {

	# Setting up YCM
	git submodule update --init --recursive
	# Must detect latest python version and use it over all others
	[ -e "$DIR"/nvim/YouCompleteMe ] && python3.8 "$DIR"/nvim/YouCompleteMe/install.py --all # This doesn't seem to work when executed in script

	# Installing fzf
	[ -e "$DIR"/nvim/fzf ] && "$DIR"/nvim/fzf/install

	# Setup NERD fonts
	[ ! -e /home/"$USR"/.local/share/fonts ] && mkdir "$HOME"/.local/share/fonts
	[ "$(stat /home/"$USR"/.config/nvim/fonts)" != "0" ] && mkdir "$DIR"/nvim/fonts
	# copy fonts to .local/share/fonts and extract in font root folder

	# curl is a non-POSIX utility and does NOT come pre-installed on some distributions
	curl -LO https://github.com/belluzj/fantasque-sans/releases/download/v1.8.0/FantasqueSansMono-LargeLineHeight-NoLoopK.tar.gz -o "$DIR"/nvim/fonts
	curl -LO https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraMono/Regular/complete/Fira%20Mono%20Regular%20Nerd%20Font%20Complete.otf -o "$DIR"/nvim/fonts # does not download anything to fonts folder
#	cp "$DIR"/nvim/fonts/*.otf /home/"$USR"/
	cp "$DIR"/nvim/fonts/*.gz /home/"$USR"/.local/share/fonts/FantasqueSansMono-LargeLineHeight-NoLoopK.tar.gz && tar -xf "$(find . -name "*.gz")" | head -35 # Tar is a non-POSIX utility
	# Copy fonts to .local/share/fonts if previous command successful

	# Setup kite for all available editors
	if [ -e "$DIR"/nvim/pack/kite ] ; then
		echo "Kite is already installed, skipping."
	elif [ ! -e "$DIR"/nvim/pack/kite ] ; then
		exec bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)" "$0" "$*" # This downloads kite
		# program may quit here
		# execute with -u $USR
	fi
}

# Download and copy plugins and necessary programs
acquire_home
su_req
programs # Find a way to test if these commands succeed before continuing the script
git_clone
[ -e "$DIR"/nvim/autoload ] && copy
[ ! -e "$DIR"/nvim/autoload ] && mkdir "$DIR"/nvim/autoload/ && copy
conf
sudo chown "$USR" -R "$DIR"/nvim # this is not working for some reason
# Changed from $USER to $USR
menu

# Unzip writing files
# Setting file permissions
chmod +x build.sh publish.sh compile.sh
chmod 775 -R *
# chown -R $USR *
# Create a .desktop launcher for Neo DaVimci IDE & Writer

exit 0

# ALE not working at all

# ycm install.py
# simply clone ale folder into "pack" directy to install
# YCM library core bug:		:YcmRestartServer

# mkdir ycm_build
# build ycm from plugged folder in autoload
# cmake -G "Unix Makefiles" . /home/mstkj/.config/nvim/YouCompleteMe/third_party/ycmd/cpp
# cmake --build . --target ycm_core --config Release
#fonts do not load correctly after installation
# dev icons do not load correctly after install

# coc.vim :PlugInstall result coc.vim install.sh not found

# setting up GitHub CLI
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh
echo "You must run \`gh auth login\`"
