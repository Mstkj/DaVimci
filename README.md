
# How to use #

In pandoc, use the '{ --bibliography }' tag to specify that there are academic references in the following file

LaTex is significantly more difficult to use than markdown and should be reserved for more technical or academic writing.


the first draft is labled as `_first` and the second is `_manuscript`. the third is _final.

If you want to use latex for your manuscript, one will be generated for you.

You also have a sample bibliography `lib.bib`, metadata.xml, styles.css, and template.js

you should place your document image cover in this folder, otherwise, `description` will simply be used by pandoc.

vim-setup.sh will be called by Makefile to do most of the heavy lifting.

publish to github and website when done

each project should have its own folder to avoid name confusion

add scripts to the makefile for each function, one being to name the document, add the ability to compile multiple docs together, and to customize the fonts and formatting through something like latex automatically during the compille stage
