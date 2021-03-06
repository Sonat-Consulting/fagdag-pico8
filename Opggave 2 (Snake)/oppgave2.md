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
# Del 1 - animasjon

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
<summary>Løsningsforslag del 1</summary>

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

# Del 2 - celler / rutenett

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
<summary>Løsningsforslag del 2</summary>

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

## Del 3 - input

Nå som slangehodet tegnes riktig i det nye rutenettet skal vi legge inn mulighet for å styre det. Vi vil dermed sjekke i `_update()` om retningsknappene er trykket ned, og dersom de er det endre retningen slangen skal bevege seg i. En grei måte å gjøre dette er å dele opp retningen i x- og y- komponent slik at man har variablene `dirx` og `diry`. Hver av disse kan ha verdiene -1,0 eller 1 avhengig av retningen man beveger seg i. Oppdateringen av posisjonen kan da gjøres per komponent også:

```lua
x += dirx
y += diry
```

For å sjekke om en knapp har blitt trykket ned siden sist kan man bruke funksjonen `btnp(buttonid)`. Som buttonid kan man enten sende inn tallverdier eller spesielle symboler (emojis) som representerer retningene og knappene. I PICO-8-editoren finner man retning-emojiene på shift-u (up), shift-d (down), shift-l (left) og shift-r (right). I tillegg finnes shift-x og shift-z som representerer de to knappene på kontrolleren. Om man sitter i en ekstern editor kan man prøve å lime inn en av disse (fungerer i visual studio code på windows):

⬆️⬇️⬅️➡️

* Merk: Det kan være smart å skille mellom hvilken retning slangen beveget seg i forrige steg og hvilken vei den skal bevege seg i neste steg. Dette fordi vi vil gjøre det mulig å ombestemme seg inntil neste flytt, og samtidig vil vi at det skal være umulig å snu 180 grader i samme flytt, for da havner vi jo inn i vår egen hale.

I tillegg vil vi gjøre det slik at om slangen beveger seg utenfor brettet så fortsetter den på andre siden, slik at vi slipper å starte på nytt hver gang vi havner utenfor. Her kan på nytt modulo-operatoren `%` komme til nytte.

Med dette på plass bør resultatet se noe slikt ut:

![oppgave 2.3](oppgave2_3.gif)

<details>
<summary>Løsningsforslag del 3</summary>

```lua
cellsize = 4
boardsize = 128 / cellsize

function _init()
	t = 0
	x = boardsize / 2
    y = boardsize / 2
    -- initiell retning:
	dirx = 1
    diry = 0
    movingx = dirx
    movingy = diry
end

function checkinput()
    -- endre (neste) retning avhengig av knappen som ble trykket ned
    -- merk sjekkene mot moving[x|y] der vi sjekker at man ikke snur
    -- 180 grader i samme flytt
    if btn(⬆️) and movingy != 1 then
        diry = -1
        dirx = 0
    elseif btn(⬇️) and movingy != -1 then
        diry = 1
        dirx = 0
    elseif btn(⬅️) and movingx != 1 then
        dirx = -1
        diry = 0
    elseif btn(➡️) and movingx != -1 then
        dirx = 1
        diry = 0
    end
end		

function move()
    -- oppdatere x- og y-posisjon, ta høyde for 
    -- at man beveger seg ut av brettet og inn på andre siden:
	x = (x + dirx) % boardsize
    y = (y + diry) % boardsize
    -- lagre unna retningen for forrige flytt slik at vi kan sjekke mot det i checkinput()
	movingx = dirx
	movingy = diry
end

function _update()
    t += 1
    -- vi sjekker input for hver frame selv om vi ikke oppdaterer 
    -- posisjonen så ofte, dette så vi ikke går glipp av tastetrykk:
	checkinput()
	if t % cellsize != 0 then return end
	move()
end	

function _draw()
	cls(0)
	rectfill(x*cellsize,y*cellsize,(x+1) * cellsize - 1, (y + 1) * cellsize - 1, 8)
end
```
</details>

## Del 4 - halen

Nå som vi kan styre slangens hode rundt på brettet skal vi legge på en hale på slangen. Halen skal følge etter hodet slik at alle cellene hodet har vært innom skal berøres av halen ettersom den beveger seg over brettet.

Det finnes flere måter å holde styr på dette, men vi har for for denne oppgaven valgt å holde på alle halens segmenter i en sekvens (en spesiell form for lua-tabell der elementene ikke har en eksplisitt nøkkel / key). Når hodet flytter seg legger vi til den nye posisjonen i sekvensen, og fjerner deretter de eldste posisjonene inntil halen har riktig lengde.

For å opprette en tom sekvens kan man bruke syntakset
```lua
tail = {}
```

API-funksjonene `add(tail, element)` og `remove(tail,element)` kan så brukes for å manipulere sekvensen. For å finne lengden på sekvensen kan man bruke syntakset `#tail`.

* MERK: Lua-sekvenser starter nummereringen fra 1 og ikke 0!

La slangen starte med en initiell lengde på 3, men med en tom sekvens. Skriv logikken som gjør at halen flytter seg etter hodet på spillebrettet. 

Legg også inn funksjonalitet i `_draw()` som tegner halen etter at hodet har blitt tegnet. Det kan være greit å splitte ut tegning av hhv hode og hale i egne funksjoner.

Endre gjerne også bakgrunnsfargen i kallet til `cls(color)` til noe annet enn sort. 

Med dette på plass bør resultatet se omtrent slik ut:

![oppgave 2.4](oppgave2_4.gif)

<details>
<summary>Løsningsforslag del 4</summary>

```lua
--init
cellsize = 4
boardsize = 128 / cellsize

function _init()
	t = 0	
	x = boardsize / 2
	y = boardsize / 2
	dirx = 1
	diry = 0
	movingx = dirx
    movingy = diry
    
    --vi starter med en tom hale-sekvens og en lengde på 3
	tail = {}
	length = 3
end


-->8
--update
function checkinput()
	if btn(⬆️) and movingy != 1 then
		diry = -1
		dirx = 0
	elseif btn(⬇️) and movingy != -1 then
		diry = 1
		dirx = 0
	elseif btn(⬅️) and movingx != 1 then
		dirx = -1
		diry = 0
	elseif btn(➡️) and movingx != -1 then
		dirx = 1
		diry = 0
	end
end		

function move()
    -- legg til forrige posisjon i halen
    add(tail, {x = x, y = y})
    -- og fjerne eventuelle gamle posisjoner fra halen til den har riktig lengde
	while #tail > length do
		del(tail, tail[1])
	end

	x = (x + dirx) % boardsize
	y = (y + diry) % boardsize
	movingx = dirx
	movingy = diry	
end

function _update()
	t += 1
	checkinput()
	if t % cellsize != 0 then 
		return
	end
	move()
end	

-->8
--draw

function drawhead()
	drawsegment(x, y, 8)
end

function drawtail()
	for segment in all(tail) do
		drawsegment(segment.x, segment.y, 11)
	end
end

function drawsegment(x, y, color)
    -- her har vi abstrahert bort tegning av et segment 
    -- slik at samme kode kan brukes både fra drawhead og drawtail
	rectfill(x * cellsize, 
		y * cellsize,
		(x + 1) * cellsize - 1, 
		(y + 1) * cellsize - 1, 
		color)
end

function _draw()
	cls(7)
	drawhead()
	drawtail()
end

```
</details>

## Del 5 - mat

Nå begynner spillet å ta form, og vi trenger litt innhold. Vi skal legge ut litt mat til slangen, og lage logikken som gjør at slangen vokser seg lengre når den spiser.

Lag funksjonen `spawnfood()` og la den finne en tilfeldig posisjon på brettet for å legge ut maten. Funksjonen må sjekke at posisjonen er ledig, altså at ikke hodet eller deler av halen befinner seg på den ruten. Husk at tallene fra `rnd(max)` er desimaltall og må rundes opp eller ned til heltall.

Lag også funksjonen `drawfood()` som tegner maten. Denne kan gjerne gjenbruke `drawsegment()` fra tidligere.

Til slutt, lag en funksjon `checkcollision()` som sjekker om hodet til slangen befinner seg på samme posisjon som maten. Hvis den gjør det, øk lengden på slangen med 3 og kall `spawnfood()` for å sette ut en ny matbit.

![oppgave 2.5](oppgave2_5.gif)

<details>
<summary>Løsningsforslag del 5</summary>

```lua
--init
cellsize = 4
boardsize = 128 / cellsize

function _init()
	t = 0	
	x = boardsize / 2
	y = boardsize / 2
	dirx = 1
	diry = 0
	movingx = dirx
	movingy = diry
	tail = {}
    length = 3
    -- sette ut første matbit:
	spawnfood()
end


-->8
--update
function checkinput()
	if btn(⬆️) and movingy != 1 then
		diry = -1
		dirx = 0
	elseif btn(⬇️) and movingy != -1 then
		diry = 1
		dirx = 0
	elseif btn(⬅️) and movingx != 1 then
		dirx = -1
		diry = 0
	elseif btn(➡️) and movingx != -1 then
		dirx = 1
		diry = 0
	end
end		

function move()
	add(tail, {x = x, y = y})
	while #tail > length do
		del(tail, tail[1])
	end

	x = (x + dirx) % boardsize
	y = (y + diry) % boardsize
	movingx = dirx
	movingy = diry	
end

function checkcollision()
    -- hvis hodet er på samme rute som maten skal slangen vokse:
	if x == foodx and y == foody then
        length += 3
        -- vi setter også ut ny mat:
		spawnfood()
   end 
end

function spawnfood()
    -- merk at vi runder ned tallet fra rnd til nærmeste heltall
    foodx = flr(rnd(boardsize))
    foody = flr(rnd(boardsize))
    while not isempty(foodx,foody) do
        foodx = flr(rnd(boardsize))
        foody = flr(rnd(boardsize))
    end
end

function isempty(cellx, celly)
    -- ruten er ikke tom dersom hodet til slangen er der:
	if cellx == x and celly == y then
		return false
    end
    -- ruten er heller ikke tom dersom et segment i halen er der:
    for segment in all(tail) do
        if segment.x == cellx and segment.y == celly then
            return false
        end
    end
    
    -- vi fant ingen hindringer, ruten er tom:
    return true
end
	

function _update()
	t += 1
	checkinput()
	if t % cellsize != 0 then 
		return
    end
    -- vi sjekker for kollisjon før vi flytter:
	checkcollision()
	move()
end	

-->8
--draw

function drawhead()
	drawsegment(x, y, 8)
end

function drawtail()
	for segment in all(tail) do
		drawsegment(segment.x, segment.y, 11)
	end
end

function drawfood()
    -- vi bruker samme tegnefunksjon bare med en annen farge:
	drawsegment(foodx, foody, 9)
end

function drawsegment(x, y, color)
	rectfill(x * cellsize, 
		y * cellsize,
		(x + 1) * cellsize - 1, 
		(y + 1) * cellsize - 1, 
		color)
end

function _draw()
	cls(7)
	drawhead()
	drawtail()
	drawfood()
end
```
</details>

## Del 6 - resterende spill-logikk

Nå skal vi gjøre ferdig spill-mekanismene. Det som gjenstår er:

1. Ved spillets avslutning skal vi skrive ut en melding samt poengsummen. Vi må også slutte å oppdatere spillebrettet.
1. Spillet er over dersom slangen treffer seg selv
1. Spillet er over dersom slangen treffer kanten på spillebrettet (kan utelates)
1. Spillet er vunnet dersom slangen fyller alle ledige ruter på brettet

For det første punktet kan det være greit å holde på en variabel som sier om slangen er i live. Denne variabelen kan vi sjekke før vi oppdaterer posisjoner i `_update()` og også for å se om vi skal skrive ut poengsummen i `_draw()`.

For punkt 2 kan vi utvide `checkcollision()` til å også sjekke om posisjonen til hodet er den samme som et av halesegmentene. Bruk gjerne samme logikk for å sjekke om en rute er tom som i `spawnfood()`.

Punkt 3 er ikke nødvendig, men om du velger å implementere denne mekanismen kan det også gjøres i `checkcollision()`

Punkt 4 er lett å implementere der slangen vokser, men det kan være vanskelig å teste om det er implementert riktig med mindre man er veldig god i snake...

![oppgave 2.6](oppgave2_6.gif)

<details>
<summary>Løsningsforslag del 6</summary>

~~~lua
--init
cellsize = 4
boardsize = 128 / cellsize
ignorebounds = true

function _init()
	t = 0	
	x = boardsize / 2
	y = boardsize / 2
	dirx = 1
	diry = 0
	movingx = dirx
	movingy = diry
	tail = {}
	length = 3
    spawnfood()
    -- vi setter alive til true fra starten
	alive = true
end


-->8
--update
function checkinput()
	if btn(⬆️) and movingy != 1 then
		diry = -1
		dirx = 0
	elseif btn(⬇️) and movingy != -1 then
		diry = 1
		dirx = 0
	elseif btn(⬅️) and movingx != 1 then
		dirx = -1
		diry = 0
	elseif btn(➡️) and movingx != -1 then
		dirx = 1
		diry = 0
	end
end		

function move()
	add(tail, {x = x, y = y})
	while #tail > length do
		del(tail, tail[1])
	end

	x += dirx
    y += diry
    -- bare wrappe rundt dersom vi har ignorebounds = true
	if ignorebounds then
		x %= boardsize
		y %= boardsize
	end
	
	movingx = dirx
	movingy = diry
end

function checkcollision()
	if x == foodx and y == foody then
		length += 3
		spawnfood()
    end
    -- hvis hodet treffer halen er vi ikke i live
	if isontail(x,y) then
		alive = false
	end
end

function checkbounds()
    -- hvis slangen er utenfor brettet er vi ikke i live
	if x < 0 or x >= boardsize or
		y < 0 or y >= boardsize then
		alive = false
	end
end

function spawnfood()
    foodx = flr(rnd(boardsize))
    foody = flr(rnd(boardsize))
    while not isempty(foodx,foody) do
        foodx = flr(rnd(boardsize))
        foody = flr(rnd(boardsize))
    end
end

-- vi skilte ut dette til en egen funksjon så funksjonaliteten kan 
-- gjenbrukes mellom checkcollision og spawnfood
function isontail(cellx, celly)
	for segment in all(tail) do
        if segment.x == cellx and segment.y == celly then
            return true
        end
    end
    return false
end

function isempty(cellx, celly)
	if cellx == x and celly == y then
		return false
	end
	return not isontail(cellx, celly)
end
	

function _update()
    t += 1
    -- hvis vi ikke er i live vil et trykk på X starte spillet på nytt
	if not alive and btnp(❎) then
		_init()
		return
	end

	checkinput()
	if t % cellsize != 0 then 
		return
	end
	checkcollision()
	checkbounds()
    -- ikke oppdatere posisjon hvis vi ikke er i live:
	if alive then
        move()
	end
end	

-->8
--draw

function drawhead()
	drawsegment(x, y, 8)
end

function drawtail()
	for segment in all(tail) do
		drawsegment(segment.x, segment.y, 11)
	end
end

function drawfood()
	drawsegment(foodx, foody, 9)
end

function drawsegment(x, y, color)
	rectfill(x * cellsize, 
		y * cellsize,
		(x + 1) * cellsize - 1, 
		(y + 1) * cellsize - 1, 
		color)
end

function _draw()
	cls(7)
	drawtail()
	drawhead()
    drawfood()
    -- skriv ut poengsum hvis vi ikke er i live:
	if not alive then
		cursor(40,50)
		color(0)
		print("  game over")
		print("  score: "..(length / 3) - 1)
		print("❎ to restart")
	end
end
~~~

</details>

## Del 7 - grafikk

Her er det fritt frem: Gjør spillet til ditt eget! Lek med farger og former, ta gjerne i bruk sprites. API-funksjonen `spr(spriteid,x,y)` er i så måte veldig nyttig.

## Del 8 - lyd

Åpne lydeditoren og lag en lydeffekt. Spill av denne hver gang slangen spiser en matbit. Lag gjerne også et fengende soundtrack, eller lån et av soundtrackene David Fredman har laget for oss!

## Del 9 - ekstra spillmekanismer?

Har du ideer til nye mekanismer som kan gjøre spillet mer spennende? En mulighet er for eksempel å ta i bruk map editoren i pico-8 og lage forskjellige brett med ulike hindringer og bonuser.