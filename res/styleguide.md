% I am a title
% I am the author
% I am the date

The YAML header is typically used for LaTex. Otherwise, you should use HTML meta tags as this serves as your metadata.xml and defaults.yaml.

This is a line:
* * *

[//]: # (The above is a pandoc title block)
You can also use LaTex .yaml headers do present the title information.

You can use a YAML metadata header here
Alternatively, you can call defaults.yaml with pandoc

Also, if you are converting markdown to LaTex PDF, you can insert LaTex syntax as well as HTML syntax for wkhtmltopdf.

You can also use inline CSS if you wish.\
<style type="text/css" rel="stylesheet">
* { color: red; }
</style>

You can insert a markdown-compatible line break with a backslash.\
Or, you could use the HTML equivalent <br>

A pagebreak  written in LaTex syntax looks like this. `\pagebreak` \
A pagebreak in HTML looks like this: `<p style="page-break-before: always">`
<p style="page-break-before: always">
<div style="page-break-after: always;"></div>

Abstract{ I am an abstract written in LaTex syntax }

Markdown will take HTML or LaTex syntax depending on how you compile the document.

# I am an H1 heading
## I am an H2 heading
### I am an H3 heading

I am also an H1 heading
=======================

I am another H2 heading
-----------------------

**I am bold text**
__I am also bold text__
*I am italicized text*
_I am italicized_ text

<u>I am HTML underlined text </u>
++I am markdown underlined text++

~~I am a crossed out~~

[//]: # (This may be the most platform independent comment)

Generally, you can use HTML in a markdown document
This is relevant because markdown does not have native underlining syntax.

~~The earth is flat!~~

You can even do __*combinations*__ of text modifications.

Using three dashes "-" in a row are rendered as an em dash --- like so.
Using three dots ... Generates ellipsis.
You can also use the HTML tags for the same purposes, such as `&ndash;` &ndash; to represent the 'en dash.'\
Like the &ndash;, you can use `&mdash;` &mdash; for the 'em dash.'\

> I am a blockquote
> > I am a nested blockquote
> Back to the first level

> #### an H4 heading ####
> You can nest markdown elements inside others

1. I am an ordered list
2. I am another item
3. I am the third item

- I am an unordered list
- I am another item on the list

`import code.Code as code`
`# I am python3.x code`

---
## The above is a horizontal rule ##

    This text is represented as code when indented with four spaces.

This is a page break in HTML syntax: `pagebreak` \


Put spaces between sentences to signify new paragraph.\

Like so...

Bellow lies an HTML comment, which is arguably easier than a markdown comment.
<!-- I am a comment -->

The next two are obvious
[title](https://example.com)
[Google](https://google.com)

![alt text](image.jpg)
<!-- alt text is the descriptive name of the image -->

## The following is a table ##

| Syntax | Description |
| ------ | ----- |
| Header | Title |
| Paragraph | Text |


## The following is a fenced code block ##

```c
# include <stdio.h>

/*
 * I am a hello world program written in C
 */

int main(void) {
	printf("Hello, world!\n");
	return 0;
}
```

## Below is an example of a footnote ##

Here's a sentence with a footnote [^1]
[^1]: This is the footnote.

## Below lies a heading ID
### My Great Heading ID {#custom-id}

I am a term
: I am the definition

I am a task list
- [x] Write Markdown style guide
- [ ] Customize grub.cfg
- [ ] Finish homepage

* This is an unordered list
- There are multiple correct ways to write them
+ These all mean the same

### The following will be rendered as HTML
* Item 1
	* Item 2
* Item 3

That is because there is a blank line left between the two items.

I am more text, and I am here for you to read.
	> I am an embeded blockquote
	> I am a continuation.

1986\. You can trigger a list by accident, so add a \ before the period. It functions as an escape character.

If you would like to use local resources on the same server, relative links are used.

This is [an example][id] reference-style link

You must define the link by:
[id]: https://example.com/ "Title"

If you have a long URL, you can place the title on the next line preceded by spaces.
[id]: https://example.com/the/path/to/your/intended/resource/goes/here/
    (Title)

```c
#incluce <stdio.h>
int main(void) {
		printf("Hello, world.\n");
}
return 0;
```

## Here is an example of reference links.

Lots and lots of traffic goes to [Google] [1] compared to most search engines.

[1]: https://google.com/ "Google"

I am ^sup^

> TODO: Follows: <15-03-21, melthsked> >

+ Soft break
+ Linkify
+ Typographer support
+ Fountain syntax
+ Math expresssions
+ Mermaid diagrams
+ Audio Player
+ Video Player
+ ==mark== syntax
+ ++insert++ syntax
+ Emoji syntax
+ Multimarkdown table
