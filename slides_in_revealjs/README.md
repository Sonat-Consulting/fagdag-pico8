# How to generate the slides?
- Follow this write-up https://github.com/jgm/pandoc/wiki/Using-pandoc-to-produce-reveal.js-slides
- `pandoc -s --mathjax -i -t revealjs  -o pico8-tables.html pico8-tables.md -V revealjs-url=./reveal.js -V theme=solarized --slide-level=2`
or
- use `make html`

# How to show the presentation
- `python2 -m SimpleHTTPServer 8000 `
- Open browser at localhost:8080/pico8-tables.html
- profit
