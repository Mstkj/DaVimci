
build:
	bash build.sh
#	pandoc -f markdown -t html _first --template=template.tex --number-sections --highlight-style=monochrome -V document-class=article -V papersize=A4 -V geometry:margin=l --indented-code-classes=javascript --verbose --log=debug.log -o "webpage.html"


compile:
	pandoc -D latex > template.tex
#	pandoc -D revealjs > template.js
	pandoc -D html5 > template.html
#	bash compile.sh

publish:
	bash publish.sh
	#bash -x install
#	pandoc -f docx -t latex _manuscript.docx --pdf-engine=xelatex --template=template.tex --css=style.css --toc --number-sections --highlight-style=monochrome -V document-class=report -V papersize=A4 --verbose --log=debug.log --strip-comments --standalone -o "_final.pdf"

install:
	bash setup.sh

clean:
	rm -rf tex2pdf.* ; rm debug.log ; rm template.tex ; rm template.js ; rm template.html
