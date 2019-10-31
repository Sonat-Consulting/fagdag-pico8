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

# Del 2

Dette ble litt smått, la oss skalere det opp litt.

Vi deler opp spillebrettet i 32x32 ruter, hver av disse er da 4 piksler i hver retning. Rute 0,0 ligger øverst til venstre, rute 31,31 ligger nederst til høyre.

TIPS: Om du tar vare på rutestørrelsen i en egen variabel (f.eks `cellsize`) er det lett å endre den senere. Antal ruter kan beregnes etter
`numcells = ceil(128 / cellsize)`

For å holde styr på slangens posisjon holder det at vi forholder oss til det nye rutenettet, men for opptegningen må vi oversette mellom rutekoordinater og skjermkoordinater. Her kan øvre venstre hjørne på cellen i skjermkoordinater finnes vha formelene 
`screenx = x * cellsize` og `screeny = y * cellsize`.

Selve opptegningen må også oppdateres, her kan du f.eks bruke funksjonen `rectfill(x1,y1,x2,y2,color)` evt `circfill(x,y,radius, color)`.

For at slangen ikke skal forsvinne så raskt ut fra skjermen skrur vi også ned hastigheten på simuleringen ved at vi bare oppdaterer status hver fjerde frame. Her er modulus-operatoren (`a % b`) veldig kjekk.

Når dette er på plass bør resultatet likne på dette:

![oppgave 2.2](oppgave2_2.gif)

TIPS: Dersom du er usikker på om hodet til slangen er tegnet på rett koordinat eller med riktig størrelse kan denne lille snutten legges inn i `_draw()` for å tegne opp rutenettet:

```lua
    for x = 0,31 do
        for y = 0,31 do
            pset(x*cellsize,y*cellsize,7)
        end
    end
```
<details>
<summary>Løsningsforslag</summary>

```lua
--disse innstillingene styrer skaleringen av spillet
cellsize = 4
boardsize = 128 / cellsize

function _init()
	t = 0
	x = boardsize / 2
	y = boardsize / 2
end

function _update()
    t += 1

    -- Vi vil bare oppdatere posisjonen hver cellsize frame. 
    -- Dette oppnår vi ved å sjekke restverdien fra å dele t på cellsize.
    -- Restverdien vil nemlig være 0 hver cellsize frame
    if t % cellsize != 0 then 
        return 
    end

    --vi oppdaterer fortsatt bare verdien med 1, men 1 betyr nå 1 celle, ikke 1 piksel:
	x += 1 
end	

function _draw()
    cls(0)
    -- her må vi gange opp koordinatene med cellsize 
    -- for å gå fra cellekoordinater til skjermkoordinater:
    rectfill(x * cellsize, y * cellsize, (x + 1) * cellsize - 1, (y + 1) * cellsize - 1, 8)
end 
```
</details>
