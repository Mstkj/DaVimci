#!/bin/bash

function Main() {
clear
PS3="Enter input format:~$ "
options=(Docx PDF Markdown LaTeX HTML5)
select menu in "${options[@]}"
do
	if [[ "$REPLY" = "1" ]]; then # Docx
		ext="docx" # not docm, doc or other?
		in="${options[0],,}"; SearchInput
	elif [[ "$REPLY" = "2" ]]; then # PDF
		ext="pdf"
		in="${options[1],,}"; SearchInput
	elif [[ "$REPLY" = "3" ]]; then # Markdown
		ext="md"
		in="${options[2],,}"; SearchInput
	elif [[ "$REPLY" = "4" ]]; then # LaTeX
		ext="tex" # tex or pdf or other?
		in="${options[3],,}"; SearchInput
	elif [[ "$REPLY" = "5" ]]; then # HTML5
		ext="html"
		in="${options[4],,}"; SearchInput
	else
		InvalidResponse; Main
	fi
done
}

# TODO: Main function should be an overview of what the program does and should contain the primary functionality. <16-02-21, melthsked> #
function InvalidResponse() {
	printf "Invalid response...\n"
}

function SearchInput() {
while true
do # test MIME type of file and match with extension to determine $inp.
	com="$(find . "$PWD" -maxdepth 1 -type f -print -iname "*.$ext" | head -15)"
	printf "\n%s$com\n" # removed "grep ".$ext"
	read -rp "File Name:~$ " inp
	case "$res" in
		[yY][eE][sS]|[yY])
			INPUT="$inp.$ext"; SearchOutput
			;;
		[nY][oO]|[nN])
			SearchInput
			;;
			*)
			InvalidResponse
	esac
done
}

function SearchOutput() {
printf "Enter document title:~$ "; read -rp "" name
PS3="Enter output format:~$ "
options=(Docx Markdown LaTeX HTML5 ePub)
select menu in "${options[@]}"
do
	if [[ "$REPLY" = "1" ]]; then # Docx
		out="${options[0],,}"
	elif [[ "$REPLY" = "2" ]]; then # Markdown
		out="${options[1],,}"
	elif [[ "$REPLY" = "3" ]]; then # LaTeX
		PS4="PDF or Tex"; options1=(PDF Tex)
		select menu1 in "${options1[@]}"; do
			out="${options[2],,}"
			[[ "$REPLY" = "1" ]] && FinalOutput="$name.pdf"; PdfEngine
			[[ "$REPLY" = "2" ]] && FinalOutput="$name.tex"
			[[ ! "$REPLY" = "1" ]] && [[ ! "$REPLY" = "1" ]] && InvalidResponse; SearchOutput
		done
	elif [[ "$REPLY" = "4" ]]; then # HTML5
		PS5="Webpage or PDF"; options2=(Webpage or PDF)
		select menu2 in "${options2[@]}"; do
			out="${options[3],,}"
			[[ "$REPLY" = "1" ]] && FinalOutput="$name.html"
			[[ "$REPLY" = "2" ]] && FinalOutput="$name.pdf"; PdfEngine
			[[ ! "$REPLY" = "1" ]] && [[ ! "$REPLY" = "2" ]] && InvalidResponse; SearchOutput
		done
	elif [[ "$REPLY" = "5" ]]; then # ePub
		out="${options[4],,}"
	else
		InvalidResponse; SearchOutput
	fi
done
}

function PdfEngine() {
PS3="Select PDF engine:~$ "
options=(wkhtmltopdf xelatex)
printf "%s${options[0]} will accept HTML syntax & LaTeX for %s${options[1]}.\n"
select menu in "${options[@]}"
do
	if [[ "$REPLY" = "1" ]]; then # Docx
		engine="--pdf-engine=${options[0]}"; SelectTemplate
	elif [[ "$REPLY" = "2" ]]; then # PDF
		engine="--pdf-engine=${options[1]}"; SelectTemplate
	else
		clear ; printf "invalid option.\n"; PdfEngine
	fi
done
}

function SelectTemplate() {
printf "Press [Y] to use template and [N] to continue without:~$ "; read -rp "" res
case "$res" in
	[yY][eE][sS]|[yY])
		PS3="Select Template:~$ "
		options=(Tex HTML)
		select menu in "${options[@]}"
		do
			if [[ "$REPLY" = "1" ]]; then # template.tex
				template="--template=template.tex"; Defaults
			elif [[ "$REPLY" = "2" ]]; then # template.html
				template="--template=template.html"; Defaults
			else
				printf "Invalid option.\n"; SelectTemplate
			fi
		done
		;;
	[nY][oO]|[nN])
		Defaults
		;;
		*)
		printf "\nInvalid response, try again...\n"
esac
}

function Defaults() {
printf "Use defaults.yaml? "; read -rp " [Y/n] " res
case "$res" in
[yY][eE][sS]|[yY])
	defaults="defaults.yaml"; StyleCSS
	;;
[nY][oO]|[nN])
	StyleCSS
	;;
	*)
	InvalidResponse
esac
}

function StyleCSS() {
printf "Use styles.css? "; read -rp " [Y/n] " res
case "$res" in
[yY][eE][sS]|[yY])
	css="--css=styles.css"; Metadata
	;;
[nY][oO]|[nN])
	Metadata
	;;
	*)
	InvalidResponse
esac
}

function Metadata() {
printf "Use metadata.xml? "; read -rp " [Y/n] " res
case "$res" in
[yY][eE][sS]|[yY])
	metadata="--metadata-file=metadata.xml"; ArticleClass
	;;
[nY][oO]|[nN])
	unset metadata; ArticleClass
	;;
	*)
	InvalidResponse
esac
}

function ArticleClass() {
	class="document-class=article"; printf "%s$class"; PaperSize
	# TODO: Currently, article is only available class. <16-02-21, melthsked> #
}

function PaperSize() {
	papersize="papersize=A4"; PandocOutputCommand # TODO: Currently, A4 is only option. <18-02-21, melthsked> #
}

function PandocOutputCommand() {
# TODO: Could use awk/sed to remove unwanted conditions/variables from PandocOutputCommand. <21-02-21, melthsked> #
array0=(
	"$in"
	"$out"
	"$INPUT"
	"$engine"
	"$template"
	"$css"
	"$metadata"
	"$class"
	"$papersize"
	"$FinalOutput"
)

for i in "${array0[@],,}";
do
	:
	printf "%s$i\n"; sleep 0.5
	[[ -z "$i" ]] || printf "\n%s$i exists.\n"
	[[ -z "$i" ]] && printf "\n%s$i does not exist.\n"
done

# TODO: Final pandoc command function goes here; it should be a giant if statement in for loop. Should be procedural: if this, goto x. <16-02-21, melthsked> #

pandoc "$defaults" -f "$in" -t "$out" "$INPUT" "$engine" "$template" "$css" "$metadata" --highlight-style=monochrome -V "$class" -V "$papersize" --indented-code-classes=javascript --verbose --strip-comments --standalone --log=debug.log --data-dir=./ -o "${FinalOutput}"
}

Main "$@" || [[ -z "${!$?}" ]] && print Failed ; exit 1
exit 0
# TODO: opt-in csl and selecting format if so. <16-02-21, melthsked> #
# TODO: Bibliography references.bib function goes here <16-02-21, melthsked> #
# TODO: function for choosing cover.jpg <16-02-21, melthsked> #
# TODO: Are you compiling multiple source documents <16-02-21, melthsked> #
# TODO: Are you self-publishing an ePub? <16-02-21, melthsked> #
# TODO: Are you using header.tex <16-02-21, melthsked> #
# TODO: Code classes indentation. <18-02-21, melthsked> #
# TODO: Highlight styling <18-02-21, melthsked> #

# DEBUG
# TODO: Keeps looping back to SelectTemplate <21-02-21, melthsked> #
# To create a pdf using pandoc, use -t latex|html5
# and specify an output file with .pdf extension (-o filename.pdf).
