# Oppgave 1

I denne første oppgaven skal vi bli kjent med PICO-8.

## Del 1

Vi starter med en rask repetisjon av hjemmeoppgaven: 
- Start PICO-8
- Trykk `ESC` for å åpne editoren og skriv inn følgende i editorvinduet (bytt ut <navn> med ditt navn):
````lua 
for i=1,15 do
  color(i)
  print("hello <navn>")
end
````
- Trykk ESC igjen for å gå tilbake til kommandolinjen og skriv inn kommandoen `run`

En rask gjennomgang av kodeeksempelet:

1. For-løkker tar en variabel (her bruker vi `i`) og en range. Løkken vil iterere fra og med den første verdien, til og med den andre verdien.

2. `color(i)` er en api-funksjon som setter fargen som blir brukt i fremtidige kall til tegnefunksjoner som `print()`, `circ()`, `rect()` etc

3. `print(str)` tar en streng og tegner den på skjermen. Man kan også sende med koordinater og farge, men dersom man utelater koordinater vil den automatisk flytte nedover på skjermen linje for linje etterhvert som man kaller funksjonen flere ganger. 

## Del 2

Vi skal nå se på det PICO-8 kaller "game loop". Når man starter et PICO-8-program vil først alle funksjoner på toppnivå leses inn, og deretter vil den resterende koden evalueres sekvensielt. 

I eksempelet over deklarerte vi ingen funksjoner, så da ble bare for-løkken vår eksekvert til telleren nådde 15 og deretter ble programmet avsluttet. Dette kan være kjekt til testing og for smårutiner og verktøy, men er ikke så praktisk når man vil utvikle et spill.

PICO-8 har derfor 3 spesielle funksjoner som systemet vil kalle inn i dersom de finnes: `_init()`, `_update()` og `_draw()`. De fleste PICO-8-spill bruker minst èn av disse funksjonene for å la systemet styre oppdatering av spillets tilstand og/eller tegning til skjerm.

Åpne editoren igjen og skriv inn følgende kode:

````lua 
myvar = nil
print("utenfor")
function _init()
    myvar = 0
    print("init "..myvar)
end

function _update()
    if myvar > 5 then stop() end
    print("update "..myvar)
    myvar += 1
end

function _draw()
    print("draw "..myvar)
end
````
Gå tilbake til konsollet (`ESC`) og kjør programmet, og se på hva som skrives ut.

<details>
  <summary>Forventet resultat</summary>

Det bør skrives ut noe slik:

~~~~
utenfor
init 0
update 0
draw 1
update 1
update 2
draw 3
...
~~~~

</details>

Legg merke til at koden utenfor funksjonene blir kjørt aller først, deretter kjøres funksjonen `_init()` nøyaktig 1 gang. Etter det veksler systemet mellom å kalle funksjonene `_update()` og `_draw()`.

Ting vi ønsker å utføre gjentatte ganger i spillets levetid (som å sjekke om knapper er trykket inn, oppdatere posisjoner, tegne ting på skjermen) kan altså plasseres i disse funksjonene. Det er strengt tatt ikke store forskjeller på `_update()` og `_draw()` i så måte, men dersom man bruker for lang tid på 1 "frame" vil `_update()` kalles oftere og `_draw()` skjeldnere. Det vanlige er å sjekke input, oppdatere spillets interne tilstand og logikk etc i `_update()` og kun gjøre tegning til skjerm i `_draw()`


## Del 3

Nå som programmet vårt begynner å få en viss størrelse kan det være greit å passe på at det ikke forsvinner. Gå til konsollet og skriv kommandoene
```
save oppgave1.p8
folder
``` 

Du skal nå ha fått lagret programmet ditt til en mappe under PICO-8 sin arbeidsmappe. På Windows vil dette som standard være `%APPDATA%\pico-8\carts`. Kommandoen `folder` åpner denne mappen i et utforskervindu slik at det er lett å finne frem til den.

Alle endringer du gjør i programmet videre må lagres eksplisitt. Heldigvis finnes det en snarvei for å gjøre dette: `CTRL-S` (windows, for andre plattformer sjekk dokumentasjonen)

