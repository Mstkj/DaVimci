#!/bin/bash

function Main() {
clear
PS3="Enter input format:~$ "
options=(Docx PDF Markdown LaTeX HTML5)
select menu in "${options[@]}"
do
	if [[ "$REPLY" = "1" ]]; then # Docx
		echo -e "Input set to $REPLY is ${options[0]}.\n"
		inp="${options[0]}" && REPLY="Docx"; SearchInput
	elif [[ "$REPLY" = "2" ]]; then # PDF
		echo -e "Input set to $REPLY is ${options[1]}.\n"
		inp="${options[1]}" && REPLY="PDF"; SearchInput
	elif [[ "$REPLY" = "3" ]]; then # Markdown
		printf "\nInput set to %s${options[2]}.\n"
		inp="${options[2]}" && REPLY="Markdown"; SearchInput
	elif [[ "$REPLY" = "4" ]]; then # LaTeX
		echo -e "Input set to $REPLY is ${options[3]}.\n"
		inp="${options[3]}" && REPLY="LaTeX"; SearchInput
	elif [[ "$REPLY" = "5" ]]; then # HTML5
		echo -e "Input set to $REPLY is ${options[4]}.\n"
		inp="${options[4]}" && REPLY="HTML5"; SearchInput
	else
		clear ; echo -e "invalid option.\n"; Main
	fi
done
}

# TODO: Main function should be an overview of what the program does and should contain the primary functionality. <16-02-21, melthsked> #

function SearchInput() { # Function for rudimentary search engine
while true
do
	printf "Type filename (case sensitive).\n\n"
	read -rp "Search:~$ " inp
	read -rp "Set extension:~$ " ext
	#printf "\n.%s$ext\n"
	printf "Showing results containing \"%s$inp.%s$ext\":\n"
	com="$(find . "$PWD" -maxdepth 1 -type f -print -iname "$inp" | grep ".$ext" | head -15)"; printf "\n%s$com\n"
	printf "\nPress [Y] to continue or [N] to search:~$ "; read -rp "" res
	case "$res" in
		[yY][eE][sS]|[yY])
			#read -rp "File Name:~$ " inp
			OUTPUT="$inp.$ext"
			printf "\nInput file \"%s$inp.%s$ext\" ($REPLY) awaits output settings.\n\n"
			SearchOutput
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
PS3="Enter output format:~$ "
options=(Docx PDF Markdown LaTeX HTML5 ePub)
select menu in "${options[@]}"
do
	if [[ "$REPLY" = "1" ]]; then # Docx
		echo -e "Input set  $REPLY is ${options[0]}.\n"
		out="${options[0]}" && REPLY="Docx"; PdfEngine
	elif [[ "$REPLY" = "2" ]]; then # PDF
		# TODO: Is PDF LaTeX or HTML? <18-02-21, melthsked> #
		echo -e "Option $REPLY is ${options[1]}.\n"
		out="${options[1]}" && REPLY="PDF"; PdfEngine
	elif [[ "$REPLY" = "3" ]]; then # Markdown
		printf "\nOutput set to %s${options[2]}.\n\n"
		out="${options[2]}" && REPLY="Markdown"; PdfEngine
	elif [[ "$REPLY" = "4" ]]; then # LaTeX
		# TODO: we're assuming that  LaTeX is an actual .tex LaTeX document and not a PDF. <18-02-21, melthsked> #
		echo -e "Option $REPLY is ${options[3]}.\n"
		out="${options[3]}" && REPLY="LaTeX"; PdfEngine
	elif [[ "$REPLY" = "5" ]]; then # HTML5
		echo -e "Option $REPLY is ${options[4]}.\n"
		out="${options[4]}" && REPLY="HTML5"; PdfEngine
	elif [[ "$REPLY" = "6" ]]; then # ePub
		echo -e "Option $REPLY is ${options[5]}.\n"
		out="${options[5]}" && REPLY="ePub"; PdfEngine
	else
		clear ; echo -e "invalid option.\n"; SearchOutput
	fi
done
# TODO: If output LaTeX, publish to Tex or PDF? <16-02-21, melthsked> #
}

function PdfEngine() {
PS3="Enter PDF Format:~$ "
options=(wkhtmltopdf xelatex)
printf "%s${options[0]} will accept HTML/CSS syntax.\n%s${options[1]} will accept LaTeX.\n"
select menu in "${options[@]}"
do
	if [[ "$REPLY" = "1" ]]; then # Docx
		echo -e "Input set $REPLY is ${options[0]}.\n"; engine="--pdf-engine=${options[0]}"; SelectTemplate
	elif [[ "$REPLY" = "2" ]]; then # PDF
		echo -e "option $REPLY is ${options[1]}.\n"; engine="--pdf-engine=${options[1]}"; SelectTemplate
	else
		clear ; echo -e "invalid option.\n"; PdfEngine
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
				printf "%s${options[0]}.\n"; template="--template=${options[0]}"; Defaults
			elif [[ "$REPLY" = "2" ]]; then # template.html
				printf "%s${options[1]}.\n"; template="--template=${options[1]}"; Defaults
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
	ArticleClass
	;;
	*)
	printf "\nInvalid response...\n"
esac
}

function ArticleClass() {
	class="document-class=article"; printf "%s$class"; PandocOutputCommand
	# TODO: Choose class. Currently, article is only available class. It will be the default. <16-02-21, melthsked> #
}

# TODO: Function for opt-in csl and selecting format if so. <16-02-21, melthsked> #
# TODO: Bibliography references.bib function goes here <16-02-21, melthsked> #
# TODO: function for choosing cover.jpg <16-02-21, melthsked> #
# TODO: Are you compiling multiple source documents <16-02-21, melthsked> #
# TODO: Are you self-publishing an ePub <16-02-21, melthsked> #
# TODO: Are you using header.tex <16-02-21, melthsked> #

function PandocOutputCommand() {
# TODO: First, verify which variables are being used. <16-02-21, melthsked> #
# TODO: Final pandoc command function goes here; it should be a giant if statement. <16-02-21, melthsked> #
pandoc "$defaults" -f "$FORM_IN" -t "$FORM_OUT" "$INPUT" "$engine" "$template" "$css" "$metadata" --highlight-style=monochrome -V "$class" -V papersize=A4 --indented-code-classes=javascript --verbose --strip-comments --standalone --log=debug.log --data-dir=./ -o "${OUTPUT}"
}

Main "$@" || [[ -z "${!$?}" ]] && print Failed ; exit 1
exit 0

# Variables Key:
#		$FORM_IN 	= input format
#		$FORM_OUT = output format
#		$INPUT 		= input file name + extension
#		${OUTPUT} = output file name
#		$engine 	= HTML or LaTeX
#		$template = either HTML or Tex
#		$defaults = defaults.yaml
#		$css 			= styles.css
#		$metadata = metadata.xml
#		$class 		= article or other option
pandoc "$defaults" -f "$FORM_IN" -t "$FORM_OUT" "$INPUT" --pdf-engine="$engine" --template="$template" --css="$css" --metadata-file="$metadata" --highlight-style=monochrome -V document-class="$class" -V papersize=A4 --indented-code-classes=javascript --verbose --strip-comments --standalone --log=debug.log --data-dir=./ -o "${OUTPUT}"
