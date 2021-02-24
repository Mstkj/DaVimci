#!/bin/bash

# This script will install and configure vim as an IDE and word processor/manuscript writer.
# DaVimci bootstrapping script
# Should be automated, portable (Debian, OSX, Arch) and narrowly POSIX-compliant.
# Make script find user home and neovim installation location on drive and store as variable

function Main() {
	AcquireHome
	RequestSuperuser
	InstallDependencies
	GitClone
	[ -e "$DIR"/nvim/autoload ] && copy
	[ ! -e "$DIR"/nvim/autoload ] && mkdir "$DIR"/nvim/autoload/ && copy
	Configure
	sudo chown "$USR" -R "$DIR"/nvim # this is not working for some reason
	#Menu
	# uname -a to test for distributions
	# echo $0 to test for shell
	# use find command
}

function AcquireHome() {
USR=$(grep ":1000:" /etc/passwd | awk -F '/' '/1/ { print $3 }' | sed 's/://g' | head -1)
DIR=/home/$USR/.config
}

function RequestSuperuser() { # Script requires sudo
#[ "$(whoami)" != "root" ] && exec sudo "$PWD"/setup.sh "$0" "$*"
[[ ! "$(whoami)" = "root" ]] && exec sudo ./setup.sh "$0"
}

function InvalidResponse() {
	printf "\nInvalid response.\n"; sleep 2.0
}

#function Menu() {
#PS3="Start Neovim [Y/N] "
#options=(Yes No)
#select menu in "${options[@]}"
#do
#	if [[ "$REPLY" = "1" ]]; then
#		true
#	elif [[ "$REPLY" = "2" ]]; then
#		true
#	else
#		InvalidResponse; Menu
#	fi
#done
#}

function InstallDependencies() {
	tools=(
		"git"
		"curl"
		"pandoc"
		"nvim"
		"shellcheck"
		"cmake"
		"clang"
		"clangd"
		"ctags"
		"python3.8"
		"npm"
		"js"
	)
	declare -A packages=(
		[${tools[0]}]="git"
		[${tools[1]}]="curl"
		[${tools[2]}]="pandoc"
		[${tools[3]}]="neovim"
		[${tools[4]}]="shellcheck"
		[${tools[5]}]="cmake"
		[${tools[6]}]="clang"
		[${tools[7]}]="clangd"
		[${tools[8]}]="universal-ctags"
		[${tools[9]}]="python3.8"
		[${tools[10]}]="npm"
		[${tools[11]}]="nodejs"
	)
	for i in "${tools[@]}"; do
		[[ ! "$(command -v "${i}" 2> /dev/null)" ]] && sudo apt install "${packages[${i}]}" -y # Could use "hash" command.
	done
}

function GitClone() { # Test if folders in section 2 exist
	# TODO: Will have to use an array for git links and for directories. Use for loop for testing and installing <23-02-21, melthsked> #
	[ -e "$DIR"/nvim/vim-devicons ] || sudo git clone https://github.com/ryanoasis/vim-devicons "$DIR"/nvim/vim-devicons
	[ -e "$DIR"/nvim/vista ] || sudo git clone https://github.com/liuchengxu/vista.vim.git "$DIR"/nvim/vista
	[ -e "$DIR"/nvim/vim-polyglot ] || sudo git clone https://github.com/sheerun/vim-polyglot.git "$DIR"/nvim/vim-polyglot
	[ -e "$DIR"/nvim/vim-plug ] || sudo git clone https://github.com/junegunn/vim-plug.git "$DIR"/nvim/vim-plug
	[ -e "$DIR"/nvim/vim-airline ] || sudo git clone https://github.com/vim-airline/vim-airline.git "$DIR"/nvim/vim-airline
	[ -e "$DIR"/nvim/vim-snippets ] || sudo git clone https://github.com/honza/vim-snippets.git "$DIR"/nvim/vim-snippets
	[ -e "$DIR"/nvim/vim-YouCompleteMe ] || sudo git clone https://github.com/ycm-core/YouCompleteMe.git "$DIR"/nvim/YouCompleteMe
	[ -e "$DIR"/nvim/syntastic ] || sudo git clone https://github.com/vim-syntastic/syntastic.git "$DIR"/nvim/syntastic
	[ -e "$DIR"/nvim/vim-fugitive ] || sudo git clone https://github.com/tpope/vim-fugitive.git "$DIR"/nvim/vim-fugitive
	[ -e "$DIR"/nvim/vim-airline-themes ] || sudo git clone https://github.com/vim-airline/vim-airline-themes.git "$DIR"/nvim/vim-airline-themes
	[ -e "$DIR"/nvim/goyo.vim ] || sudo git clone https://github.com/junegunn/goyo.vim.git "$DIR"/nvim/goyo.vim
	[ -e "$DIR"/nvim/vimspector ] || sudo git clone https://github.com/puremourning/vimspector.git "$DIR"/nvim/vimspector
	[ -e "$DIR"/nvim/ale ] || sudo git clone https://github.com/dense-analysis/ale.git "$DIR"/nvim/ale
	[ -e "$DIR"/nvim/nerdtree ] || sudo git clone https://github.com/preservim/nerdtree.git "$DIR"/nvim/nerdtree
	[ -e "$DIR"/nvim/gruvbox ] || sudo git clone https://github.com/morhetz/gruvbox.git "$DIR"/nvim/gruvbox
	[ -e "$DIR"/nvim/coc-snippets ] || sudo git clone https://github.com/neoclide/coc-snippets.git "$DIR"/nvim/coc-snippets
	[ -e "$DIR"/nvim/limelight ] || sudo git clone https://github.com/junegunn/limelight.vim.git "$DIR"/nvim/limelight
	[ -e "$DIR"/nvim/fzf ] || sudo git clone https://github.com/junegunn/fzf.git "$DIR"/nvim/fzf
	[ -e "$DIR"/nvim/fzf.vim ] || sudo git clone https://github.com/junegunn/fzf.vim.git "$DIR"/nvim/fzf.vim
	[ -e "$DIR"/nvim/tagbar ] || sudo git clone https://github.com/majutsushi/tagbar.git "$DIR"/nvim/tagbar
	[ -e "$DIR"/nvim/vim-pythonsense ] || sudo git clone https://github.com/jeetsukumaran/vim-pythonsense.git "$DIR"/nvim/vim-pythonsense
	[ -e "$DIR"/nvim/auto-pairs ] || sudo git clone https://github.com/jiangmiao/auto-pairs.git "$DIR"/nvim/auto-pairs
	[ -e "$DIR"/nvim/coc.vim ] || sudo git clone https://github.com/neoclide/coc.nvim.git "$DIR"/nvim/coc.vim
	[ -e "$DIR"/nvim/coc-java ] || sudo git clone https://github.com/neoclide/coc-java.git "$DIR"/nvim/coc-java
	[ -e "$DIR"/nvim/coc-python ] || sudo git clone https://github.com/neoclide/coc-python.git "$DIR"/nvim/coc-python
	[ -e "$DIR"/nvim/neomake ] || sudo git clone https://github.com/neomake/neomake.git "$DIR"/nvim/neomake
}

function copy() {
	cp "$DIR"/nvim/vim-plug/plug.vim "$DIR"/nvim/autoload/plug.vim
	cp "$DIR"/nvim/vim-airline/plugin/airline.vim "$DIR"/nvim/autoload/vim-airline.vim
	cp "$DIR"/nvim/vim-snippets/plugin/vimsnippets.vim "$DIR"/nvim/autoload/vimsnippets.vim
 	cp "$DIR"/nvim/YouCompleteMe/autoload/youcompleteme.vim "$DIR"/nvim/autoload/youcompleteme.vim
	cp "$DIR"/nvim/syntastic/plugin/syntastic.vim "$DIR"/nvim/autoload/syntastic.vim
	cp "$DIR"/nvim/vim-fugitive/autoload/fugitive.vim "$DIR"/nvim/autoload/fugitive.vim
	cp "$DIR"/nvim/vim-airline-themes/plugin/airline-themes.vim "$DIR"/nvim/autoload/airline-themes.vim
	cp "$DIR"/nvim/goyo.vim/autoload/goyo.vim "$DIR"/nvim/autoload/goyo.vim
	cp "$DIR"/nvim/vimspector/autoload/vimspector.vim "$DIR"/nvim/autoload/vimspector.vim
	cp "$DIR"/nvim/ale/autoload/ale.vim "$DIR"/nvim/autoload/ale.vim
	cp "$DIR"/nvim/nerdtree/plugin/NERD_tree.vim "$DIR"/nvim/autoload/NERD_tree.vim # does not copy
	cp "$DIR"/nvim/vim-devicons/plugin/webdevicons.vim "$DIR"/nvim/autoload/webdevicons.vim
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
function Configure() {
# Setting up coc
curl -sL install-node.now.sh/lts | bash

# Setting up YCM
git submodule update --init --recursive # "/home/$USR/.config/nvim/YouCompleteMe/third_party/ycmd/build.py"
# TODO Must detect latest python version and use it over all others
[ -e "$DIR"/nvim/YouCompleteMe ] && python3 "$DIR"/nvim/YouCompleteMe/install.py --all # This doesn't seem to work when executed in script

# Installing fzf
[ -e "$DIR"/nvim/fzf ] && "$DIR"/nvim/fzf/install

# Setup NERD fonts
[ ! -e /home/"$USR"/.local/share/fonts ] && mkdir "$HOME"/.local/share/fonts
[ "$(stat /home/"$USR"/.config/nvim/fonts)" != "0" ] && mkdir "$DIR"/nvim/fonts
# TODO copy fonts to .local/share/fonts and extract in font root folder

# curl is a non-POSIX utility and does NOT come pre-installed on some distributions
curl -LO https://github.com/belluzj/fantasque-sans/releases/download/v1.8.0/FantasqueSansMono-LargeLineHeight-NoLoopK.tar.gz -o "$DIR"/nvim/fonts
curl -LO https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraMono/Regular/complete/Fira%20Mono%20Regular%20Nerd%20Font%20Complete.otf -o "$DIR"/nvim/fonts # does not download anything to fonts folder
#	cp "$DIR"/nvim/fonts/*.otf /home/"$USR"/
cp "$DIR"/nvim/fonts/*.gz /home/"$USR"/.local/share/fonts/FantasqueSansMono-LargeLineHeight-NoLoopK.tar.gz && tar -xf "$(find . -name "*.gz")" | head -35 # Tar is a non-POSIX utility
# TODO Copy fonts to .local/share/fonts if previous command successful

# Setup kite for all available editors
if [ -e "$DIR"/nvim/pack/kite ] ; then
	echo "Kite is already installed, skipping."
elif [ ! -e "$DIR"/nvim/pack/kite ] ; then
	exec bash -c "$(wget -q -O - https://linux.kite.com/dls/linux/current)" #"$0" "$*" # This downloads kite
	# TODO Using "$0" "$*" causes script to crash. Consider writing kite installation to separate script (automated) and executing as normal user. Must clean when main setup script is finished.
fi
}

# Unzip writing files & permissions
chmod +x build.sh publish.sh
chmod 775 -R *
# TODO chown -R $USR *
# TODO symlink in /usr/bin

Main "$@" || [[ -z "${!$?}" ]] && print Failed ; exit 1
exit 0

# ALE not working at all
# mkdir ycm_build
# This issue is simply fixed by running install.py in nvim/autoload/plugged/YouCompleteMe/install.py before installing plugin

# ccls is still in pre-release
sudo apt install ccls # This has no effect, problem persists
npm i coc-ccls # do in root directory of coc.nvim in nvim/autoload/plugged/coc.nvim
# coc-ccls: main file ./lib/extension.js not found, you may need to build the project

#:CocInstall coc-clangd
sudo apt install clangd # Use clangd for linting & coc autocomplete LSP lang server
# The following goes in coc.nvim config file

# setting up GitHub CLI
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
sudo apt-add-repository https://cli.github.com/packages
sudo apt update
sudo apt install gh
sudo npm i -g bash-language-server #see README.md for more
echo "You must run \`gh auth login\`"

# TODO ask to install Terminator and download Mstkj's config files from  GitHub.
# TODO install zsh ohmyzsh termineter zshdb etc
git clone https://github.com/ohmyzsh/ohmyzsh.git

# for citation management, I recommend Zotero/Mendeley
# do you want to install Java jdk, runtime, gradle...?
# if y; then sudo apt install java-common openjdk-14-jdk openjdk-14-jre gradle
# use sudo apt install npm nodejs

# TODO ask what development tools you want. Are you programming in shellscript? Java? C++?
# TODO Do you want to use the retro terminal... just for fun
# TODO install joplin terminal client
# TODO Do you want to use rxvt-unicode or terminator
# TODO: deploy config files via tar and mv to install locations using $PATH<16-02-21, melthsked> #
# TODO needs to create dir /home/$USR/.config/nvim/ before downloading gits
# TODO must have to  download init.vim from github for script to work properly
# TODO script causes root user to be owner of nvim directory and sub-directories; must use sudo chown mstkj:mstkj -R nvim
# devicons not working on DaVimci startup
# TODO sudo apt install powerline fonts-powerline
# TODO sudo mkdir /home/mstkj/.local/share/fonts
# TODO fix "%%20" in font file names after download and replace "%%20" with underscore; this will fix devicons
# TODO Would you  like to add further terminal functionality? Add from ubuntu-setup.sh
# TODO Remember to implement rest of script functionality from notes in README.md
# TODO: install xelatex pdf engine for pandoc LaTeX: install as texlive-xetex and wkhtmltopdf. <18-02-21, melthsked> #
# TODO: Needs serious refactor <23-02-21, melthsked> #
