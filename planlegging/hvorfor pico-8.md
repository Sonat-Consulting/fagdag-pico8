## Dagens systemer er enormt komplekse
- Hva gjør egentlig den kodelinjen du skrev nå?
- Det kan fort avhenge av en masse ting:
    - Kompilator-optimalisering
    - Virtuell maskin
    - Scheduler
    - Virtual Memory Manager
    - Tilgangskontroll
    - Hypervisor
    - Latency (disk, nettverk, cache)
    - Avhengighet til annen hardware (Diskkontroller, GPU, AVX-unit etc)
    - Branch-prediction og spekulativ eksekvering

## Hvorfor er retro gøy?
- Straight-to-the-metal, slipper tenke på all kompleksiteten nevnt over
- Enklere system, mindre å forholde seg til
    - Færre fysiske brikker, busser og kontrollere
    - Én person kan teoretisk sett ha full oversikt over hele systemet
- Mindre API, må gjøre mer fra bunnen av
    - Alg.dat-boken blir nyttig igjen!
    - Får prøve seg frem på gamle teknikker
- Begrensninger skaper kreativitet!
    - Prosesseringshastighet
    - Oppløsning og fargepalette
    - Lydkanaler
    - Minne
    - Bare se på gamle amiga/c64-demoer!

## Hvorfor er PICO-8 enda gøyere?
- Klassiske retro-systemer er tungvinne
    - Vanskelig å få fatt i hardware
    - emulator kan være tungvinn å sette opp, dårlig ytelse
    - Ikke gode IDE / verktøy for å utvikle egne spill / programmer
- Vesentlig enklere å komme i gang med PICO-8
    - Ferdig installer for de fleste OS
    - Innebygde editorer
        - kode
        - sprites
        - map
        - sfx
        - musikk
    - Lett å deploye spill
- Moderne språk 
    - trenger ikke lære seg assembly eller basic
    - innebygde features som tables, metatables, strings, coroutines 
- Garbage collection, trenger ikke eksplisitt minnehåndtering
- Stort økosystem der folk deler kode og ideer
- minimalistisk nok til å være utfordrende, tilgjengelig nok til å være moro

## Liker du konseptet men ikke gjennomføringen i PICO-8?
- TIC-80
    - Program carts in Lua, Wren, Moonscript...
    - 240x136 resolution
    - customizable 16 color palette
    - Less restrictive than pico-8
    - 64 kb code limit
    - No arbitrary limit on code symbols
    - Open source (MIT)
- Script-8
    - Program carts in Javascript
    - 128x128 resolution, 8 greyscale levels 
    - 60 FPS refresh rate
    - Amazing tooling (better editor, live preview)
- PX-8
    - Program carts in Python, Lua or Rust (!)
    - Customizable resolution
    - Unlimited sprites 
- Pixel Vision 8
    - Program carts in Lua
    - Extendable (CPU, Graphics, Memory, Sound etc)
    - Can be tailored to simulate existing consoles
    - Full-featured OS with GUI, running on console (amiga-like)
- FAZIC
    - Program carts in BASIC!
    - In development (so far missing a lot of features)
- Chroma-60
    - Program carts in pure ASM because fuck you
- Dozens of others!


## Quotes:
What they offer is much more than just another game engine or SDK. They offer creative communities with their own styles, aesthetics and design philosophies that grow with each new game, each new demo, each new programming feat. All you need to do make an impact, is jump on in.
(https://medium.com/@G05P3L/fantasy-console-wars-a-guide-to-the-biggest-players-in-retrogamings-newest-trend-56bbe948474d)



