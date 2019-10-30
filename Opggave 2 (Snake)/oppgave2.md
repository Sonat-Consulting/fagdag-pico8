# Oppgave 2 (Snake)

I denne oppgaven skal vi implementere et spill bit for bit.

Spillet vi har valgt er klassikeren "Snake" som de fleste sikkert har spilt. Kort sagt er spillets regler omtrent slik:
- Man styrer en orm som hele tiden beveger seg fremover i en konstant hastighet.
- Man kan endre retningen ormen beveger seg i, men kun i 4 retninger (opp,ned,venstr,høyre). 
- Mat blir lagt ut på tilfeldige steder på skjermen
- Dersom man styrer ormen frem til maten vil den vokse seg lengre og man tjener flere poeng. 
- Ormen dør dersom den kolliderer med veggene i brettet eller sin egen kropp.

Det ferdige spillet vil se omtrent slik ut:

![snake](snake_sprites_2.gif)

Vi starter med å sette opp funksjonene i gameloopen som diskutert i forrige oppgave:

```lua
function _init()
end

function _update()
end

function _draw()
end
```

lagre dette til en ny fil:

```
save oppgave2.p8
```
# Del 1

Det første vi trenger er en måte å flytte slangens hode fremover automatisk. Vi må også ha en må_te å tegne hodet, slik at vi kan se at flyttingen virker.

I første omgang vil vi at slangen er representert kun med hodet, og dette skal være 1 piksel bredt og høyt.
1. Utvid funksjonen `_init()` til å sette en initiell posisjon (`x` og `y`) til slangens hode
1. Utvid funksjonen `_update()` til å holde styr på hodets posisjon, og la denne posisjonen flytte seg mot høyre for hver gang funksjonen kalles.
    - Merk koordinatsystemet i PICO-8:
    - X-aksen går fra 0 til venstre på skjermen og til 127 helt til høyre
    - Y-aksen går fra 0 øverst på skjermen til 127 nederst

2. Utvid funksjonen `_draw()` til å tegne en representasjon av slangehodet.
    - Her vil du mest sannsynlig trenge funksjonen `pset(x,y,color)`

Resultatet bør se noe slik ut:

![oppgave 2.1](oppgave2_1.gif)

<details>
<summary>Løsningsforslag</summary>

```lua
function _init()
    -- Starter midt på skjermen
	x = 64
	y = 64
end

function _update()
    -- Øker x-koordinatet med 1
	x += 1
end	

function _draw()
    -- Tømme skjermen
    cls(0) 
    --Tegne rød piksel på gitt posisjon
	pset(x,y,8) 
end
```

</details>