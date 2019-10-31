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
    - Vesentlig enklere OS
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
- Klassiske retro-systemer kan være tungvinne
    - Vanskelig å få fatt i hardware
    - Emulator kan være tungvinn å sette opp, dårlig ytelse
    - Ikke gode IDE / verktøy for å utvikle egne spill / programmer
    - Assembly har høy terskel og BASIC kan oppleves som veldig annerledes fra dagens språk
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
- Minimalistisk nok til å være utfordrende og fostre kreativitet, tilgjengelig nok til å være moro

## Liker du konseptet men ikke gjennomføringen i PICO-8?
- TIC-80
    - Programmere spill i Lua, Wren, Moonscript...
    - 240x136 oppløsning
    - konfigurerbar 16-fargers palette
    - Mindre restriktiv enn pico-8
    - 64 kb begrensning på kode
    - Ingen begrensning på antall "tokens"
    - Open source (MIT)

- Script-8
    - Programmere spill i Javascript
    - 128x128 oppløsning, 8 gråtoner
    - 60 FPS refresh
    - Fantastisk tooling (bedre editor, live preview)

- PX-8
    - Programmere spill i Python, Lua eller Rust (!)
    - Konfigurerbar oppløsning
    - Ubegrenset med sprites

- Pixel Vision 8
    - Programmere spill i Lua eller C#
    - Utvidbar (CPU, Graphics, Memory, Sound etc)
    - Ferdige maler som likner på historiske konsoller
        - NES / Famicom
        - Sega Master System
        - Gameboy
        - Game gear
    - Full-featured OS med GUI (amigaOS-inspirert)

- BASIC8
    - Programmere spill i BASIC
    - 160x128 oppløsning, 16 farger, støtte for gjennomsiktighet
    - Veldig gode kreative verktøy / editorer

- Prism-384
    - Programmere spill i Javascript ES5.1
    - 384x216 oppløsning
    - 5376 farger, alpha blending
    - 60 FPS

- Chroma-60
    - Programmere spill i ren ASM
    - Innebygget debugger
    - 240x135 1-bit display
        - Kan sette 8 bit (RGB 332) farge for hhv forgrunn og bakgrunn
        - For å tegne med flere farger samtidig må man endre farge-registeret mens scanline-renderen tegner (!)

- Dusinvis andre varianter
    - https://github.com/paladin-t/fantasy


## Quotes:
What they offer is much more than just another game engine or SDK. They offer creative communities with their own styles, aesthetics and design philosophies that grow with each new game, each new demo, each new programming feat. All you need to do make an impact, is jump on in.
(https://medium.com/@G05P3L/fantasy-console-wars-a-guide-to-the-biggest-players-in-retrogamings-newest-trend-56bbe948474d)



