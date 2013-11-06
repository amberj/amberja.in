# FILE        Makefile
# AUTHOR      Amber Jain <i.amber.jain [at] gmail>
# LICENSE     ISC
# DESCRIPTION Convert all *.markdown files (in pwd) to HTML

# Thanks to John MacFarlane's Makefile tip (from which this is derived):
# http://stackoverflow.com/a/11030209 

# Input
INPUT_MARKDOWN_FILES=$(wildcard *.markdown blog/*.markdown)

# Output
OUTPUT_HTMLS=$(patsubst %.markdown,%.html, $(INPUT_MARKDOWN_FILES))

.PHONY : all

all : $(OUTPUT_HTMLS)

%.html : %.markdown .
	cat site-templates/start_html.html >> $@
	perl Markdown.pl $< >> $@
	cat site-templates/end_html.html >> $@
