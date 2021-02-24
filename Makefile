
build:
	bash build.sh


compile:
	pandoc -D latex > template.tex
#	pandoc -D revealjs > template.js
	pandoc -D html5 > template.html
#	bash compile.sh

publish:
	bash publish.sh
	#bash -x install

install:
	bash setup.sh

clean:
	rm -rf tex2pdf.* ; rm debug.log ; rm template.tex ; rm template.js ; rm template.html
