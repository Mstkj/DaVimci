#!/bin/bash

function Main() {
clear
PS3="Input format:~$ "
options=(Docx PDF Markdown LaTeX HTML5)
select menu in "${options[@]}"
do
	if [[ "$REPLY" = "1" ]]; then # Docx
		ext="docx" # not .docm, .doc or other?
		in="${options[0],,}"; SearchInput
	elif [[ "$REPLY" = "2" ]]; then # PDF
		ext="pdf"; in="${options[1],,}"; SearchInput
	elif [[ "$REPLY" = "3" ]]; then # Markdown
		ext="md"; in="${options[2],,}"; SearchInput
	elif [[ "$REPLY" = "4" ]]; then # LaTeX
		ext="tex" # tex or pdf or other?
		in="${options[3],,}"; SearchInput
	elif [[ "$REPLY" = "5" ]]; then # HTML5
		ext="html"; in="${options[4],,}"; SearchInput
	else
		InvalidResponse; Main
	fi
done
}

# TODO: Main function should be an overview of what the program does and should contain the primary functionality. <16-02-21, melthsked> #

function SearchInput() {
while true
do # test MIME type of file and match with extension to determine $inp.
	com="$(find . -maxdepth 1 -type f -print -iname "*.$ext" | grep ".$ext")" # removed "$PWD" before -maxdepth
# TODO: Use awk and sed to remove './' from results <25-02-21, melthsked> #
	printf "\n%s$com\n"; read -erp "File Name:~$ " inp
	INPUT="$inp.$ext"
	printf "\n%s$INPUT\n"
	[[ ! -f "$INPUT" ]] && Main
	[[ -f "$INPUT" ]] && SearchOutput
done
}

function SearchOutput() {
printf "Output title:~$ "; read -erp "" name
PS3="Output format:~$ "
options=(Docx Markdown LaTeX HTML5 ePub)
select menu in "${options[@]}"
do
	if [[ "$REPLY" = "1" ]]; then # Docx
		out="${options[0],,}"
		OutputFormat="${options[0],,}"
		FinalOutput="$name.docx"
		PandocOutputCommand

	elif [[ "$REPLY" = "2" ]]; then # Markdown
		out="${options[1],,}"
	elif [[ "$REPLY" = "3" ]]; then # LaTeX

		OutputFormat="${options[2],,}"
		PS3="PDF or Tex:~$ "; options1=(PDF Tex)
		select menu1 in "${options1[@]}"; do
			[[ "$REPLY" = "1" ]] && out="${options1[0],,}"; FinalOutput="$name.pdf"; PdfEngine
			#[[ "$REPLY" = "2" ]] && out="${options1[1],,}"; FinalOutput="$name.tex"
			[[ ! "$REPLY" = "1" ]] && [[ ! "$REPLY" = "1" ]] && InvalidResponse; SearchOutput
		done

	elif [[ "$REPLY" = "4" ]]; then # HTML5

		# TODO: Stupid program keeps looping here after execution. <23-02-21, melthsked> #
		OutputFormat="${options[3],,}"
		out="${options[3],,}"
		PS3="Webpage or PDF:~$ "; options2=(Webpage PDF)
		select menu2 in "${options2[@]}"; do
			if [[ "$REPLY" = "1" ]]; then
				FinalOutput="$name.html"; PdfEngine
			elif [[ "$REPLY" = "2" ]]; then
				FinalOutput="$name.pdf"; PdfEngine
			#else InvalidResponse; SearchOutput
			fi
		done

	elif [[ "$REPLY" = "5" ]]; then # ePub
		out="${options[4],,}"
	else
		InvalidResponse; SearchOutput
	fi
done
}

function PdfEngine() {
#PS3="Select PDF engine:~$ "
#options=(wkhtmltopdf xelatex)
# TODO: Determine automatically based on prior input <23-02-21, melthsked> #
if [[ "$OutputFormat" = "html5" ]]; then
	engine="--pdf-engine=wkhtmltopdf"; SelectTemplate
elif [[ "$OutputFormat" = "latex" ]]; then
	engine="--pdf-engine=xelatex"; SelectTemplate
else
	printf "\nHello, user. I am broken.\n"; SearchOutput
fi
}

function SelectTemplate() {
if [[ "$OutputFormat" = "html5" ]]; then
	template="--template=template.html"; Defaults
elif [[ "$OutputFormat" = "latex" ]]; then
	template="--template=template.tex"; Defaults
else
	true
	# TODO: go to some previous function <23-02-21, melthsked> #
fi
}

function Defaults() {
	if [[ "$OutputFormat" = "latex" ]]; then
		defaults="defaults.yaml"; StyleCSS
	elif [[ ! "$OutputFormat" = "latex" ]]; then
		StyleCSS
	fi
}

function StyleCSS() {
	if [[ "$OutputFormat" = "html5" ]]; then
		css="--css=styles.css"; Metadata
	elif [[ "$OutputFormat" = "latex" ]]; then
		Metadata
	fi
}

function Metadata() {
# TODO: WARNING: program will break if you don't use metadata.xml. Consider setting metadata automatically. <23-02-21, melthsked> #
printf "Use metadata.xml? "; read -erp " [Y/n] " res
case "$res" in
[yY][eE][sS]|[yY])
	metadata="--metadata-file=metadata.xml"; ArticleClass
	;;
[nY][oO]|[nN])
	ArticleClass
	;;
	*)
	InvalidResponse
esac
}

function ArticleClass() {
	class="document-class=article"; printf "\n%s$class\n"; PaperSize
	# or class=report
}

function PaperSize() {
	papersize="papersize=A4"; PandocOutputCommand # or A5 or letter
}

function InvalidResponse() {
	printf "Invalid response...\n"
}

function PandocOutputCommand() { # TODO: Disable use of metadata.xml for PDF <07-03-21, yourname> #
	if [[ "$OutputFormat" = "docx" ]]; then

		pandoc -f "$in" -t "$out" "$INPUT" --verbose --strip-comments -o "${FinalOutput}"

	elif [[ -v "$defaults" ]] && [[ -v "$metadata" ]]; then

		pandoc "$defaults" -f "$in" -t "$out" "$INPUT" "$engine" "$template" "$metadata" --highlight-style=monochrome -V "$class" -V "$papersize" --indented-code-classes=javascript --verbose --strip-comments --standalone --log=debug.log --data-dir=./ -o "${FinalOutput}"

	elif [[ -z "$metadata" ]] && [[ "$engine" = "--pdf-engine=xelatex" ]]; then

		pandoc "$defaults" -f "$in" -t "$OutputFormat" "$INPUT" "$engine" "$template" --highlight-style=monochrome -V "$class" -V "$papersize" --indented-code-classes=javascript --verbose --strip-comments --standalone --log=debug.log --data-dir=./ -o "${FinalOutput}"


	elif [[ -v "$defaults" ]] && [[ -z "$metadata" ]]; then

		pandoc "$defaults" -f "$in" -t "$OutputFormat" "$INPUT" "$engine" "$template" --highlight-style=monochrome -V "$class" -V "$papersize" --pdf-engine-opt=--enable-local-file-access --indented-code-classes=javascript --verbose --strip-comments --standalone --log=debug.log --data-dir=./ -o "${FinalOutput}"

	elif [[ ! "$defaults" = "defaults.yaml" ]] && [[ -v "$metadata" ]]; then

		pandoc -f "$in" -t "$OutputFormat" "$INPUT" "$engine" "$template" "$css" "$metadata" --highlight-style=monochrome -V "$class" -V "$papersize" --pdf-engine-opt=--enable-local-file-access --indented-code-classes=javascript --verbose --strip-comments --standalone --log=debug.log --data-dir=./ -o "${FinalOutput}"

	elif [[ ! "$defaults" = "defaults.yaml" ]] && [[ -z "$metadata" ]]; then

		pandoc -f "$in" -t "$out" "$INPUT" "$engine" "$template" "$css" --highlight-style=monochrome -V "$class" -V "$papersize" --pdf-engine-opt=--enable-local-file-access --indented-code-classes=javascript --verbose --strip-comments --standalone --log=debug.log --data-dir=./ -o "${FinalOutput}"

	else
		printf "\nFailed...\n"
		return 1
	fi
}

if Main; then
	printf "Failed... exiting.\n"; exit 1
fi
#Main || [[ -z "${!$?}" ]] && printf "Failed... exiting" ; exit 1
exit 0

# TODO: function for margins choices: default is '-V geometry:margin=1in' <26-02-21, melthsked> #
# TODO: function for table of contents <26-02-21, melthsked> #
# TODO: highlight style other than monochrome <26-02-21, melthsked> #
# TODO: opt-in csl and selecting format if so. <16-02-21, melthsked> #
# TODO: Bibliography references.bib function goes here <16-02-21, melthsked> #
# TODO: function for choosing cover.jpg <16-02-21, melthsked> #
# TODO: Are you compiling multiple source documents <16-02-21, melthsked> #
# TODO: Are you self-publishing an ePub? <16-02-21, melthsked> #
# TODO: Are you using header.tex <16-02-21, melthsked> #
# TODO: Code classes indentation. <18-02-21, melthsked> #
# TODO: Highlight styling <18-02-21, melthsked> #

# DEBUG
# TODO: Wtf does it loop back to the middle of _mx_?!?! <21-02-21, melthsked> #
# TODO: How can YAML headers be implemented for HTML-based source files <28-02-21, melthsked> #
# TODO: HTML-based PDFs are rasterized by default; this should be optional. <28-02-21, melthsked> #
# TODO: HTML-based do not generate TOC, likely because they are rasterized; cannot seearch contents of PDF because of this. <28-02-21, melthsked> #
# TODO: stat file name in publish, return to function if not exist <05-03-21, melthsked> #
# pandoc -f markdown -t html5 list.md --pdf-engine=wkhtmltopdf -V margin-top=3cm -V margin-bottom=3cm -V margin-left=3cm -V margin-right=3cm --dpi=300 -o list.pdf
# TODO: simple things should not be so stupidly complicated, yet this it. <15-03-21, melthsked> #
# css is required for epub
# TODO: generate additional arguments with wkhtmltopdf opt in pandoc <15-03-21, melthsked> #
