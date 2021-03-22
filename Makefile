.PHONY : clean
.ONESHELL :
.DEFAULT_GOAL = help

#MAKEFILE_LIST :=
help: ## Prints help for targets with comments
	@cat $(MAKEFILE_LIST) | grep -E '^[a-zA-Z_-]+:.*?## .*$$' | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

#all run: clean
objects := $(patsubst %.md,%.pdf,$(subst $(source),$(output),$(sources)))
all: $(objects)
	@echo "You shall not pass!"

TEMP_OUT = $($(PD) -D html5 > $(RES)/template.html)
PROJ = $(shell touch ./src/new_project.md)
TAR = $(tar -xvf davimci.tar.gz)
MKBUILD = $(shell [[ -z ./build ]] && )
# TODO: if !build && mkdir build <20-03-21, melthsked> #
build:
	@echo ' 	I am help'
	$(PROJ)
	$(TEMP_OUT)
	$(TAR)

compile:
	@echo "I refuse..."

SRC := ./src
OUT := ./build
MARKDOWN := $(shell find src -type f -name "*.md")
MD=$(wildcard src/posts/*.md)
HTML=$(markdowns:src/posts/%.md=posts/%.html)
SHELL = /usr/bin/sh
# +yaml_metadata_block
# epub must use css
# TODO: is publish to epub or latex pdf <20-03-21, melthsked> #
publish: $(source)/%.md
	@# ^^^ https://www.gnu.org/software/make/manual/make.html
	@# ^^^ https://makefiletutorial.com/
	pandoc -D latex > template.tex
	pandoc -D html5 > template.html
	$(SHELL); \
	echo "Press [ENTER] to continue."; \
	@echo "What is your age?: "; \
	read NUM; \
    printf "Your age is $$NUM.\n"; $(NUM)

# xsl toc wkhtmltopdf
# TODO: opt-in csl and selecting format if so. <16-02-21, melthsked> #
# TODO: choosing cover.jpg <16-02-21, melthsked> #
# TODO: Are you compiling multiple source documents <16-02-21, melthsked> #
# TODO: Are you using header.tex <16-02-21, melthsked> #
	# --csl=./res/ieee.csl
	# --filter pandoc-citeproc
	# --bibliography=./refs/references.bib
	# --pdf-engine=xelatex or wkhtmltopdf
	# template="--template=template.html: html tex
	# document-class=article # or report
	# papersize=papersize=A4: A5 letter legal
	# --table-of-contents

PD = /usr/bin/pandoc
WK = /usr/bin/wkhtmltopdf
WKFLAGS = -B 25mm -T 25mm -L 25mm -R 25mm -s Letter
BUILD = ./build
TITLE = $(shell read -p "title??: ")
RES = ./res
META ?= ./res/metadata.xml
LOG = ./logs
CSS ?= ./css/master.css
PDFLAGS := +smart
# removed "+yaml_metadata_block"
%.pdf: $(SRC)/%.md
	$(PD) \
		--standalone \
		--defaults=$(RES)/html-defaults.yaml \
		-f markdown \
		-t html5 \
		--toc \
		--template=$(RES)/template.html \
		--number-sections \
		--highlight-style=kate \
		-V papersize=A4 \
		-V document-class=article \
		--indented-code-classes=javascript \
		--preserve-tabs \
		--verbose \
		--strip-comments \
		--log=$(LOG)/debug.log \
		--css=$(CSS) \
		$< | $(WK) $(WKFLAGS) \
		--encoding UTF-8 \
		--images \
		--user-style-sheet $(CSS) \
		--load-error-handling ignore \
		--enable-local-file-access \
		- $(BUILD)/$@

%.html:	$(SRC)/%.md
	$(PD) \
		--standalone \
		-f markdown \
		-t html5 \
		--table-of-contents \
		--number-sections \
		--indented-code-classes=html \
		--verbose \
		--css=$(CSS) \
		-o $(BUILD)/$@ $<

#title="$(TITLE)"
%.tex.pdf: $(SRC)/%.md
	$(PD) \
		$(PDFLAGS) \
		--standalone \
		--defaults=$(RES)/defaults.yaml \
		-f markdown \
		-t latex \
		--template=$(RES)/template.tex \
		--table-of-contents \
		--number-sections \
		--highlight-style=monochrome \
		-V papersize=A4 \
		-V document-class=article \
		--indented-code-classes=javascript \
		--verbose \
		--strip-comments \
		--metadata-file=$(META) \
		--pdf-engine=xelatex \
		-o $(BUILD)/$@ $<

# TODO: use csl with zotero instead of bibtex <20-03-21, melthsked> #
%.tex: $(SRC)/%.md
	$(PD) \
		--standalone \
		-f markdown \
		-t latex \
		--template=$(RES)/template.tex \
		--table-of-contents \
		--number-sections \
		--verbose \
		--strip-comments \
		-o $(BUILD)/$@ $<

%.docx: $(SRC)/%.md
	$(PD) \
		--standalone \
		-f markdown \
		-t docx \
		--table-of-contents \
		--number-sections \
		--indented-code-classes=javascript \
		--verbose \
		--css=$(CSS) \
		-o $(BUILD)/$@ $<
	pandoc -r $(OPTIONS) -w docx   --csl=$(PREFIX)/csl/$(CSL).csl --bibliography=$(BIB) --reference-doc=$(DOCXTEMPLATE) -o $@ $<

%.epub: $(SRC)/%.md

%.man: $(SRC)/%.md
#	tar gz

%.pptx: $(SRC)/%.md
	$(PD) \
		-f markdown \
		-t pptx \
		--verbose \
		--strip-comments \
		-o $(BUILD)/$@ $<

%.json: $(SRC)/%.md
	$(PD) \
		-f markdown \
		-t json \
		--indented-code-classes=javascript \
		--verbose \
		--strip-comments \
		-o $(BUILD)/$@ $<

%.md: $(SRC)/%.md
	# use gfm instead of github markdown

archive:
	@echo "Sorry, I don't actually exist."

# XML <-> HTML5
# Shell <-> Python
# Python >-> JavaScript
# Java <-> C++
# C++ >-> x86 Assembly
# C >-> C++
transpile:
	@echo "I invoke source-to-source compilers"

INS = $(shell ./install)
install:
	$(INS)

analyze: $(SRC)/

clean:
	rm -rf tex2pdf.* debug.log template.tex template.js template.html
	rm -f *.tmp
	rm -f package-lock.json
