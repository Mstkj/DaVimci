#!/bin/bash

function Main() {
clear
PS3="Enter input format:~$ "
options=(Docx PDF Markdown LaTeX HTML5)
select menu in "${options[@]}"
do
	if [[ "$REPLY" = "1" ]]; then # Docx
		in="${options[0],,}"; SearchInput
	elif [[ "$REPLY" = "2" ]]; then # PDF
		in="${options[1],,}"; SearchInput
	elif [[ "$REPLY" = "3" ]]; then # Markdown
		in="${options[2],,}"; SearchInput
	elif [[ "$REPLY" = "4" ]]; then # LaTeX
		in="${options[3],,}"; SearchInput
	elif [[ "$REPLY" = "5" ]]; then # HTML5
		in="${options[4],,}"; SearchInput
	else
		clear ; printf "invalid option.\n"; Main
	fi
done
}

# TODO: Main function should be an overview of what the program does and should contain the primary functionality. <16-02-21, melthsked> #

function SearchInput() {
while true
do
	printf "Type filename (case sensitive).\n\n"; read -rp "Search:~$ " inp
	read -rp "Set extension:~$ " ext
	# TODO: If statement to automatically assume file extension in find command based on bash MIME type of file $in. <18-02-21, melthsked> #
	com="$(find . "$PWD" -maxdepth 1 -type f -print -iname "$inp" | grep ".$ext" | head -15)"; printf "\n%s$com\n"
	printf "\nPress [Y] to continue or [N] to search:~$ "; read -rp "" res
	case "$res" in
		[yY][eE][sS]|[yY])
			INPUT="$inp.$ext"; SearchOutput
			;;
		[nY][oO]|[nN])
			SearchInput
			;;
			*)
			printf "\nInvalid response, try again...\n"
	esac
done
}

function SearchOutput() {
printf "Enter document title:~$ "; read -rp "" name
PS3="Enter output format:~$ "
options=(Docx PDF Markdown LaTeX HTML5 ePub)
select menu in "${options[@]}"
do
	if [[ "$REPLY" = "1" ]]; then # Docx
		out="${options[0],,}"; PdfEngine
	elif [[ "$REPLY" = "2" ]]; then # PDF
		# TODO: Is PDF LaTeX or HTML syntax? <18-02-21, melthsked> #
		out="${options[1],,}"; PdfEngine
	elif [[ "$REPLY" = "3" ]]; then # Markdown
		out="${options[2],,}"; PdfEngine
	elif [[ "$REPLY" = "4" ]]; then # LaTeX

		# TODO: we're assuming that  LaTeX is an actual .tex LaTeX document and not a PDF. <18-02-21, melthsked> #
		out="${options[3],,}"; FinalOutput="$name.pdf"; PdfEngine

	elif [[ "$REPLY" = "5" ]]; then # HTML5
		out="${options[4],,}"; PdfEngine
	elif [[ "$REPLY" = "6" ]]; then # ePub
		out="${options[5],,}"; PdfEngine
	else
		clear ; printf "invalid option.\n"; SearchOutput
	fi
done
# TODO: If output LaTeX, publish to Tex or PDF? <16-02-21, melthsked> #
}

function PdfEngine() {
PS3="Select PDF engine:~$ "
options=(wkhtmltopdf xelatex)
printf "%s${options[0]} will accept HTML/CSS syntax.\n%s${options[1]} will accept LaTeX.\n"
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
	printf "\nInvalid response, try again...\n"
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
	printf "\nInvalid response...\n"
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
	printf "\nInvalid response...\n"
esac
}

function ArticleClass() {
	class="document-class=article"; printf "%s$class"; PaperSize
	# TODO: Choose class. Currently, article is only available class. It will be the default. <16-02-21, melthsked> #
}

function PaperSize() {
	papersize="papersize=A4"; PandocOutputCommand # TODO: Choose paper size; currently, A4 is only option. <18-02-21, melthsked> #
}

# TODO: opt-in csl and selecting format if so. <16-02-21, melthsked> #
# TODO: Bibliography references.bib function goes here <16-02-21, melthsked> #
# TODO: function for choosing cover.jpg <16-02-21, melthsked> #
# TODO: Are you compiling multiple source documents <16-02-21, melthsked> #
# TODO: Are you self-publishing an ePub? <16-02-21, melthsked> #
# TODO: Are you using header.tex <16-02-21, melthsked> #
# TODO: Code classes indentation. <18-02-21, melthsked> #
# TODO: Highlight styling <18-02-21, melthsked> #

function PandocOutputCommand() {
# TODO: iterate through values in array <18-02-21, melthsked> #

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

for i in "${array0[@],,}"
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
