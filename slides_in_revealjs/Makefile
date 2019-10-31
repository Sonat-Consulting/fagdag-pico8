all: html pdf dslides

html: metatable-coroutine.md
	pandoc -s --mathjax -t revealjs -o metatable-coroutine.html metatable-coroutine.md -V revealjs-url=./reveal.js  --slide-level=2 -V theme=serif

pdf:
	pandoc -s -o metatable-coroutine.pdf metatable-coroutine.md

dslides:
	pandoc -s --mathml -i -t dzslides -o metatable-coroutine-dslides.html metatable-coroutine.md
