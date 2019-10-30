# How to generate the slides?
- Follow this write-up https://github.com/jgm/pandoc/wiki/Using-pandoc-to-produce-reveal.js-slides
- `pandoc -s --mathjax -i -t revealjs  -o devops-intro.html devops-intro.txt -V revealjs-url=./reveal.js -V theme=solarized --slide-level=2`
or
- use `make`

# How to show the presentation
- `python2 -m SimpleHTTPServer 8000 `
- Open browser at localhost:8080/devops-intro.html
- profit