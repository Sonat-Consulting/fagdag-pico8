# INTRO
1. Installasjon, oppsett av pico-8
   - kommandoer
   - hotkeys
2. Hello world 
    - **cls()**
    - **color()**
    - **print()**
    - bruk av palette
3. Game loop
    - **_init()**
    - **_update()**
    - **_draw()**
    - frame count, state

# SNAKE
1. Koordinatsystem, tegning, animasjon
    - **pset()**
    - **circFill()** /  **rectFill()**
1. state
    - tables
    - **add()**
1. Input
    - **btn()**
    - **pbtn()**
1. Kollisjoner del 1
    - mot vegg
    - mot slange
1. Mat
    - **random()**
    - kollisjon mot mat
    - **del()**
1. Sprites
1. Map


# PONG
1. Tegne geometri
    - draw state
    - **circ()**
    - **circFill()**
    - **rect()**
    - **rectFill()**
    - **line()**
1. Input 
1. AI
1. Kollisjoner del 2
    - mot vegg / kant av skjerm
    - mot kjente områder (paddle, brick, etc)
    - avstand fra senter av paddle


# ANDRE TEMAER
- Prototype-basert arv
- Coroutines
- AI, pathfinding (A*) 
    - graphs
    - heuristic
    - https://en.wikipedia.org/wiki/Taxicab_geometry
    - https://en.wikipedia.org/wiki/Chebyshev_distance
- Sprite-animasjon
- Ytelse
- Dithering
    - https://trasevol.dog/2017/02/01/doodle-insights-2-procedural-dithering-part-1/
- Trigonometri
- Entity component systems
- Lyd/Musikk
- Partikkelsystemer
- Parallax effect
- Minnelayout
- GPIO (kan brukes til kommunikasjon med javascript)
  - Remote Multiplayer (https://neopolita.itch.io/pico8com)
  - https://en.wikipedia.org/wiki/Lockstep_protocol
