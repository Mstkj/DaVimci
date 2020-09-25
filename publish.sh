#!/bin/bash

pandoc defaults.yaml -f markdown -t latex _first.md --pdf-engine=xelatex --template=template.tex --css=style.css --metadata-file=metadata.xml --highlight-style=monochrome -V document-class=article -V papersize=A4 --indented-code-classes=javascript --verbose --strip-comments --standalone --log=debug.log --data-dir=./ -o "_final.pdf"

# gather user input to variables and craft the command above
# Do you want to use defaults.yaml
# have you made proper edits to your abstract listed in defaults.yaml
# would you like to edit defaults.yaml
# what logo/cover would you like to use if any?
# do you want to use metadata.xml
# do you want to compile to docx or odt for other collaborators
# would you like to compile to latex? odt? docx? html5?
	# docx to pdf?
	# markdown to docx?
	# markdown to latex?
	# markdown to pdf?
	# latex to pdf?
	# do you want to compile multiple documents?
# do you want to create a webpage? webpage.html is the default name.
# do you want to publish to pdf or epub?
	# Are you self publishing?
	# where is your metadata.xml and cover.jpg?
# what do you want to name your file? _final is the default
# where is your bibliography and what is its name
# do you want to use a template
# do you want to use styles.css
# do you want to use header.tex
# do you want to use *.csl?


#echo -e "What name do you want to give your final docuemtn?\nName: "
#read -r NEWNAME
#mv _final.pdf "${NEWNAME}".pdf



exit 0
