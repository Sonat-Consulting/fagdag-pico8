all: html pdf dslides

html: pico8-tables.md
	pandoc -s --mathjax -t revealjs -o pico8-tables.html pico8-tables.md -V revealjs-url=./reveal.js  --slide-level=2 -V theme=solarized

pdf:
	pandoc -s -o pico8-tables.pdf pico8-tables.md

dslides:
	pandoc -s --mathml -i -t dzslides -o pico8-tables-dslides.html pico8-tables.md
