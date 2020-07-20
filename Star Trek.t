%Variables
var chars : array char of boolean
var x, y, click, coverpic, titlefont, clickfont, smallfont, impdirection, imppower, torpdirection, photonx, photony, positionx, positiony, starbasex, starbasey, deathexplosionx, deathexplosiony : int
var phaserexplosionx, phaserexplosiony, klingonchoice, shipdetectx, shipdetecty, shipdetectxo, shipdetectyo, klingondirection, kshiphit, shieldsrecovered, healthrecovered, powerrecovered : int
var deathpic : int
var daysleft : int := 420
var shipcondition : string := "GREEN"
var hullintegrity, shields : int := 100
var sector : int := 5
var sectorstars : array 1 .. 10 of int
var seck, seckleft : array 1 .. 9 of int
var klingonsleft : int := 20
var klingonx, klingony : array 1 .. 37 of int
var klingonhealth : array 1 .. 36 of int
var photoncolor, phasercolor : int := 1
var photonsize, phasersize : int := 8
var power : int := 10000
var starbasepower : int := 3000
var starbaseshields : int := 100
var starbaserepair : int := 50
var phaserpower : int := 0
var stars : array 0 .. 18, 0 .. 18 of int
var map : array 0 .. 10, 0 .. 10 of int
var trueorfalse, shipdetect, impulse, warpengine, torpedo, torpedohitk, torpedohits, phaser, shiphit : boolean := false
var klingondead : array 1 .. 36 of boolean

%Grid x-coordinates
map (1, 0) := 95
map (2, 0) := 120
map (3, 0) := 145
map (4, 0) := 170
map (5, 0) := 195
map (6, 0) := 220
map (7, 0) := 245
map (8, 0) := 270
map (9, 0) := 295
map (10, 0) := 700

%Grid y-coordinates
map (0, 1) := 355
map (0, 2) := 335
map (0, 3) := 315
map (0, 4) := 295
map (0, 5) := 275
map (0, 6) := 255
map (0, 7) := 235
map (0, 8) := 215
map (0, 9) := 195
map (0, 10) := 700

%Klingons in each Sector, reroll until they all add up to 20
loop
    seck (1) := Rand.Int (0, 4)
    seck (2) := Rand.Int (0, 4)
    seck (3) := Rand.Int (0, 4)
    seck (4) := Rand.Int (0, 4)
    seck (5) := Rand.Int (0, 4)
    seck (6) := Rand.Int (0, 4)
    seck (7) := Rand.Int (0, 4)
    seck (8) := Rand.Int (0, 4)
    seck (9) := Rand.Int (0, 4)
    exit when seck (1) + seck (2) + seck (3) + seck (4) + seck (5) + seck (6) + seck (7) + seck (8) + seck (9) = 20
end loop

%Klingons in each sector, they change when a klingon is destroyed
seckleft (1) := seck (1)
seckleft (2) := seck (2)
seckleft (3) := seck (3)
seckleft (4) := seck (4)
seckleft (5) := seck (5)
seckleft (6) := seck (6)
seckleft (7) := seck (7)
seckleft (8) := seck (8)
seckleft (9) := seck (9)

%Amount of Stars in each Sector, reroll until they all add up to 10
loop
    sectorstars (1) := Rand.Int (0, 2)
    sectorstars (2) := Rand.Int (0, 2)
    sectorstars (3) := Rand.Int (0, 2)
    sectorstars (4) := Rand.Int (0, 2)
    sectorstars (5) := Rand.Int (0, 2)
    sectorstars (6) := Rand.Int (0, 2)
    sectorstars (7) := Rand.Int (0, 2)
    sectorstars (8) := Rand.Int (0, 2)
    sectorstars (9) := Rand.Int (0, 2)
    exit when sectorstars (1) + sectorstars (2) + sectorstars (3) + sectorstars (4) + sectorstars (5) + sectorstars (6) + sectorstars (7) + sectorstars (8) + sectorstars (9) = 10
end loop

%Posiions, reroll until they don't = each other
loop
    %Enterprise position
    positionx := Rand.Int (1, 8)
    positiony := Rand.Int (1, 8)

    %Starbase position
    starbasex := Rand.Int (1, 8)
    starbasey := Rand.Int (1, 8)
    exit when positionx not= starbasex and positiony not= starbasey
end loop

%Picks a random number for x and y for each of the 10 stars
procedure starcoordinates ()

    %X-coordinates on grid
    stars (1, 0) := Rand.Int (1, 8)
    stars (2, 0) := Rand.Int (1, 8)
    stars (3, 0) := Rand.Int (1, 8)
    stars (4, 0) := Rand.Int (1, 8)
    stars (5, 0) := Rand.Int (1, 8)
    stars (6, 0) := Rand.Int (1, 8)
    stars (7, 0) := Rand.Int (1, 8)
    stars (8, 0) := Rand.Int (1, 8)
    stars (9, 0) := Rand.Int (1, 8)
    stars (10, 0) := Rand.Int (1, 8)
    stars (11, 0) := Rand.Int (1, 8)
    stars (12, 0) := Rand.Int (1, 8)
    stars (13, 0) := Rand.Int (1, 8)
    stars (14, 0) := Rand.Int (1, 8)
    stars (15, 0) := Rand.Int (1, 8)
    stars (16, 0) := Rand.Int (1, 8)
    stars (17, 0) := Rand.Int (1, 8)
    stars (18, 0) := Rand.Int (1, 8)

    %Y-coordinates on grid
    stars (0, 1) := Rand.Int (1, 8)
    stars (0, 2) := Rand.Int (1, 8)
    stars (0, 3) := Rand.Int (1, 8)
    stars (0, 4) := Rand.Int (1, 8)
    stars (0, 5) := Rand.Int (1, 8)
    stars (0, 6) := Rand.Int (1, 8)
    stars (0, 7) := Rand.Int (1, 8)
    stars (0, 8) := Rand.Int (1, 8)
    stars (0, 9) := Rand.Int (1, 8)
    stars (0, 10) := Rand.Int (1, 8)
    stars (0, 11) := Rand.Int (1, 8)
    stars (0, 12) := Rand.Int (1, 8)
    stars (0, 13) := Rand.Int (1, 8)
    stars (0, 14) := Rand.Int (1, 8)
    stars (0, 15) := Rand.Int (1, 8)
    stars (0, 16) := Rand.Int (1, 8)
    stars (0, 17) := Rand.Int (1, 8)
    stars (0, 18) := Rand.Int (1, 8)
end starcoordinates

%Making sure stars don't overlap each other or Enterprise or Starbase
starcoordinates
if stars (1, 0) = stars (2, 0) and stars (0, 1) = stars (0, 2) then
    starcoordinates
end if
if stars (3, 0) = stars (4, 0) and stars (0, 4) = stars (0, 3) then
    starcoordinates
end if
if stars (5, 0) = stars (6, 0) and stars (0, 5) = stars (0, 6) then
    starcoordinates
end if
if stars (7, 0) = stars (8, 0) and stars (0, 7) = stars (0, 8) then
    starcoordinates
end if
if stars (9, 0) = stars (10, 0) and stars (0, 9) = stars (0, 10) then
    starcoordinates
end if
if stars (9, 0) = positionx and stars (0, 9) = positiony then
    starcoordinates
end if
if stars (10, 0) = positionx and stars (0, 10) = positiony then
    starcoordinates
end if
if stars (9, 0) = starbasex and stars (0, 9) = starbasey then
    starcoordinates
end if
if stars (10, 0) = starbasex and stars (0, 10) = starbasey then
    starcoordinates
end if
if stars (11, 0) = stars (12, 0) and stars (0, 11) = stars (0, 12) then
    starcoordinates
end if
if stars (13, 0) = stars (14, 0) and stars (0, 13) = stars (0, 14) then
    starcoordinates
end if
if stars (15, 0) = stars (16, 0) and stars (0, 15) = stars (0, 16) then
    starcoordinates
end if
if stars (17, 0) = stars (18, 0) and stars (0, 17) = stars (0, 18) then
    starcoordinates
end if

%Picks random x and y coordinates for each klingon
procedure klingoncoordinates ()

    %X-Coordinates
    klingonx (1) := Rand.Int (1, 8)
    klingonx (2) := Rand.Int (1, 8)
    klingonx (3) := Rand.Int (1, 8)
    klingonx (4) := Rand.Int (1, 8)
    klingonx (5) := Rand.Int (1, 8)
    klingonx (6) := Rand.Int (1, 8)
    klingonx (7) := Rand.Int (1, 8)
    klingonx (8) := Rand.Int (1, 8)
    klingonx (9) := Rand.Int (1, 8)
    klingonx (10) := Rand.Int (1, 8)
    klingonx (11) := Rand.Int (1, 8)
    klingonx (12) := Rand.Int (1, 8)
    klingonx (13) := Rand.Int (1, 8)
    klingonx (14) := Rand.Int (1, 8)
    klingonx (15) := Rand.Int (1, 8)
    klingonx (16) := Rand.Int (1, 8)
    klingonx (17) := Rand.Int (1, 8)
    klingonx (18) := Rand.Int (1, 8)
    klingonx (19) := Rand.Int (1, 8)
    klingonx (20) := Rand.Int (1, 8)
    klingonx (21) := Rand.Int (1, 8)
    klingonx (22) := Rand.Int (1, 8)
    klingonx (23) := Rand.Int (1, 8)
    klingonx (24) := Rand.Int (1, 8)
    klingonx (25) := Rand.Int (1, 8)
    klingonx (26) := Rand.Int (1, 8)
    klingonx (27) := Rand.Int (1, 8)
    klingonx (28) := Rand.Int (1, 8)
    klingonx (29) := Rand.Int (1, 8)
    klingonx (30) := Rand.Int (1, 8)
    klingonx (31) := Rand.Int (1, 8)
    klingonx (32) := Rand.Int (1, 8)
    klingonx (33) := Rand.Int (1, 8)
    klingonx (34) := Rand.Int (1, 8)
    klingonx (35) := Rand.Int (1, 8)
    klingonx (36) := Rand.Int (1, 8)
    klingonx (37) := 10

    %Y-coordinates
    klingony (1) := Rand.Int (1, 8)
    klingony (2) := Rand.Int (1, 8)
    klingony (3) := Rand.Int (1, 8)
    klingony (4) := Rand.Int (1, 8)
    klingony (5) := Rand.Int (1, 8)
    klingony (6) := Rand.Int (1, 8)
    klingony (7) := Rand.Int (1, 8)
    klingony (8) := Rand.Int (1, 8)
    klingony (9) := Rand.Int (1, 8)
    klingony (10) := Rand.Int (1, 8)
    klingony (11) := Rand.Int (1, 8)
    klingony (12) := Rand.Int (1, 8)
    klingony (13) := Rand.Int (1, 8)
    klingony (14) := Rand.Int (1, 8)
    klingony (15) := Rand.Int (1, 8)
    klingony (16) := Rand.Int (1, 8)
    klingony (17) := Rand.Int (1, 8)
    klingony (18) := Rand.Int (1, 8)
    klingony (19) := Rand.Int (1, 8)
    klingony (20) := Rand.Int (1, 8)
    klingony (21) := Rand.Int (1, 8)
    klingony (22) := Rand.Int (1, 8)
    klingony (23) := Rand.Int (1, 8)
    klingony (24) := Rand.Int (1, 8)
    klingony (25) := Rand.Int (1, 8)
    klingony (26) := Rand.Int (1, 8)
    klingony (27) := Rand.Int (1, 8)
    klingony (28) := Rand.Int (1, 8)
    klingony (29) := Rand.Int (1, 8)
    klingony (30) := Rand.Int (1, 8)
    klingony (31) := Rand.Int (1, 8)
    klingony (32) := Rand.Int (1, 8)
    klingony (33) := Rand.Int (1, 8)
    klingony (34) := Rand.Int (1, 8)
    klingony (35) := Rand.Int (1, 8)
    klingony (36) := Rand.Int (1, 8)
    klingony (37) := 10
end klingoncoordinates

%Making sure Klingons don't overlap with each other or Enterprise or Starbase, do starcoodinates again if they do overlap
klingoncoordinates

if (klingonx (1) = klingonx (2) and klingony (1) = klingony (2)) or (klingonx (1) = klingonx (3) and klingony (1) = klingony (3)) or (klingonx (1) = klingonx (4) and klingony (1) = klingony (4)) then
    klingoncoordinates
end if
if (klingonx (2) = klingonx (3) and klingony (2) = klingony (3)) or (klingonx (2) = klingonx (4) and klingony (2) = klingony (4)) or (klingonx (3) = klingonx (4) and klingony (3) = klingony (4)) then
    klingoncoordinates
end if

if (klingonx (5) = klingonx (6) and klingony (5) = klingony (6)) or (klingonx (5) = klingonx (7) and klingony (5) = klingony (7)) or (klingonx (5) = klingonx (8) and klingony (5) = klingony (8)) then
    klingoncoordinates
end if
if (klingonx (6) = klingonx (7) and klingony (6) = klingony (7)) or (klingonx (6) = klingonx (8) and klingony (6) = klingony (8)) or (klingonx (7) = klingonx (8) and klingony (7) = klingony (8)) then
    klingoncoordinates
end if

if (klingonx (9) = klingonx (10) and klingony (9) = klingony (10)) or (klingonx (9) = klingonx (11) and klingony (9) = klingony (11)) then
    klingoncoordinates
end if
if (klingonx (9) = klingonx (12) and klingony (9) = klingony (12)) or (klingonx (9) = klingonx (13) and klingony (9) = klingony (13)) then
    klingoncoordinates
end if
if (klingonx (10) = klingonx (11) and klingony (10) = klingony (11)) or (klingonx (11) = klingonx (12) and klingony (11) = klingony (12)) then
    klingoncoordinates
end if

if (klingonx (13) = klingonx (14) and klingony (13) = klingony (14)) or (klingonx (13) = klingonx (15) and klingony (13) = klingony (15)) then
    klingoncoordinates
end if
if (klingonx (13) = klingonx (16) and klingony (13) = klingony (16)) or (klingonx (14) = klingonx (15) and klingony (14) = klingony (15)) then
    klingoncoordinates
end if
if (klingonx (14) = klingonx (16) and klingony (14) = klingony (16)) or (klingonx (15) = klingonx (16) and klingony (15) = klingony (16)) then
    klingoncoordinates
end if

if (klingonx (17) = klingonx (18) and klingony (17) = klingony (18)) or (klingonx (17) = klingonx (19) and klingony (17) = klingony (19)) then
    klingoncoordinates
end if
if (klingonx (17) = klingonx (20) and klingony (17) = klingony (20)) or (klingonx (18) = klingonx (19) and klingony (18) = klingony (19)) then
    klingoncoordinates
end if
if (klingonx (18) = klingonx (20) and klingony (18) = klingony (20)) or (klingonx (19) = klingonx (20) and klingony (19) = klingony (20)) then
    klingoncoordinates
end if

%Avoiding Enterprise/Starbase in sector 5
if (klingonx (17) = positionx and klingony (17) = positiony) or (klingonx (18) = positionx and klingony (18) = positiony) then
    klingoncoordinates
end if
if (klingonx (19) = positionx and klingony (19) = positiony) or (klingonx (20) = positionx and klingony (20) = positiony) then
    klingoncoordinates
end if
if (klingonx (17) = starbasex and klingony (17) = starbasey) or (klingonx (18) = starbasex and klingony (18) = starbasey) then
    klingoncoordinates
end if
if (klingonx (19) = starbasex and klingony (19) = starbasey) or (klingonx (20) = starbasex and klingony (20) = starbasey) then
    klingoncoordinates
end if

%Resuming klingons don't impact each other
if (klingonx (21) = klingonx (22) and klingony (21) = klingony (22)) or (klingonx (21) = klingonx (23) and klingony (21) = klingony (23)) then
    klingoncoordinates
end if
if (klingonx (21) = klingonx (24) and klingony (21) = klingony (24)) or (klingonx (22) = klingonx (23) and klingony (22) = klingony (23)) then
    klingoncoordinates
end if
if (klingonx (22) = klingonx (24) and klingony (22) = klingony (24)) or (klingonx (23) = klingonx (24) and klingony (23) = klingony (24)) then
    klingoncoordinates
end if

if (klingonx (25) = klingonx (26) and klingony (25) = klingony (26)) or (klingonx (25) = klingonx (27) and klingony (25) = klingony (27)) then
    klingoncoordinates
end if
if (klingonx (25) = klingonx (28) and klingony (25) = klingony (28)) or (klingonx (26) = klingonx (27) and klingony (26) = klingony (27)) then
    klingoncoordinates
end if
if (klingonx (26) = klingonx (28) and klingony (26) = klingony (28)) or (klingonx (27) = klingonx (28) and klingony (27) = klingony (28)) then
    klingoncoordinates
end if

if (klingonx (29) = klingonx (30) and klingony (29) = klingony (30)) or (klingonx (29) = klingonx (31) and klingony (29) = klingony (31)) then
    klingoncoordinates
end if
if (klingonx (29) = klingonx (32) and klingony (29) = klingony (32)) or (klingonx (30) = klingonx (31) and klingony (30) = klingony (31)) then
    klingoncoordinates
end if
if (klingonx (30) = klingonx (32) and klingony (30) = klingony (32)) or (klingonx (31) = klingonx (32) and klingony (31) = klingony (32)) then
    klingoncoordinates
end if

if (klingonx (33) = klingonx (34) and klingony (33) = klingony (34)) or (klingonx (33) = klingonx (35) and klingony (33) = klingony (35)) then
    klingoncoordinates
end if
if (klingonx (33) = klingonx (36) and klingony (33) = klingony (36)) or (klingonx (34) = klingonx (35) and klingony (34) = klingony (35)) then
    klingoncoordinates
end if
if (klingonx (34) = klingonx (36) and klingony (34) = klingony (36)) or (klingonx (35) = klingonx (36) and klingony (35) = klingony (36)) then
    klingoncoordinates
end if

%Making sure Klingons and Stars don't overlap, do klingoncoodinates again if they do overlap
if (klingonx (1) = stars (1, 0) and klingony (1) = stars (0, 1)) or (klingonx (1) = stars (2, 0) and klingony (1) = stars (0, 2)) then
    klingoncoordinates
elsif (klingonx (2) = stars (1, 0) and klingony (2) = stars (0, 1)) or (klingonx (2) = stars (2, 0) and klingony (2) = stars (0, 2)) then
    klingoncoordinates
elsif (klingonx (3) = stars (1, 0) and klingony (3) = stars (0, 1)) or (klingonx (3) = stars (2, 0) and klingony (3) = stars (0, 2)) then
    klingoncoordinates
elsif (klingonx (4) = stars (1, 0) and klingony (4) = stars (0, 1)) or (klingonx (4) = stars (2, 0) and klingony (4) = stars (0, 2)) then
    klingoncoordinates
end if

if (klingonx (5) = stars (3, 0) and klingony (5) = stars (0, 3)) or (klingonx (5) = stars (4, 0) and klingony (5) = stars (0, 4)) then
    klingoncoordinates
elsif (klingonx (6) = stars (3, 0) and klingony (6) = stars (0, 3)) or (klingonx (6) = stars (4, 0) and klingony (6) = stars (0, 4)) then
    klingoncoordinates
elsif (klingonx (7) = stars (3, 0) and klingony (7) = stars (0, 3)) or (klingonx (7) = stars (4, 0) and klingony (7) = stars (0, 4)) then
    klingoncoordinates
elsif (klingonx (8) = stars (3, 0) and klingony (8) = stars (0, 3)) or (klingonx (8) = stars (4, 0) and klingony (8) = stars (0, 4)) then
    klingoncoordinates
end if

if (klingonx (9) = stars (5, 0) and klingony (9) = stars (0, 5)) or (klingonx (9) = stars (6, 0) and klingony (9) = stars (0, 6)) then
    klingoncoordinates
elsif (klingonx (10) = stars (5, 0) and klingony (10) = stars (0, 5)) or (klingonx (10) = stars (6, 0) and klingony (10) = stars (0, 6)) then
    klingoncoordinates
elsif (klingonx (11) = stars (5, 0) and klingony (11) = stars (0, 5)) or (klingonx (11) = stars (6, 0) and klingony (11) = stars (0, 6)) then
    klingoncoordinates
elsif (klingonx (12) = stars (5, 0) and klingony (12) = stars (0, 5)) or (klingonx (12) = stars (6, 0) and klingony (12) = stars (0, 6)) then
    klingoncoordinates
end if

if (klingonx (13) = stars (7, 0) and klingony (13) = stars (0, 7)) or (klingonx (13) = stars (8, 0) and klingony (13) = stars (0, 8)) then
    klingoncoordinates
elsif (klingonx (14) = stars (7, 0) and klingony (14) = stars (0, 7)) or (klingonx (14) = stars (8, 0) and klingony (14) = stars (0, 8)) then
    klingoncoordinates
elsif (klingonx (15) = stars (7, 0) and klingony (15) = stars (0, 7)) or (klingonx (15) = stars (8, 0) and klingony (15) = stars (0, 8)) then
    klingoncoordinates
elsif (klingonx (16) = stars (7, 0) and klingony (16) = stars (0, 7)) or (klingonx (16) = stars (8, 0) and klingony (16) = stars (0, 8)) then
    klingoncoordinates
end if

if (klingonx (17) = stars (9, 0) and klingony (17) = stars (0, 9)) or (klingonx (17) = stars (10, 0) and klingony (17) = stars (0, 10)) then
    klingoncoordinates
elsif (klingonx (18) = stars (9, 0) and klingony (18) = stars (0, 9)) or (klingonx (18) = stars (10, 0) and klingony (18) = stars (0, 10)) then
    klingoncoordinates
elsif (klingonx (19) = stars (9, 0) and klingony (19) = stars (0, 9)) or (klingonx (19) = stars (10, 0) and klingony (19) = stars (0, 10)) then
    klingoncoordinates
elsif (klingonx (20) = stars (9, 0) and klingony (20) = stars (0, 9)) or (klingonx (20) = stars (10, 0) and klingony (20) = stars (0, 10)) then
    klingoncoordinates
end if

if (klingonx (21) = stars (11, 0) and klingony (21) = stars (0, 11)) or (klingonx (21) = stars (12, 0) and klingony (21) = stars (0, 12)) then
    klingoncoordinates
elsif (klingonx (22) = stars (11, 0) and klingony (22) = stars (0, 11)) or (klingonx (22) = stars (12, 0) and klingony (22) = stars (0, 12)) then
    klingoncoordinates
elsif (klingonx (23) = stars (11, 0) and klingony (23) = stars (0, 11)) or (klingonx (23) = stars (12, 0) and klingony (23) = stars (0, 12)) then
    klingoncoordinates
elsif (klingonx (24) = stars (11, 0) and klingony (24) = stars (0, 11)) or (klingonx (24) = stars (12, 0) and klingony (24) = stars (0, 12)) then
    klingoncoordinates
end if

if (klingonx (25) = stars (13, 0) and klingony (25) = stars (0, 13)) or (klingonx (25) = stars (14, 0) and klingony (25) = stars (0, 14)) then
    klingoncoordinates
elsif (klingonx (26) = stars (13, 0) and klingony (26) = stars (0, 13)) or (klingonx (26) = stars (14, 0) and klingony (26) = stars (0, 14)) then
    klingoncoordinates
elsif (klingonx (27) = stars (13, 0) and klingony (27) = stars (0, 13)) or (klingonx (27) = stars (14, 0) and klingony (27) = stars (0, 14)) then
    klingoncoordinates
elsif (klingonx (28) = stars (13, 0) and klingony (28) = stars (0, 13)) or (klingonx (28) = stars (14, 0) and klingony (28) = stars (0, 14)) then
    klingoncoordinates
end if

if (klingonx (29) = stars (15, 0) and klingony (29) = stars (0, 15)) or (klingonx (29) = stars (16, 0) and klingony (29) = stars (0, 16)) then
    klingoncoordinates
elsif (klingonx (30) = stars (15, 0) and klingony (30) = stars (0, 15)) or (klingonx (30) = stars (16, 0) and klingony (30) = stars (0, 16)) then
    klingoncoordinates
elsif (klingonx (31) = stars (15, 0) and klingony (31) = stars (0, 15)) or (klingonx (31) = stars (16, 0) and klingony (31) = stars (0, 16)) then
    klingoncoordinates
elsif (klingonx (32) = stars (15, 0) and klingony (32) = stars (0, 15)) or (klingonx (32) = stars (16, 0) and klingony (32) = stars (0, 16)) then
    klingoncoordinates
end if

if (klingonx (33) = stars (17, 0) and klingony (33) = stars (0, 17)) or (klingonx (33) = stars (18, 0) and klingony (33) = stars (0, 18)) then
    klingoncoordinates
elsif (klingonx (34) = stars (17, 0) and klingony (34) = stars (0, 17)) or (klingonx (34) = stars (18, 0) and klingony (34) = stars (0, 18)) then
    klingoncoordinates
elsif (klingonx (35) = stars (17, 0) and klingony (35) = stars (0, 17)) or (klingonx (35) = stars (18, 0) and klingony (35) = stars (0, 18)) then
    klingoncoordinates
elsif (klingonx (36) = stars (17, 0) and klingony (36) = stars (0, 17)) or (klingonx (36) = stars (18, 0) and klingony (36) = stars (0, 18)) then
    klingoncoordinates
end if

%Klingon Health, if Klingon is present, health = 1000, if not, health = 1200
if seck (1) = 1 then
    klingonhealth (1) := 1000
    klingonhealth (2) := 1200
    klingonhealth (3) := 1200
    klingonhealth (4) := 1200
elsif seck (1) = 2 then
    klingonhealth (1) := 1000
    klingonhealth (2) := 1000
    klingonhealth (3) := 1200
    klingonhealth (4) := 1200
elsif seck (1) = 3 then
    klingonhealth (1) := 1000
    klingonhealth (2) := 1000
    klingonhealth (3) := 1000
    klingonhealth (4) := 1200
elsif seck (1) = 4 then
    klingonhealth (1) := 1000
    klingonhealth (2) := 1000
    klingonhealth (3) := 1000
    klingonhealth (4) := 1000
elsif seck (1) = 0 then
    klingonhealth (1) := 1200
    klingonhealth (2) := 1200
    klingonhealth (3) := 1200
    klingonhealth (4) := 1200
end if
if seck (2) = 1 then
    klingonhealth (5) := 1000
    klingonhealth (6) := 1200
    klingonhealth (7) := 1200
    klingonhealth (8) := 1200
elsif seck (2) = 2 then
    klingonhealth (5) := 1000
    klingonhealth (6) := 1000
    klingonhealth (7) := 1200
    klingonhealth (8) := 1200
elsif seck (2) = 3 then
    klingonhealth (5) := 1000
    klingonhealth (6) := 1000
    klingonhealth (7) := 1000
    klingonhealth (8) := 1200
elsif seck (2) = 4 then
    klingonhealth (5) := 1000
    klingonhealth (6) := 1000
    klingonhealth (7) := 1000
    klingonhealth (8) := 1000
elsif seck (2) = 0 then
    klingonhealth (5) := 1200
    klingonhealth (6) := 1200
    klingonhealth (7) := 1200
    klingonhealth (8) := 1200
end if
if seck (3) = 1 then
    klingonhealth (9) := 1000
    klingonhealth (10) := 1200
    klingonhealth (11) := 1200
    klingonhealth (12) := 1200
elsif seck (3) = 2 then
    klingonhealth (9) := 1000
    klingonhealth (10) := 1000
    klingonhealth (11) := 1200
    klingonhealth (12) := 1200
elsif seck (3) = 3 then
    klingonhealth (9) := 1000
    klingonhealth (10) := 1000
    klingonhealth (11) := 1000
    klingonhealth (12) := 1200
elsif seck (3) = 4 then
    klingonhealth (9) := 1000
    klingonhealth (10) := 1000
    klingonhealth (11) := 1000
    klingonhealth (12) := 1000
elsif seck (3) = 0 then
    klingonhealth (9) := 1200
    klingonhealth (10) := 1200
    klingonhealth (11) := 1200
    klingonhealth (12) := 1200
end if
if seck (4) = 1 then
    klingonhealth (13) := 1000
    klingonhealth (14) := 1200
    klingonhealth (15) := 1200
    klingonhealth (16) := 1200
elsif seck (4) = 2 then
    klingonhealth (13) := 1000
    klingonhealth (14) := 1000
    klingonhealth (15) := 1200
    klingonhealth (16) := 1200
elsif seck (4) = 3 then
    klingonhealth (13) := 1000
    klingonhealth (14) := 1000
    klingonhealth (15) := 1000
    klingonhealth (16) := 1200
elsif seck (4) = 4 then
    klingonhealth (13) := 1000
    klingonhealth (14) := 1000
    klingonhealth (15) := 1000
    klingonhealth (16) := 1000
elsif seck (4) = 0 then
    klingonhealth (13) := 1200
    klingonhealth (14) := 1200
    klingonhealth (15) := 1200
    klingonhealth (16) := 1200
end if
if seck (5) = 1 then
    klingonhealth (17) := 1000
    klingonhealth (18) := 1200
    klingonhealth (19) := 1200
    klingonhealth (20) := 1200
elsif seck (5) = 2 then
    klingonhealth (17) := 1000
    klingonhealth (18) := 1000
    klingonhealth (19) := 1200
    klingonhealth (20) := 1200
elsif seck (5) = 3 then
    klingonhealth (17) := 1000
    klingonhealth (18) := 1000
    klingonhealth (19) := 1000
    klingonhealth (20) := 1200
elsif seck (5) = 4 then
    klingonhealth (17) := 1000
    klingonhealth (18) := 1000
    klingonhealth (19) := 1000
    klingonhealth (20) := 1000
elsif seck (5) = 0 then
    klingonhealth (17) := 1200
    klingonhealth (18) := 1200
    klingonhealth (19) := 1200
    klingonhealth (20) := 1200
end if
if seck (6) = 1 then
    klingonhealth (21) := 1000
    klingonhealth (22) := 1200
    klingonhealth (23) := 1200
    klingonhealth (24) := 1200
elsif seck (6) = 2 then
    klingonhealth (21) := 1000
    klingonhealth (22) := 1000
    klingonhealth (23) := 1200
    klingonhealth (24) := 1200
elsif seck (6) = 3 then
    klingonhealth (21) := 1000
    klingonhealth (22) := 1000
    klingonhealth (23) := 1000
    klingonhealth (24) := 1200
elsif seck (6) = 4 then
    klingonhealth (21) := 1000
    klingonhealth (22) := 1000
    klingonhealth (23) := 1000
    klingonhealth (24) := 1000
elsif seck (6) = 0 then
    klingonhealth (21) := 1200
    klingonhealth (22) := 1200
    klingonhealth (23) := 1200
    klingonhealth (24) := 1200
end if
if seck (7) = 1 then
    klingonhealth (25) := 1000
    klingonhealth (26) := 1200
    klingonhealth (27) := 1200
    klingonhealth (28) := 1200
elsif seck (7) = 2 then
    klingonhealth (25) := 1000
    klingonhealth (26) := 1000
    klingonhealth (27) := 1200
    klingonhealth (28) := 1200
elsif seck (7) = 3 then
    klingonhealth (25) := 1000
    klingonhealth (26) := 1000
    klingonhealth (27) := 1000
    klingonhealth (28) := 1200
elsif seck (7) = 4 then
    klingonhealth (25) := 1000
    klingonhealth (26) := 1000
    klingonhealth (27) := 1000
    klingonhealth (28) := 1000
elsif seck (7) = 0 then
    klingonhealth (25) := 1200
    klingonhealth (26) := 1200
    klingonhealth (27) := 1200
    klingonhealth (28) := 1200
end if
if seck (8) = 1 then
    klingonhealth (29) := 1000
    klingonhealth (30) := 1200
    klingonhealth (31) := 1200
    klingonhealth (32) := 1200
elsif seck (8) = 2 then
    klingonhealth (29) := 1000
    klingonhealth (30) := 1000
    klingonhealth (31) := 1200
    klingonhealth (32) := 1200
elsif seck (8) = 3 then
    klingonhealth (29) := 1000
    klingonhealth (30) := 1000
    klingonhealth (31) := 1000
    klingonhealth (32) := 1200
elsif seck (8) = 4 then
    klingonhealth (29) := 1000
    klingonhealth (30) := 1000
    klingonhealth (31) := 1000
    klingonhealth (32) := 1000
elsif seck (8) = 0 then
    klingonhealth (29) := 1200
    klingonhealth (30) := 1200
    klingonhealth (31) := 1200
    klingonhealth (32) := 1200
end if
if seck (9) = 1 then
    klingonhealth (33) := 1000
    klingonhealth (34) := 1200
    klingonhealth (35) := 1200
    klingonhealth (36) := 1200
elsif seck (9) = 2 then
    klingonhealth (33) := 1000
    klingonhealth (34) := 1000
    klingonhealth (35) := 1200
    klingonhealth (36) := 1200
elsif seck (9) = 3 then
    klingonhealth (33) := 1000
    klingonhealth (34) := 1000
    klingonhealth (35) := 1000
    klingonhealth (36) := 1200
elsif seck (9) = 4 then
    klingonhealth (33) := 1000
    klingonhealth (34) := 1000
    klingonhealth (35) := 1000
    klingonhealth (36) := 1000
elsif seck (9) = 0 then
    klingonhealth (33) := 1200
    klingonhealth (34) := 1200
    klingonhealth (35) := 1200
    klingonhealth (36) := 1200
end if

%Klingondead variables, setting the death condition
klingondead (1) := false
klingondead (2) := false
klingondead (3) := false
klingondead (4) := false
klingondead (5) := false
klingondead (6) := false
klingondead (7) := false
klingondead (8) := false
klingondead (9) := false
klingondead (10) := false
klingondead (11) := false
klingondead (12) := false
klingondead (13) := false
klingondead (14) := false
klingondead (15) := false
klingondead (16) := false
klingondead (17) := false
klingondead (18) := false
klingondead (19) := false
klingondead (20) := false
klingondead (21) := false
klingondead (22) := false
klingondead (23) := false
klingondead (24) := false
klingondead (25) := false
klingondead (26) := false
klingondead (27) := false
klingondead (28) := false
klingondead (29) := false
klingondead (30) := false
klingondead (31) := false
klingondead (32) := false
klingondead (33) := false
klingondead (34) := false
klingondead (35) := false
klingondead (36) := false

%Font Variables
titlefont := Font.New ("serif:36")
clickfont := Font.New ("serif:14")
smallfont := Font.New ("serif:10")

%Picture Variables
coverpic := Pic.FileNew ("Coverpage.jpg")
deathpic := Pic.FileNew ("Enterprisedead.jpg")

%Main Procedures

%Procedure that waits for the user's click
procedure waitforclick ()
    Draw.Text ("Click the Mouse!", maxx div 2 - 50, 20, clickfont, white)
    loop
	Mouse.Where (x, y, click)
	exit when click = 1
    end loop
end waitforclick

%Procedure that checks on the condition of the ship, if klingons are present, condition = red, if not, condition = green
procedure conditionp ()
    if sector = 1 then
	if seckleft (1) <= 0 then
	    shipcondition := "GREEN"
	else
	    shipcondition := "RED"
	end if
    elsif sector = 2 then
	if seckleft (2) <= 0 then
	    shipcondition := "GREEN"
	else
	    shipcondition := "RED"
	end if
    elsif sector = 3 then
	if seckleft (3) <= 0 then
	    shipcondition := "GREEN"
	else
	    shipcondition := "RED"
	end if
    elsif sector = 4 then
	if seckleft (4) <= 0 then
	    shipcondition := "GREEN"
	else
	    shipcondition := "RED"
	end if
    elsif sector = 5 then
	if seckleft (5) <= 0 then
	    shipcondition := "GREEN"
	else
	    shipcondition := "RED"
	end if
	if (positionx = starbasex) and (positiony = starbasey) then %If docked, condition = Docked
	    shipcondition := "Docked"
	end if
    elsif sector = 6 then
	if seckleft (6) <= 0 then
	    shipcondition := "GREEN"
	else
	    shipcondition := "RED"
	end if
    elsif sector = 7 then
	if seckleft (7) <= 0 then
	    shipcondition := "GREEN"
	else
	    shipcondition := "RED"
	end if
    elsif sector = 8 then
	if seckleft (8) <= 0 then
	    shipcondition := "GREEN"
	else
	    shipcondition := "RED"
	end if
    elsif sector = 9 then
	if seckleft (9) <= 0 then
	    shipcondition := "GREEN"
	else
	    shipcondition := "RED"
	end if
    end if
end conditionp

%UserInterface, draws the lines, grid dots, and some of the status bar
procedure userinterface ()
    Draw.Line (maxx div 2 + 50, 0, maxx div 2 + 50, maxy, white)
    Draw.Line (1, maxy div 2, maxx div 2 + 51, maxy div 2, white)
    Draw.Box (75, 200, 300, 375, white)

    %Grid numbers
    Draw.Text ("1", 95, 385, clickfont, white)
    Draw.Text ("2", 120, 385, clickfont, white)
    Draw.Text ("3", 145, 385, clickfont, white)
    Draw.Text ("4", 170, 385, clickfont, white)
    Draw.Text ("5", 195, 385, clickfont, white)
    Draw.Text ("6", 220, 385, clickfont, white)
    Draw.Text ("7", 245, 385, clickfont, white)
    Draw.Text ("8", 270, 385, clickfont, white)
    Draw.Text ("1", 60, 350, clickfont, white)
    Draw.Text ("2", 60, 330, clickfont, white)
    Draw.Text ("3", 60, 310, clickfont, white)
    Draw.Text ("4", 60, 290, clickfont, white)
    Draw.Text ("5", 60, 270, clickfont, white)
    Draw.Text ("6", 60, 250, clickfont, white)
    Draw.Text ("7", 60, 230, clickfont, white)
    Draw.Text ("8", 60, 210, clickfont, white)

    %Grid Dots
    Draw.FillOval (95, 355, 1, 1, white)
    Draw.FillOval (120, 355, 1, 1, white)
    Draw.FillOval (145, 355, 1, 1, white)
    Draw.FillOval (170, 355, 1, 1, white)
    Draw.FillOval (195, 355, 1, 1, white)
    Draw.FillOval (220, 355, 1, 1, white)
    Draw.FillOval (245, 355, 1, 1, white)
    Draw.FillOval (270, 355, 1, 1, white)
    Draw.FillOval (95, 335, 1, 1, white)
    Draw.FillOval (95, 315, 1, 1, white)
    Draw.FillOval (95, 295, 1, 1, white)
    Draw.FillOval (95, 275, 1, 1, white)
    Draw.FillOval (95, 255, 1, 1, white)
    Draw.FillOval (95, 235, 1, 1, white)
    Draw.FillOval (95, 215, 1, 1, white)
    Draw.FillOval (120, 335, 1, 1, white)
    Draw.FillOval (120, 315, 1, 1, white)
    Draw.FillOval (120, 295, 1, 1, white)
    Draw.FillOval (120, 275, 1, 1, white)
    Draw.FillOval (120, 255, 1, 1, white)
    Draw.FillOval (120, 235, 1, 1, white)
    Draw.FillOval (120, 215, 1, 1, white)
    Draw.FillOval (145, 335, 1, 1, white)
    Draw.FillOval (145, 315, 1, 1, white)
    Draw.FillOval (145, 295, 1, 1, white)
    Draw.FillOval (145, 275, 1, 1, white)
    Draw.FillOval (145, 255, 1, 1, white)
    Draw.FillOval (145, 235, 1, 1, white)
    Draw.FillOval (145, 215, 1, 1, white)
    Draw.FillOval (170, 335, 1, 1, white)
    Draw.FillOval (170, 315, 1, 1, white)
    Draw.FillOval (170, 295, 1, 1, white)
    Draw.FillOval (170, 275, 1, 1, white)
    Draw.FillOval (170, 255, 1, 1, white)
    Draw.FillOval (170, 235, 1, 1, white)
    Draw.FillOval (170, 215, 1, 1, white)
    Draw.FillOval (195, 335, 1, 1, white)
    Draw.FillOval (195, 315, 1, 1, white)
    Draw.FillOval (195, 295, 1, 1, white)
    Draw.FillOval (195, 275, 1, 1, white)
    Draw.FillOval (195, 255, 1, 1, white)
    Draw.FillOval (195, 235, 1, 1, white)
    Draw.FillOval (195, 215, 1, 1, white)
    Draw.FillOval (220, 335, 1, 1, white)
    Draw.FillOval (220, 315, 1, 1, white)
    Draw.FillOval (220, 295, 1, 1, white)
    Draw.FillOval (220, 275, 1, 1, white)
    Draw.FillOval (220, 255, 1, 1, white)
    Draw.FillOval (220, 235, 1, 1, white)
    Draw.FillOval (220, 215, 1, 1, white)
    Draw.FillOval (245, 335, 1, 1, white)
    Draw.FillOval (245, 315, 1, 1, white)
    Draw.FillOval (245, 295, 1, 1, white)
    Draw.FillOval (245, 275, 1, 1, white)
    Draw.FillOval (245, 255, 1, 1, white)
    Draw.FillOval (245, 235, 1, 1, white)
    Draw.FillOval (245, 215, 1, 1, white)
    Draw.FillOval (270, 335, 1, 1, white)
    Draw.FillOval (270, 315, 1, 1, white)
    Draw.FillOval (270, 295, 1, 1, white)
    Draw.FillOval (270, 275, 1, 1, white)
    Draw.FillOval (270, 255, 1, 1, white)
    Draw.FillOval (270, 235, 1, 1, white)
    Draw.FillOval (270, 215, 1, 1, white)

    %Information
    Draw.Text ("Days left:", 10, maxy div 2 - 20, clickfont, white)
    Draw.Text ("Condition:", 10, maxy div 2 - 45, clickfont, white)
    Draw.Text ("Hull Integrity:", 10, maxy div 2 - 70, clickfont, white)
    Draw.Text ("Shields:", 10, maxy div 2 - 95, clickfont, white)
    Draw.Text ("Sector:", 10, maxy div 2 - 120, clickfont, white)
    Draw.Text ("Klingons left:", 10, maxy div 2 - 145, clickfont, white)
    Draw.Text ("Power Left:", 10, maxy div 2 - 170, clickfont, white)
    Draw.Text ("'E' = Enterprise", 180, maxy div 2 - 20, smallfont, white)
    Draw.Text ("'K' = Klingon", 180, maxy div 2 - 40, smallfont, white)
    Draw.Text ("'*' = Star", 270, maxy div 2 - 20, smallfont, white)
    Draw.Text ("'S' = Starbase", 270, maxy div 2 - 40, smallfont, white)
end userinterface

%Used to check on conditions
procedure status ()
    conditionp
    Draw.Text (intstr (daysleft div 10), 90, maxy div 2 - 20, clickfont, white)
    if shipcondition = "RED" then
	Draw.Text (shipcondition, 90, maxy div 2 - 45, clickfont, red)
    else
	Draw.Text (shipcondition, 90, maxy div 2 - 45, clickfont, green)
    end if
    Draw.Text (intstr (hullintegrity), 120, maxy div 2 - 70, clickfont, white)
    Draw.Text (intstr (shields), 70, maxy div 2 - 95, clickfont, white)
    Draw.Text (intstr (sector), 70, maxy div 2 - 120, clickfont, white)
    Draw.Text (intstr (klingonsleft), 110, maxy div 2 - 145, clickfont, white)
    Draw.Text (intstr (power), 100, maxy div 2 - 170, clickfont, white)

    %Getting each Klingon's health in the sector
    if sector = 1 then
	if seck (1) = 1 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (1)), 290, maxy div 2 - 70, clickfont, white)
	elsif seck (1) = 2 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (1)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (2)), 290, maxy div 2 - 95, clickfont, white)
	elsif seck (1) = 3 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (1)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (2)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (3)), 290, maxy div 2 - 120, clickfont, white)
	elsif seck (1) = 4 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text ("Klingon4 HP:", 180, maxy div 2 - 145, clickfont, white)
	    Draw.Text (intstr (klingonhealth (1)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (2)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (3)), 290, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (4)), 290, maxy div 2 - 145, clickfont, white)
	end if
    elsif sector = 2 then
	if seck (2) = 1 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (5)), 290, maxy div 2 - 70, clickfont, white)
	elsif seck (2) = 2 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (5)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (6)), 290, maxy div 2 - 95, clickfont, white)
	elsif seck (2) = 3 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (5)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (6)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (7)), 290, maxy div 2 - 120, clickfont, white)
	elsif seck (2) = 4 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text ("Klingon4 HP:", 180, maxy div 2 - 145, clickfont, white)
	    Draw.Text (intstr (klingonhealth (5)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (6)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (7)), 290, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (8)), 290, maxy div 2 - 145, clickfont, white)
	end if
    elsif sector = 3 then
	if seck (3) = 1 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (9)), 290, maxy div 2 - 70, clickfont, white)
	elsif seck (3) = 2 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (9)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (10)), 290, maxy div 2 - 95, clickfont, white)
	elsif seck (3) = 3 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (9)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (10)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (11)), 290, maxy div 2 - 120, clickfont, white)
	elsif seck (3) = 4 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text ("Klingon4 HP:", 180, maxy div 2 - 145, clickfont, white)
	    Draw.Text (intstr (klingonhealth (9)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (10)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (11)), 290, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (12)), 290, maxy div 2 - 145, clickfont, white)
	end if
    elsif sector = 4 then
	if seck (4) = 1 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (13)), 290, maxy div 2 - 70, clickfont, white)
	elsif seck (4) = 2 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (13)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (14)), 290, maxy div 2 - 95, clickfont, white)
	elsif seck (4) = 3 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (13)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (14)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (15)), 290, maxy div 2 - 120, clickfont, white)
	elsif seck (4) = 4 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text ("Klingon4 HP:", 180, maxy div 2 - 145, clickfont, white)
	    Draw.Text (intstr (klingonhealth (13)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (14)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (15)), 290, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (16)), 290, maxy div 2 - 145, clickfont, white)
	end if
    elsif sector = 5 then
	if seck (5) = 1 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (17)), 290, maxy div 2 - 70, clickfont, white)
	elsif seck (5) = 2 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (17)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (18)), 290, maxy div 2 - 95, clickfont, white)
	elsif seck (5) = 3 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (17)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (18)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (19)), 290, maxy div 2 - 120, clickfont, white)
	elsif seck (5) = 4 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text ("Klingon4 HP:", 180, maxy div 2 - 145, clickfont, white)
	    Draw.Text (intstr (klingonhealth (17)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (18)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (19)), 290, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (20)), 290, maxy div 2 - 145, clickfont, white)
	end if
    elsif sector = 6 then
	if seck (6) = 1 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (21)), 290, maxy div 2 - 70, clickfont, white)
	elsif seck (6) = 2 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (21)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (22)), 290, maxy div 2 - 95, clickfont, white)
	elsif seck (6) = 3 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (21)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (22)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (23)), 290, maxy div 2 - 120, clickfont, white)
	elsif seck (6) = 4 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text ("Klingon4 HP:", 180, maxy div 2 - 145, clickfont, white)
	    Draw.Text (intstr (klingonhealth (21)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (22)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (23)), 290, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (24)), 290, maxy div 2 - 145, clickfont, white)
	end if
    elsif sector = 7 then
	if seck (7) = 1 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (25)), 290, maxy div 2 - 70, clickfont, white)
	elsif seck (7) = 2 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (25)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (26)), 290, maxy div 2 - 95, clickfont, white)
	elsif seck (7) = 3 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (25)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (26)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (27)), 290, maxy div 2 - 120, clickfont, white)
	elsif seck (7) = 4 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text ("Klingon4 HP:", 180, maxy div 2 - 145, clickfont, white)
	    Draw.Text (intstr (klingonhealth (25)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (26)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (27)), 290, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (28)), 290, maxy div 2 - 145, clickfont, white)
	end if
    elsif sector = 8 then
	if seck (8) = 1 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (29)), 290, maxy div 2 - 70, clickfont, white)
	elsif seck (8) = 2 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (29)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (30)), 290, maxy div 2 - 95, clickfont, white)
	elsif seck (8) = 3 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (29)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (30)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (30)), 290, maxy div 2 - 120, clickfont, white)
	elsif seck (8) = 4 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text ("Klingon4 HP:", 180, maxy div 2 - 145, clickfont, white)
	    Draw.Text (intstr (klingonhealth (29)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (30)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (31)), 290, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (32)), 290, maxy div 2 - 145, clickfont, white)
	end if
    elsif sector = 9 then
	if seck (9) = 1 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (33)), 290, maxy div 2 - 70, clickfont, white)
	elsif seck (9) = 2 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (33)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (34)), 290, maxy div 2 - 95, clickfont, white)
	elsif seck (9) = 3 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (33)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (34)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (35)), 290, maxy div 2 - 120, clickfont, white)
	elsif seck (9) = 4 then
	    Draw.Text ("Klingon1 HP:", 180, maxy div 2 - 70, clickfont, white)
	    Draw.Text ("Klingon2 HP:", 180, maxy div 2 - 95, clickfont, white)
	    Draw.Text ("Klingon3 HP:", 180, maxy div 2 - 120, clickfont, white)
	    Draw.Text ("Klingon4 HP:", 180, maxy div 2 - 145, clickfont, white)
	    Draw.Text (intstr (klingonhealth (33)), 290, maxy div 2 - 70, clickfont, white)
	    Draw.Text (intstr (klingonhealth (34)), 290, maxy div 2 - 95, clickfont, white)
	    Draw.Text (intstr (klingonhealth (35)), 290, maxy div 2 - 120, clickfont, white)
	    Draw.Text (intstr (klingonhealth (36)), 290, maxy div 2 - 145, clickfont, white)
	end if
    end if
end status

%Starbase docking procedure, 3 loops designed to give as many resources as possible
procedure starbasedock ()
    powerrecovered := 0
    shieldsrecovered := 0
    healthrecovered := 0
    if sector = 5 then
	if positionx = starbasex and positiony = starbasey then
	    loop
		exit when power = 10000 or starbasepower = 0
		starbasepower := starbasepower - 1
		powerrecovered := powerrecovered + 1
		power := power + 1
	    end loop
	    loop
		exit when shields = 100 or starbaseshields = 0
		starbaseshields := starbaseshields - 1
		shieldsrecovered := shieldsrecovered + 1
		shields := shields + 1
	    end loop
	    loop
		exit when starbaserepair = 0 or hullintegrity = 100
		starbaserepair := starbaserepair - 1
		healthrecovered := healthrecovered + 1
		hullintegrity := hullintegrity + 1
	    end loop
	end if
    end if
end starbasedock

%Draws objects on the screen, The Enterprise, the Starbase, Klingons and stars. Uses the map array
procedure objects ()

    %Drawing the Enterprise
    if shipcondition not= "Docked" then
	Draw.Text ("E", map (positionx, 0) - 2, map (0, positiony) - 5, clickfont, white)
    end if

    %Drawing the Starbase
    if sector = 5 then
	if shipcondition not= "Docked" then
	    Draw.Text ("S", map (starbasex, 0) - 3, map (0, starbasey) - 7, clickfont, white)
	else
	    Draw.Text ("S", map (starbasex, 0) - 3, map (0, starbasey) - 7, clickfont, green)
	end if
    end if

    %Drawing the stars
    if sector = 1 then
	if sectorstars (1) = 0 then
	elsif sectorstars (1) = 1 then
	    Draw.Text ("*", map (stars (1, 0), 0) - 10, map (0, stars (0, 1)) - 25, titlefont, white)
	elsif sectorstars (1) = 2 then
	    Draw.Text ("*", map (stars (1, 0), 0) - 10, map (0, stars (0, 1)) - 25, titlefont, white)
	    Draw.Text ("*", map (stars (2, 0), 0) - 10, map (0, stars (0, 2)) - 25, titlefont, white)
	end if
    elsif sector = 2 then
	if sectorstars (2) = 0 then
	elsif sectorstars (2) = 1 then
	    Draw.Text ("*", map (stars (3, 0), 0) - 10, map (0, stars (0, 3)) - 25, titlefont, white)
	elsif sectorstars (2) = 2 then
	    Draw.Text ("*", map (stars (3, 0), 0) - 10, map (0, stars (0, 3)) - 25, titlefont, white)
	    Draw.Text ("*", map (stars (4, 0), 0) - 10, map (0, stars (0, 4)) - 25, titlefont, white)
	end if
    elsif sector = 3 then
	if sectorstars (3) = 0 then
	elsif sectorstars (3) = 1 then
	    Draw.Text ("*", map (stars (5, 0), 0) - 10, map (0, stars (0, 5)) - 25, titlefont, white)
	elsif sectorstars (3) = 2 then
	    Draw.Text ("*", map (stars (5, 0), 0) - 10, map (0, stars (0, 5)) - 25, titlefont, white)
	    Draw.Text ("*", map (stars (6, 0), 0) - 10, map (0, stars (0, 6)) - 25, titlefont, white)
	end if
    elsif sector = 4 then
	if sectorstars (4) = 0 then
	elsif sectorstars (4) = 1 then
	    Draw.Text ("*", map (stars (7, 0), 0) - 10, map (0, stars (0, 7)) - 25, titlefont, white)
	elsif sectorstars (4) = 2 then
	    Draw.Text ("*", map (stars (7, 0), 0) - 10, map (0, stars (0, 7)) - 25, titlefont, white)
	    Draw.Text ("*", map (stars (8, 0), 0) - 10, map (0, stars (0, 8)) - 25, titlefont, white)
	end if
    elsif sector = 5 then
	if sectorstars (5) = 0 then
	elsif sectorstars (5) = 1 then
	    Draw.Text ("*", map (stars (9, 0), 0) - 10, map (0, stars (0, 9)) - 25, titlefont, white)
	elsif sectorstars (5) = 2 then
	    Draw.Text ("*", map (stars (9, 0), 0) - 10, map (0, stars (0, 9)) - 25, titlefont, white)
	    Draw.Text ("*", map (stars (10, 0), 0) - 10, map (0, stars (0, 10)) - 25, titlefont, white)
	end if
    elsif sector = 6 then
	if sectorstars (6) = 0 then
	elsif sectorstars (6) = 1 then
	    Draw.Text ("*", map (stars (11, 0), 0) - 10, map (0, stars (0, 11)) - 25, titlefont, white)
	elsif sectorstars (6) = 2 then
	    Draw.Text ("*", map (stars (11, 0), 0) - 10, map (0, stars (0, 11)) - 25, titlefont, white)
	    Draw.Text ("*", map (stars (12, 0), 0) - 10, map (0, stars (0, 12)) - 25, titlefont, white)
	end if
    elsif sector = 7 then
	if sectorstars (7) = 0 then
	elsif sectorstars (7) = 1 then
	    Draw.Text ("*", map (stars (13, 0), 0) - 10, map (0, stars (0, 13)) - 25, titlefont, white)
	elsif sectorstars (7) = 2 then
	    Draw.Text ("*", map (stars (13, 0), 0) - 10, map (0, stars (0, 13)) - 25, titlefont, white)
	    Draw.Text ("*", map (stars (14, 0), 0) - 10, map (0, stars (0, 14)) - 25, titlefont, white)
	end if
    elsif sector = 8 then
	if sectorstars (8) = 0 then
	elsif sectorstars (8) = 1 then
	    Draw.Text ("*", map (stars (15, 0), 0) - 10, map (0, stars (0, 15)) - 25, titlefont, white)
	elsif sectorstars (8) = 2 then
	    Draw.Text ("*", map (stars (15, 0), 0) - 10, map (0, stars (0, 15)) - 25, titlefont, white)
	    Draw.Text ("*", map (stars (16, 0), 0) - 10, map (0, stars (0, 16)) - 25, titlefont, white)
	end if
    elsif sector = 9 then
	if sectorstars (9) = 0 then
	elsif sectorstars (9) = 1 then
	    Draw.Text ("*", map (stars (17, 0), 0) - 10, map (0, stars (0, 17)) - 25, titlefont, white)
	elsif sectorstars (9) = 2 then
	    Draw.Text ("*", map (stars (17, 0), 0) - 10, map (0, stars (0, 17)) - 25, titlefont, white)
	    Draw.Text ("*", map (stars (18, 0), 0) - 10, map (0, stars (0, 18)) - 25, titlefont, white)
	end if
    end if

    %Drawing the Klingons
    if sector = 1 then
	if seck (1) = 0 then
	elsif seck (1) = 1 then
	    Draw.Text ("K", map (klingonx (1), 0) - 5, map (0, klingony (1)) - 5, clickfont, white)
	elsif seck (1) = 2 then
	    Draw.Text ("K", map (klingonx (1), 0) - 5, map (0, klingony (1)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (2), 0) - 5, map (0, klingony (2)) - 5, clickfont, white)
	elsif seck (1) = 3 then
	    Draw.Text ("K", map (klingonx (1), 0) - 5, map (0, klingony (1)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (2), 0) - 5, map (0, klingony (2)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (3), 0) - 5, map (0, klingony (3)) - 5, clickfont, white)
	elsif seck (1) = 4 then
	    Draw.Text ("K", map (klingonx (1), 0) - 5, map (0, klingony (1)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (2), 0) - 5, map (0, klingony (2)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (3), 0) - 5, map (0, klingony (3)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (4), 0) - 5, map (0, klingony (4)) - 5, clickfont, white)
	end if
    elsif sector = 2 then
	if seck (2) = 0 then
	elsif seck (2) = 1 then
	    Draw.Text ("K", map (klingonx (5), 0) - 5, map (0, klingony (5)) - 5, clickfont, white)
	elsif seck (2) = 2 then
	    Draw.Text ("K", map (klingonx (5), 0) - 5, map (0, klingony (5)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (6), 0) - 5, map (0, klingony (6)) - 5, clickfont, white)
	elsif seck (2) = 3 then
	    Draw.Text ("K", map (klingonx (5), 0) - 5, map (0, klingony (5)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (6), 0) - 5, map (0, klingony (6)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (7), 0) - 5, map (0, klingony (7)) - 5, clickfont, white)
	elsif seck (2) = 4 then
	    Draw.Text ("K", map (klingonx (5), 0) - 5, map (0, klingony (5)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (6), 0) - 5, map (0, klingony (6)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (7), 0) - 5, map (0, klingony (7)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (8), 0) - 5, map (0, klingony (8)) - 5, clickfont, white)
	end if
    elsif sector = 3 then
	if seck (3) = 0 then
	elsif seck (3) = 1 then
	    Draw.Text ("K", map (klingonx (9), 0) - 5, map (0, klingony (9)) - 5, clickfont, white)
	elsif seck (3) = 2 then
	    Draw.Text ("K", map (klingonx (9), 0) - 5, map (0, klingony (9)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (10), 0) - 5, map (0, klingony (10)) - 5, clickfont, white)
	elsif seck (3) = 3 then
	    Draw.Text ("K", map (klingonx (9), 0) - 5, map (0, klingony (9)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (10), 0) - 5, map (0, klingony (10)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (11), 0) - 5, map (0, klingony (11)) - 5, clickfont, white)
	elsif seck (3) = 4 then
	    Draw.Text ("K", map (klingonx (9), 0) - 5, map (0, klingony (9)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (10), 0) - 5, map (0, klingony (10)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (11), 0) - 5, map (0, klingony (11)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (12), 0) - 5, map (0, klingony (12)) - 5, clickfont, white)
	end if
    elsif sector = 4 then
	if seck (4) = 0 then
	elsif seck (4) = 1 then
	    Draw.Text ("K", map (klingonx (13), 0) - 5, map (0, klingony (13)) - 5, clickfont, white)
	elsif seck (4) = 2 then
	    Draw.Text ("K", map (klingonx (13), 0) - 5, map (0, klingony (13)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (14), 0) - 5, map (0, klingony (14)) - 5, clickfont, white)
	elsif seck (4) = 3 then
	    Draw.Text ("K", map (klingonx (13), 0) - 5, map (0, klingony (13)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (14), 0) - 5, map (0, klingony (14)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (15), 0) - 5, map (0, klingony (15)) - 5, clickfont, white)
	elsif seck (4) = 4 then
	    Draw.Text ("K", map (klingonx (13), 0) - 5, map (0, klingony (13)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (14), 0) - 5, map (0, klingony (14)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (15), 0) - 5, map (0, klingony (15)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (16), 0) - 5, map (0, klingony (16)) - 5, clickfont, white)
	end if
    elsif sector = 5 then
	if seck (5) = 0 then
	elsif seck (5) = 1 then
	    Draw.Text ("K", map (klingonx (17), 0) - 5, map (0, klingony (17)) - 5, clickfont, white)
	elsif seck (5) = 2 then
	    Draw.Text ("K", map (klingonx (17), 0) - 5, map (0, klingony (17)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (18), 0) - 5, map (0, klingony (18)) - 5, clickfont, white)
	elsif seck (5) = 3 then
	    Draw.Text ("K", map (klingonx (17), 0) - 5, map (0, klingony (17)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (18), 0) - 5, map (0, klingony (18)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (19), 0) - 5, map (0, klingony (19)) - 5, clickfont, white)
	elsif seck (5) = 4 then
	    Draw.Text ("K", map (klingonx (17), 0) - 5, map (0, klingony (17)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (18), 0) - 5, map (0, klingony (18)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (19), 0) - 5, map (0, klingony (19)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (20), 0) - 5, map (0, klingony (20)) - 5, clickfont, white)
	end if
    elsif sector = 6 then
	if seck (6) = 0 then
	elsif seck (6) = 1 then
	    Draw.Text ("K", map (klingonx (21), 0) - 5, map (0, klingony (21)) - 5, clickfont, white)
	elsif seck (6) = 2 then
	    Draw.Text ("K", map (klingonx (21), 0) - 5, map (0, klingony (21)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (22), 0) - 5, map (0, klingony (22)) - 5, clickfont, white)
	elsif seck (6) = 3 then
	    Draw.Text ("K", map (klingonx (21), 0) - 5, map (0, klingony (21)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (22), 0) - 5, map (0, klingony (22)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (23), 0) - 5, map (0, klingony (23)) - 5, clickfont, white)
	elsif seck (6) = 4 then
	    Draw.Text ("K", map (klingonx (21), 0) - 5, map (0, klingony (21)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (22), 0) - 5, map (0, klingony (22)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (23), 0) - 5, map (0, klingony (23)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (24), 0) - 5, map (0, klingony (24)) - 5, clickfont, white)
	end if
    elsif sector = 7 then
	if seck (7) = 0 then
	elsif seck (7) = 1 then
	    Draw.Text ("K", map (klingonx (25), 0) - 5, map (0, klingony (25)) - 5, clickfont, white)
	elsif seck (7) = 2 then
	    Draw.Text ("K", map (klingonx (25), 0) - 5, map (0, klingony (25)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (26), 0) - 5, map (0, klingony (26)) - 5, clickfont, white)
	elsif seck (7) = 3 then
	    Draw.Text ("K", map (klingonx (25), 0) - 5, map (0, klingony (25)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (26), 0) - 5, map (0, klingony (26)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (27), 0) - 5, map (0, klingony (27)) - 5, clickfont, white)
	elsif seck (7) = 4 then
	    Draw.Text ("K", map (klingonx (25), 0) - 5, map (0, klingony (25)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (26), 0) - 5, map (0, klingony (26)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (27), 0) - 5, map (0, klingony (27)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (28), 0) - 5, map (0, klingony (28)) - 5, clickfont, white)
	end if
    elsif sector = 8 then
	if seck (8) = 0 then
	elsif seck (8) = 1 then
	    Draw.Text ("K", map (klingonx (29), 0) - 5, map (0, klingony (29)) - 5, clickfont, white)
	elsif seck (8) = 2 then
	    Draw.Text ("K", map (klingonx (29), 0) - 5, map (0, klingony (29)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (30), 0) - 5, map (0, klingony (30)) - 5, clickfont, white)
	elsif seck (8) = 3 then
	    Draw.Text ("K", map (klingonx (29), 0) - 5, map (0, klingony (29)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (30), 0) - 5, map (0, klingony (30)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (31), 0) - 5, map (0, klingony (31)) - 5, clickfont, white)
	elsif seck (8) = 4 then
	    Draw.Text ("K", map (klingonx (29), 0) - 5, map (0, klingony (29)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (30), 0) - 5, map (0, klingony (30)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (31), 0) - 5, map (0, klingony (31)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (32), 0) - 5, map (0, klingony (32)) - 5, clickfont, white)
	end if
    elsif sector = 9 then
	if seck (9) = 0 then
	elsif seck (9) = 1 then
	    Draw.Text ("K", map (klingonx (33), 0) - 5, map (0, klingony (33)) - 5, clickfont, white)
	elsif seck (9) = 2 then
	    Draw.Text ("K", map (klingonx (33), 0) - 5, map (0, klingony (33)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (34), 0) - 5, map (0, klingony (34)) - 5, clickfont, white)
	elsif seck (9) = 3 then
	    Draw.Text ("K", map (klingonx (33), 0) - 5, map (0, klingony (33)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (34), 0) - 5, map (0, klingony (34)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (35), 0) - 5, map (0, klingony (35)) - 5, clickfont, white)
	elsif seck (9) = 4 then
	    Draw.Text ("K", map (klingonx (33), 0) - 5, map (0, klingony (33)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (34), 0) - 5, map (0, klingony (34)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (35), 0) - 5, map (0, klingony (35)) - 5, clickfont, white)
	    Draw.Text ("K", map (klingonx (36), 0) - 5, map (0, klingony (36)) - 5, clickfont, white)
	end if
    end if
end objects

%Sensors Procedure, clears screen and draws the sectors with info about Klingons, stars, and starbases
procedure sensors ()
    cls
    userinterface
    status
    objects

    Draw.FillBox (maxx div 2 + 75, 10, maxx - 25, 40, blue)
    Draw.Box (maxx div 2 + 75, 10, maxx - 25, 40, white)
    Draw.Text ("BACK", maxx div 2 + 155, 20, clickfont, white)
    Draw.Text ("The 9 Sectors", maxx div 2 + 120, maxy - 20, clickfont, white)
    Draw.Text ("312", maxx div 2 + 60, maxy - 60, clickfont, white)
    Draw.Text ("3 rep. # of Klingons", maxx div 2 + 110, maxy - 40, clickfont, white)
    Draw.Text ("1 rep. # of Starbases", maxx div 2 + 110, maxy - 60, clickfont, white)
    Draw.Text ("2 rep. # of Stars", maxx div 2 + 110, maxy - 80, clickfont, white)

    %Sectors
    Draw.Box (maxx div 2 + 100, maxy div 2 + 20, maxx div 2 + 145, maxy div 2 + 60, white)     % Box 1
    Draw.Box (maxx div 2 + 160, maxy div 2 + 20, maxx div 2 + 205, maxy div 2 + 60, white)     % Box 2
    Draw.Box (maxx div 2 + 220, maxy div 2 + 20, maxx div 2 + 265, maxy div 2 + 60, white)     % Box 3
    Draw.Box (maxx div 2 + 100, maxy div 2 - 40, maxx div 2 + 145, maxy div 2, white)       % Box 4
    Draw.Box (maxx div 2 + 160, maxy div 2 - 40, maxx div 2 + 205, maxy div 2, white)       % Box 5
    Draw.Box (maxx div 2 + 220, maxy div 2 - 40, maxx div 2 + 265, maxy div 2, white)       % Box 6
    Draw.Box (maxx div 2 + 100, maxy div 2 - 100, maxx div 2 + 145, maxy div 2 - 60, white)     % Box 7
    Draw.Box (maxx div 2 + 160, maxy div 2 - 100, maxx div 2 + 205, maxy div 2 - 60, white)     % Box 8
    Draw.Box (maxx div 2 + 220, maxy div 2 - 100, maxx div 2 + 265, maxy div 2 - 60, white)     % Box 9

    % # Of Starbases
    Draw.Text ("0", maxx div 2 + 117, maxy div 2 + 40, clickfont, white)
    Draw.Text ("0", maxx div 2 + 177, maxy div 2 + 40, clickfont, white)
    Draw.Text ("0", maxx div 2 + 235, maxy div 2 + 40, clickfont, white)
    Draw.Text ("0", maxx div 2 + 115, maxy div 2 - 20, clickfont, white)
    Draw.Text ("1", maxx div 2 + 177, maxy div 2 - 20, clickfont, white)
    Draw.Text ("0", maxx div 2 + 235, maxy div 2 - 20, clickfont, white)
    Draw.Text ("0", maxx div 2 + 115, maxy div 2 - 85, clickfont, white)
    Draw.Text ("0", maxx div 2 + 177, maxy div 2 - 85, clickfont, white)
    Draw.Text ("0", maxx div 2 + 235, maxy div 2 - 85, clickfont, white)


    % # Of Klingons
    Draw.Text (intstr (seckleft (1)), maxx div 2 + 107, maxy div 2 + 40, clickfont, white)
    Draw.Text (intstr (seckleft (2)), maxx div 2 + 167, maxy div 2 + 40, clickfont, white)
    Draw.Text (intstr (seckleft (3)), maxx div 2 + 225, maxy div 2 + 40, clickfont, white)
    Draw.Text (intstr (seckleft (4)), maxx div 2 + 105, maxy div 2 - 20, clickfont, white)
    Draw.Text (intstr (seckleft (5)), maxx div 2 + 167, maxy div 2 - 20, clickfont, white)
    Draw.Text (intstr (seckleft (6)), maxx div 2 + 225, maxy div 2 - 20, clickfont, white)
    Draw.Text (intstr (seckleft (7)), maxx div 2 + 105, maxy div 2 - 85, clickfont, white)
    Draw.Text (intstr (seckleft (8)), maxx div 2 + 167, maxy div 2 - 85, clickfont, white)
    Draw.Text (intstr (seckleft (9)), maxx div 2 + 225, maxy div 2 - 85, clickfont, white)

    % # Of Stars
    Draw.Text (intstr (sectorstars (1)), maxx div 2 + 127, maxy div 2 + 40, clickfont, white)
    Draw.Text (intstr (sectorstars (2)), maxx div 2 + 187, maxy div 2 + 40, clickfont, white)
    Draw.Text (intstr (sectorstars (3)), maxx div 2 + 245, maxy div 2 + 40, clickfont, white)
    Draw.Text (intstr (sectorstars (4)), maxx div 2 + 125, maxy div 2 - 20, clickfont, white)
    Draw.Text (intstr (sectorstars (5)), maxx div 2 + 187, maxy div 2 - 20, clickfont, white)
    Draw.Text (intstr (sectorstars (6)), maxx div 2 + 245, maxy div 2 - 20, clickfont, white)
    Draw.Text (intstr (sectorstars (7)), maxx div 2 + 187, maxy div 2 - 85, clickfont, white)
    Draw.Text (intstr (sectorstars (8)), maxx div 2 + 125, maxy div 2 - 85, clickfont, white)
    Draw.Text (intstr (sectorstars (9)), maxx div 2 + 245, maxy div 2 - 85, clickfont, white)

    loop
	Mouse.Where (x, y, click)
	exit when click = 0
    end loop
    loop
	Mouse.Where (x, y, click)
	exit when click = 1 and (x >= maxx div 2 + 75 and x <= maxx - 25) and (y >= 10 and y <= 40)
    end loop
end sensors

%Move the Enterprise, uses positionx and positiony.
procedure move ()
    if impdirection = 1 then
	positionx := positionx - imppower
	positiony := positiony - imppower
    elsif impdirection = 2 then
	positiony := positiony - imppower
    elsif impdirection = 3 then
	positionx := positionx + imppower
	positiony := positiony - imppower
    elsif impdirection = 4 then
	positionx := positionx - imppower
    elsif impdirection = 5 then
	positionx := positionx + imppower
    elsif impdirection = 6 then
	positionx := positionx - imppower
	positiony := positiony + imppower
    elsif impdirection = 7 then
	positiony := positiony + imppower
    elsif impdirection = 8 then
	positionx := positionx + imppower
	positiony := positiony + imppower
    end if

    %If positionx or positiony is off the grid, put them back to the nearest spot
    if positionx > 8 then
	loop
	    positionx := positionx - 1
	    exit when positionx = 8
	end loop
    elsif positionx < 1 then
	loop
	    positionx := positionx + 1
	    exit when positionx = 1
	end loop
    end if

    if positiony > 8 then
	loop
	    positiony := positiony - 1
	    exit when positiony = 8
	end loop
    elsif positiony < 1 then
	loop
	    positiony := positiony + 1
	    exit when positiony = 1
	end loop
    end if
end move

%Collision procedure with Klingon ships, doing so hurts the hull integrity by 25 and kills the klingon
procedure collision ()
    phasersize := 8
    phasercolor := 1
    if sector = 1 then
	if klingonhealth (1) not= 1200 then
	    if (klingonx (1) = positionx and klingony (1) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (1) := 0
	    end if
	end if
	if klingonhealth (2) not= 1200 then
	    if (klingonx (2) = positionx and klingony (2) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (2) := 0
	    end if
	end if
	if klingonhealth (3) not= 1200 then
	    if (klingonx (3) = positionx and klingony (3) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (3) := 0
	    end if
	end if
	if klingonhealth (4) not= 1200 then
	    if (klingonx (4) = positionx and klingony (4) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (4) := 0
	    end if
	end if
	if klingonhealth (5) not= 1200 then
	elsif sector = 2 then
	    if (klingonx (5) = positionx and klingony (5) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (5) := 0
	    end if
	end if
	if klingonhealth (6) not= 1200 then
	    if (klingonx (6) = positionx and klingony (6) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (6) := 0
	    end if
	end if
	if klingonhealth (7) not= 1200 then
	    if (klingonx (7) = positionx and klingony (7) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (7) := 0
	    end if
	end if
	if klingonhealth (8) not= 1200 then
	    if (klingonx (8) = positionx and klingony (8) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (8) := 0
	    end if
	end if
    elsif sector = 3 then
	if klingonhealth (9) not= 1200 then
	    if (klingonx (9) = positionx and klingony (9) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (9) := 0
	    end if
	end if
	if klingonhealth (10) not= 1200 then
	    if (klingonx (10) = positionx and klingony (10) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (10) := 0
	    end if
	end if
	if klingonhealth (11) not= 1200 then
	    if (klingonx (11) = positionx and klingony (11) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (11) := 0
	    end if
	end if
	if klingonhealth (12) not= 1200 then
	    if (klingonx (12) = positionx and klingony (12) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (12) := 0
	    end if
	end if
    elsif sector = 4 then
	if klingonhealth (13) not= 1200 then
	    if (klingonx (13) = positionx and klingony (13) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (13) := 0
	    end if
	end if
	if klingonhealth (14) not= 1200 then
	    if (klingonx (14) = positionx and klingony (14) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (14) := 0
	    end if
	end if
	if klingonhealth (15) not= 1200 then
	    if (klingonx (15) = positionx and klingony (15) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (15) := 0
	    end if
	end if
	if klingonhealth (16) not= 1200 then
	    if (klingonx (16) = positionx and klingony (16) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (16) := 0
	    end if
	end if
    elsif sector = 5 then
	if klingonhealth (17) not= 1200 then
	    if (klingonx (17) = positionx and klingony (17) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (17) := 0
	    end if
	end if
	if klingonhealth (18) not= 1200 then
	    if (klingonx (18) = positionx and klingony (18) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (18) := 0
	    end if
	end if
	if klingonhealth (19) not= 1200 then
	    if (klingonx (19) = positionx and klingony (19) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (19) := 0
	    end if
	end if
	if klingonhealth (20) not= 1200 then
	    if (klingonx (20) = positionx and klingony (20) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (20) := 0
	    end if
	end if
    elsif sector = 6 then
	if klingonhealth (21) not= 1200 then
	    if (klingonx (21) = positionx and klingony (21) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (21) := 0
	    end if
	end if
	if klingonhealth (22) not= 1200 then
	    if (klingonx (22) = positionx and klingony (22) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (22) := 0
	    end if
	end if
	if klingonhealth (23) not= 1200 then
	    if (klingonx (23) = positionx and klingony (23) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (23) := 0
	    end if
	end if
	if klingonhealth (24) not= 1200 then
	    if (klingonx (24) = positionx and klingony (24) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (24) := 0
	    end if
	end if
    elsif sector = 7 then
	if klingonhealth (25) not= 1200 then
	    if (klingonx (25) = positionx and klingony (25) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (25) := 0
	    end if
	end if
	if klingonhealth (26) not= 1200 then
	    if (klingonx (26) = positionx and klingony (26) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (26) := 0
	    end if
	end if
	if klingonhealth (27) not= 1200 then
	    if (klingonx (27) = positionx and klingony (27) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (27) := 0
	    end if
	end if
	if klingonhealth (28) not= 1200 then
	    if (klingonx (28) = positionx and klingony (28) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (28) := 0
	    end if
	end if
    elsif sector = 8 then
	if klingonhealth (29) not= 1200 then
	    if (klingonx (29) = positionx and klingony (29) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (29) := 0
	    end if
	end if
	if klingonhealth (30) not= 1200 then
	    if (klingonx (30) = positionx and klingony (30) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (30) := 0
	    end if
	end if
	if klingonhealth (31) not= 1200 then
	    if (klingonx (31) = positionx and klingony (31) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (31) := 0
	    end if
	end if
	if klingonhealth (32) not= 1200 then
	    if (klingonx (32) = positionx and klingony (32) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (32) := 0
	    end if
	end if
    elsif sector = 9 then
	if klingonhealth (33) not= 1200 then
	    if (klingonx (33) = positionx and klingony (33) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (33) := 0
	    end if
	end if
	if klingonhealth (34) not= 1200 then
	    if (klingonx (34) = positionx and klingony (34) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (34) := 0
	    end if
	end if
	if klingonhealth (35) not= 1200 then
	    if (klingonx (35) = positionx and klingony (35) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (35) := 0
	    end if
	end if
	if klingonhealth (36) not= 1200 then
	    if (klingonx (36) = positionx and klingony (36) = positiony) then
		hullintegrity := hullintegrity - 25
		klingonhealth (36) := 0
	    end if
	end if
    end if
end collision

%Impulse Engine procedure
procedure imp ()
    cls
    userinterface
    status
    objects
    Draw.Text ("Which Direction?", maxx div 2 + 120, maxy - 20, clickfont, white)
    %Direction Boxes
    Draw.Box (maxx div 2 + 100, maxy div 2 + 20, maxx div 2 + 145, maxy div 2 + 60, white)                     % Box 1
    Draw.Box (maxx div 2 + 160, maxy div 2 + 20, maxx div 2 + 205, maxy div 2 + 60, white)                     % Box 2
    Draw.Box (maxx div 2 + 220, maxy div 2 + 20, maxx div 2 + 265, maxy div 2 + 60, white)                     % Box 3
    Draw.Box (maxx div 2 + 100, maxy div 2 - 40, maxx div 2 + 145, maxy div 2, white)                          % Box 4
    Draw.Box (maxx div 2 + 220, maxy div 2 - 40, maxx div 2 + 265, maxy div 2, white)                          % Box 5
    Draw.Box (maxx div 2 + 100, maxy div 2 - 100, maxx div 2 + 145, maxy div 2 - 60, white)                    % Box 6
    Draw.Box (maxx div 2 + 160, maxy div 2 - 100, maxx div 2 + 205, maxy div 2 - 60, white)                    % Box 7
    Draw.Box (maxx div 2 + 220, maxy div 2 - 100, maxx div 2 + 265, maxy div 2 - 60, white)                    % Box 8

    %Direction Text
    Draw.Text ("Down", maxx div 2 + 167, maxy div 2 - 80,
	smallfont, white)
    Draw.Text ("Up", maxx div 2 + 175, maxy div 2 + 40,
	smallfont, white)
    Draw.Text ("Left", maxx div 2 + 110, maxy div 2 - 20,
	smallfont, white)
    Draw.Text ("Right", maxx div 2 + 228, maxy div 2 - 20,
	smallfont, white)
    Draw.Text ("Up-Left", maxx div 2 + 102, maxy div 2 +
	40, smallfont,
	white)
    Draw.Text ("Up-Right", maxx div 2 + 220, maxy div 2 +
	40, smallfont,
	white)
    Draw.Text ("Down", maxx div 2 + 107, maxy div 2 - 93,
	smallfont, white)
    Draw.Text ("Left", maxx div 2 + 112, maxy div 2 - 80,
	smallfont, white)
    Draw.Text ("Down", maxx div 2 + 228, maxy div 2 - 93,
	smallfont, white)
    Draw.Text ("Right", maxx div 2 + 228, maxy div 2 - 80,
	smallfont, white)

    %Choosing which direction the ship will move in
    loop
	Mouse.Where (x, y, click)
	exit when click = 0
    end loop
    loop
	Mouse.Where (x, y, click)
	if click = 1 and (x >= maxx div 2 + 160 and x <=
		maxx div 2 + 205)
		and (y >= maxy div 2 + 20 and y <= maxy div
		2 +
		60) then
	    impdirection := 2
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 + 20 and y <= maxy div
		2
		+ 60) then
	    impdirection := 1
	    exit
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 + 20 and y <= maxy div
		2
		+ 60) then
	    impdirection := 3
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 - 40 and y <= maxy div
		2) then
	    impdirection := 4
	    exit
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 - 40 and y <= maxy div
		2) then
	    impdirection := 5
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    impdirection := 6
	    exit
	elsif click = 1 and (x >= maxx div 2 + 160 and x <=
		maxx div 2 +
		205)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    impdirection := 7
	    exit
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    impdirection := 8
	    exit
	end if
    end loop
    loop
	Mouse.Where (x, y, click)
	exit when click = 0
    end loop
    cls
    userinterface
    status
    objects
    Draw.Text ("How many Spaces?", maxx div 2 + 115, maxy -
	20, clickfont,
	white)

    %Spaces Boxes
    Draw.Box (maxx div 2 + 100, maxy div 2 + 20, maxx div 2
	+ 145, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 1
    Draw.Box (maxx div 2 + 160, maxy div 2 + 20, maxx div 2
	+ 205, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 2
    Draw.Box (maxx div 2 + 220, maxy div 2 + 20, maxx div 2
	+ 265, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 3
    Draw.Box (maxx div 2 + 100, maxy div 2 - 40, maxx div 2
	+ 145, maxy div
	2,
	white)                                                                                                                                                    % Box 4
    Draw.Box (maxx div 2 + 220, maxy div 2 - 40, maxx div 2
	+ 265, maxy div
	2,
	white)                                                                                                                                                    % Box 5
    Draw.Box (maxx div 2 + 100, maxy div 2 - 100, maxx div
	2 + 145, maxy
	div 2
	- 60, white)                                                                                                                                                    % Box 6
    Draw.Box (maxx div 2 + 160, maxy div 2 - 100, maxx div
	2 + 205, maxy
	div 2
	- 60, white)                                                                                                                                                    % Box 7

    %Spaces Numbers
    Draw.Text ("7", maxx div 2 + 177, maxy div 2 - 85,
	clickfont, white)
    Draw.Text ("2", maxx div 2 + 177, maxy div 2 + 40,
	clickfont, white)
    Draw.Text ("4", maxx div 2 + 115, maxy div 2 - 20,
	clickfont, white)
    Draw.Text ("5", maxx div 2 + 235, maxy div 2 - 20,
	clickfont, white)
    Draw.Text ("1", maxx div 2 + 117, maxy div 2 + 40,
	clickfont, white)
    Draw.Text ("3", maxx div 2 + 235, maxy div 2 + 40,
	clickfont, white)
    Draw.Text ("6", maxx div 2 + 115, maxy div 2 - 85,
	clickfont, white)

    %Choosing how many spaces the Enterprise will move, also has the cancel button
    Draw.FillBox (maxx div 2 + 75, 10, maxx - 25, 40, blue)
    Draw.Box (maxx div 2 + 75, 10, maxx - 25, 40, white)
    Draw.Text ("CANCEL", maxx div 2 + 145, 20, clickfont,
	white)
    trueorfalse := false
    loop
	Mouse.Where (x, y, click)
	if click = 1 and (x >= maxx div 2 + 75 and x <=
		maxx - 25) and (y
		>= 10
		and y <= 40) then
	    trueorfalse := true
	    impdirection := 0
	    imppower := 0
	    exit
	elsif click = 1 and (x >= maxx div 2 + 160 and x <=
		maxx div 2 +
		205)
		and (y >= maxy div 2 + 20 and y <= maxy div
		2
		+ 60) then
	    imppower := 2
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 + 20 and y <= maxy div
		2
		+ 60) then
	    imppower := 1
	    exit
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 + 20 and y <= maxy div
		2
		+ 60) then
	    imppower := 3
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 - 40 and y <= maxy div
		2) then
	    imppower := 4
	    exit
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 - 40 and y <= maxy div
		2) then
	    imppower := 5
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    imppower := 6
	    exit
	elsif click = 1 and (x >= maxx div 2 + 160 and x <=
		maxx div 2 +
		205)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    imppower := 7
	    exit
	end if
    end loop
    move
    %Reset text screen
    if imppower > 0 and imppower < 9 then
	impulse := true
	warpengine := false
	torpedo := false
	phaser := false
    end if

    %Setting move variables if the Enterprise is out of the grid, reverses the direction and moves one space
    imppower := 1
    if impdirection = 1 then
	impdirection := 8
    elsif impdirection = 2 then
	impdirection := 7
    elsif impdirection = 3 then
	impdirection := 6
    elsif impdirection = 4 then
	impdirection := 5
    elsif impdirection = 5 then
	impdirection := 4
    elsif impdirection = 6 then
	impdirection := 3
    elsif impdirection = 7 then
	impdirection := 2
    elsif impdirection = 8 then
	impdirection := 1
    end if

    %Moves out of stars
    if sector = 1 then
	if sectorstars (1) = 1 then
	    if (positionx = stars (1, 0) and positiony =
		    stars (0, 1)) then
		move
	    end if
	elsif sectorstars (1) = 2 then
	    if (positionx = stars (1, 0) and positiony =
		    stars (0, 1))
		    or (positionx = stars (2, 0) and positiony =
		    stars (0, 2)) then
		move
	    end if
	end if
    elsif sector = 2 then
	if sectorstars (2) = 1 then
	    if (positionx = stars (3, 0) and positiony =
		    stars (0, 3)) then
		move
	    end if
	elsif sectorstars (2) = 2 then
	    if (positionx = stars (3, 0) and positiony =
		    stars (0, 3))
		    or (positionx = stars (4, 0) and positiony =
		    stars (0, 4)) then
		move
	    end if
	end if
    elsif sector = 3 then
	if sectorstars (3) = 1 then
	    if (positionx = stars (5, 0) and positiony =
		    stars (0, 5)) then
		move
	    end if
	elsif sectorstars (3) = 2 then
	    if (positionx = stars (5, 0) and positiony =
		    stars (0, 5))
		    or (positionx = stars (6, 0) and positiony =
		    stars (0, 6)) then
		move
	    end if
	end if
    elsif sector = 4 then
	if sectorstars (4) = 1 then
	    if (positionx = stars (7, 0) and positiony =
		    stars (0, 7)) then
		move
	    end if
	elsif sectorstars (4) = 2 then
	    if (positionx = stars (7, 0) and positiony =
		    stars (0, 7))
		    or (positionx = stars (8, 0) and positiony =
		    stars (0, 8)) then
		move
	    end if
	end if
    elsif sector = 5 then
	if sectorstars (5) = 1 then
	    if (positionx = stars (9, 0) and positiony =
		    stars (0, 9)) then
		move
	    end if
	elsif sectorstars (5) = 2 then
	    if (positionx = stars (9, 0) and positiony =
		    stars (0, 9))
		    or (positionx = stars (10, 0) and positiony
		    =
		    stars (0, 10)) then
		move
	    end if
	end if
    elsif sector = 6 then
	if sectorstars (6) = 1 then
	    if (positionx = stars (11, 0) and positiony =
		    stars (0, 11))
		    then
		move
	    end if
	elsif sectorstars (6) = 2 then
	    if (positionx = stars (11, 0) and positiony =
		    stars (0, 11))
		    or (positionx = stars (12, 0) and positiony
		    =
		    stars (0, 12)) then
		move
	    end if
	end if
    elsif sector = 7 then
	if sectorstars (7) = 1 then
	    if (positionx = stars (13, 0) and positiony =
		    stars (0, 13))
		    then
		move
	    end if
	elsif sectorstars (7) = 2 then
	    if (positionx = stars (13, 0) and positiony =
		    stars (0, 13))
		    or (positionx = stars (14, 0) and positiony
		    =
		    stars (0, 14)) then
		move
	    end if
	end if
    elsif sector = 8 then
	if sectorstars (8) = 1 then
	    if (positionx = stars (15, 0) and positiony =
		    stars (0, 15))
		    then
		move
	    end if
	elsif sectorstars (8) = 2 then
	    if (positionx = stars (15, 0) and positiony =
		    stars (0, 15))
		    or (positionx = stars (16, 0) and positiony
		    =
		    stars (0, 16)) then
		move
	    end if
	end if
    elsif sector = 9 then
	if sectorstars (9) = 1 then
	    if (positionx = stars (17, 0) and positiony =
		    stars (0, 17))
		    then
		move
	    end if
	elsif sectorstars (9) = 2 then
	    if (positionx = stars (17, 0) and positiony =
		    stars (0, 17))
		    or (positionx = stars (18, 0) and positiony
		    =
		    stars (0, 18)) then
		move
	    end if
	end if
    end if
    collision
    if trueorfalse = false then
	power := power - 50 * imppower
    end if
end imp

%Warp Drive procedure, moves to another sector
procedure warp ()
    cls
    userinterface
    status
    objects

    Draw.FillBox (maxx div 2 + 75, 10, maxx - 25, 40, blue)
    Draw.Box (maxx div 2 + 75, 10, maxx - 25, 40, white)
    Draw.Text ("CANCEL", maxx div 2 + 145, 20, clickfont, white)
    Draw.Text ("To Which Sector?", maxx div 2 + 120, maxy - 20, clickfont, white)

    %Sectors
    Draw.Box (maxx div 2 + 100, maxy div 2 + 20, maxx div 2 +
	145, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 1
    Draw.Box (maxx div 2 + 160, maxy div 2 + 20, maxx div 2 +
	205, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 2
    Draw.Box (maxx div 2 + 220, maxy div 2 + 20, maxx div 2 +
	265, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 3
    Draw.Box (maxx div 2 + 100, maxy div 2 - 40, maxx div 2 +
	145, maxy div
	2,
	white)                                                                                                                                                    % Box 4
    Draw.Box (maxx div 2 + 160, maxy div 2 - 40, maxx div 2 +
	205, maxy div
	2,
	white)                                                                                                                                                    % Box 5
    Draw.Box (maxx div 2 + 220, maxy div 2 - 40, maxx div 2 +
	265, maxy div
	2,
	white)                                                                                                                                                    % Box 6
    Draw.Box (maxx div 2 + 100, maxy div 2 - 100, maxx div 2 +
	145, maxy
	div 2
	- 60, white)                                                                                                                                                    % Box 7
    Draw.Box (maxx div 2 + 160, maxy div 2 - 100, maxx div 2 +
	205, maxy
	div 2
	- 60, white)                                                                                                                                                    % Box 8
    Draw.Box (maxx div 2 + 220, maxy div 2 - 100, maxx div 2 +
	265, maxy
	div 2
	- 60, white)                                                                                                                                                    % Box 9

    %Sector Numbers
    Draw.Text ("8", maxx div 2 + 177, maxy div 2 - 85,
	clickfont, white)
    Draw.Text ("2", maxx div 2 + 177, maxy div 2 + 40,
	clickfont, white)
    Draw.Text ("4", maxx div 2 + 115, maxy div 2 - 20,
	clickfont, white)
    Draw.Text ("5", maxx div 2 + 177, maxy div 2 - 20,
	clickfont, white)
    Draw.Text ("6", maxx div 2 + 235, maxy div 2 - 20,
	clickfont, white)
    Draw.Text ("1", maxx div 2 + 117, maxy div 2 + 40,
	clickfont, white)
    Draw.Text ("3", maxx div 2 + 235, maxy div 2 + 40,
	clickfont, white)
    Draw.Text ("7", maxx div 2 + 115, maxy div 2 - 85,
	clickfont, white)
    Draw.Text ("9", maxx div 2 + 235, maxy div 2 - 85,
	clickfont, white)
    trueorfalse := false
    loop
	Mouse.Where (x, y, click)
	exit when click = 0
    end loop

    %Deciding which sector to go to
    loop
	Mouse.Where (x, y, click)
	if click = 1 and (x >= maxx div 2 + 75 and x <= maxx - 25) and (y >= 10 and y <= 40) then
	    warpengine := false
	    trueorfalse := true
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 + 20 and y <= maxy div 2
		+ 60) then
	    if sector not= 1 then
		warpengine := true
		impulse := false
		torpedo := false
		phaser := false
		sector := 1
		power := power - 500
		exit
	    end if
	elsif click = 1 and (x >= maxx div 2 + 160 and x <=
		maxx div 2 +
		205)
		and (y >= maxy div 2 + 20 and y <= maxy div 2
		+ 60) then
	    if sector not= 2 then
		warpengine := true
		impulse := false
		torpedo := false
		phaser := false
		sector := 2
		power := power - 500
		exit
	    end if
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 + 20 and y <= maxy div 2
		+ 60) then
	    if sector not= 3 then
		warpengine := true
		impulse := false
		torpedo := false
		phaser := false
		sector := 3
		power := power - 500
		exit
	    end if
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 - 40 and y <= maxy div
		2) then
	    if sector not= 4 then
		warpengine := true
		impulse := false
		torpedo := false
		phaser := false
		sector := 4
		power := power - 500
		exit
	    end if
	elsif click = 1 and (x >= maxx div 2 + 160 and x <=
		maxx div 2 +
		205)
		and (y >= maxy div 2 - 40 and y <= maxy div
		2) then
	    if sector not= 5 then
		warpengine := true
		impulse := false
		torpedo := false
		phaser := false
		sector := 5
		power := power - 500
		exit
	    end if
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 - 40 and y <= maxy div
		2) then
	    if sector not= 6 then
		warpengine := true
		impulse := false
		torpedo := false
		phaser := false
		sector := 6
		power := power - 500
		exit
	    end if
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    if sector not= 7 then
		warpengine := true
		impulse := false
		torpedo := false
		phaser := false
		sector := 7
		power := power - 500
		exit
	    end if
	elsif click = 1 and (x >= maxx div 2 + 160 and x <=
		maxx div 2 +
		205)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    if sector not= 8 then
		warpengine := true
		impulse := false
		torpedo := false
		phaser := false
		sector := 8
		power := power - 500
		exit
	    end if
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    if sector not= 9 then
		warpengine := true
		impulse := false
		torpedo := false
		phaser := false
		sector := 9
		power := power - 500
		exit
	    end if
	end if
    end loop

    %Collision with stars, also moves away
    imppower := 1
    impdirection := Rand.Int (1, 8)
    if sector = 1 then
	if sectorstars (1) = 1 then
	    if (positionx = stars (1, 0) and positiony = stars (0, 1)) then
		move
	    end if
	elsif sectorstars (1) = 2 then
	    if (positionx = stars (1, 0) and positiony = stars (0, 1)) or (positionx = stars (2, 0) and positiony = stars (0, 2)) then
		move
	    end if
	end if
    elsif sector = 2 then
	if sectorstars (2) = 1 then
	    if (positionx = stars (3, 0) and positiony =
		    stars (0, 3)) then
		move
	    end if
	elsif sectorstars (2) = 2 then
	    if (positionx = stars (3, 0) and positiony =
		    stars (0, 3))
		    or (positionx = stars (4, 0) and positiony =
		    stars (0, 4)) then
		move
	    end if
	end if
    elsif sector = 3 then
	if sectorstars (3) = 1 then
	    if (positionx = stars (5, 0) and positiony =
		    stars (0, 5)) then
		move
	    end if
	elsif sectorstars (3) = 2 then
	    if (positionx = stars (5, 0) and positiony =
		    stars (0, 5))
		    or (positionx = stars (6, 0) and positiony =
		    stars (0, 6)) then
		move
	    end if
	end if
    elsif sector = 4 then
	if sectorstars (4) = 1 then
	    if (positionx = stars (7, 0) and positiony =
		    stars (0, 7)) then
		move
	    end if
	elsif sectorstars (4) = 2 then
	    if (positionx = stars (7, 0) and positiony =
		    stars (0, 7))
		    or (positionx = stars (8, 0) and positiony =
		    stars (0, 8)) then
		move
	    end if
	end if
    elsif sector = 5 then
	if sectorstars (5) = 1 then
	    if (positionx = stars (9, 0) and positiony =
		    stars (0, 9)) then
		move
	    end if
	elsif sectorstars (5) = 2 then
	    if (positionx = stars (9, 0) and positiony =
		    stars (0, 9))
		    or (positionx = stars (10, 0) and positiony
		    =
		    stars (0, 10)) then
		move
	    end if
	end if
    elsif sector = 6 then
	if sectorstars (6) = 1 then
	    if (positionx = stars (11, 0) and positiony =
		    stars (0, 11))
		    then
		move
	    end if
	elsif sectorstars (6) = 2 then
	    if (positionx = stars (11, 0) and positiony =
		    stars (0, 11))
		    or (positionx = stars (12, 0) and positiony
		    =
		    stars (0, 12)) then
		move
	    end if
	end if
    elsif sector = 7 then
	if sectorstars (7) = 1 then
	    if (positionx = stars (13, 0) and positiony =
		    stars (0, 13))
		    then
		move
	    end if
	elsif sectorstars (7) = 2 then
	    if (positionx = stars (13, 0) and positiony =
		    stars (0, 13))
		    or (positionx = stars (14, 0) and positiony
		    =
		    stars (0, 14)) then
		move
	    end if
	end if
    elsif sector = 8 then
	if sectorstars (8) = 1 then
	    if (positionx = stars (15, 0) and positiony =
		    stars (0, 15))
		    then
		move
	    end if
	elsif sectorstars (8) = 2 then
	    if (positionx = stars (15, 0) and positiony =
		    stars (0, 15))
		    or (positionx = stars (16, 0) and positiony
		    =
		    stars (0, 16)) then
		move
	    end if
	end if
    elsif sector = 9 then
	if sectorstars (8) = 1 then
	    if (positionx = stars (17, 0) and positiony =
		    stars (0, 17))
		    then
		move
	    end if
	elsif sectorstars (8) = 2 then
	    if (positionx = stars (17, 0) and positiony =
		    stars (0, 17))
		    or (positionx = stars (18, 0) and positiony
		    =
		    stars (0, 18)) then
		move
	    end if
	end if
    end if
end warp

%Procedure when photon torpedo hits star or Klingon Ship
procedure collisiontorp ()

    %Star collision with Torpedo, if it hits a star, it tells the text screen that it hit one
    if sector = 1 then
	if sectorstars (1) = 1 then
	    if (photonx = stars (1, 0) and photony = stars (0, 1)) then
		torpedohitk := false
		torpedohits := true
		trueorfalse := true
	    end if
	elsif sectorstars (1) = 2 then
	    if (photonx = stars (1, 0) and photony = stars (0, 1)) or (photonx = stars (2, 0) and photony = stars (0, 2)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	end if
    elsif sector = 2 then
	if sectorstars (2) = 1 then
	    if (photonx = stars (3, 0) and photony = stars (0,
		    3)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	elsif sectorstars (2) = 2 then
	    if (photonx = stars (3, 0) and photony = stars (0,
		    3))
		    or (photonx
		    = stars (4, 0) and photony = stars (0, 4))
		    then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	end if
    elsif sector = 3 then
	if sectorstars (3) = 1 then
	    if (photonx = stars (5, 0) and photony = stars (0,
		    5)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	elsif sectorstars (3) = 2 then
	    if (photonx = stars (5, 0) and photony = stars (0,
		    5))
		    or (photonx
		    = stars (6, 0) and photony = stars (0, 6))
		    then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	end if
    elsif sector = 4 then
	if sectorstars (4) = 1 then
	    if (photonx = stars (7, 0) and photony = stars (0,
		    7)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	elsif sectorstars (4) = 2 then
	    if (photonx = stars (7, 0) and photony = stars (0,
		    7))
		    or (photonx
		    = stars (8, 0) and photony = stars (0, 8))
		    then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	end if
    elsif sector = 5 then
	if sectorstars (5) = 1 then
	    if (photonx = stars (9, 0) and photony = stars (0,
		    9)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	elsif sectorstars (5) = 2 then
	    if (photonx = stars (9, 0) and photony = stars (0,
		    9))
		    or (photonx
		    = stars (10, 0) and photony = stars (0, 10))
		    then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	end if
    elsif sector = 6 then
	if sectorstars (6) = 1 then
	    if (photonx = stars (11, 0) and photony = stars (0,
		    11)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	elsif sectorstars (6) = 2 then
	    if (photonx = stars (11, 0) and photony = stars (0,
		    11))
		    or (photonx = stars (12, 0) and photony =
		    stars (0,
		    12)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	end if
    elsif sector = 7 then
	if sectorstars (7) = 1 then
	    if (photonx = stars (13, 0) and photony = stars (0,
		    13)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	elsif sectorstars (7) = 2 then
	    if (photonx = stars (13, 0) and photony = stars (0,
		    13))
		    or (photonx = stars (14, 0) and photony =
		    stars (0,
		    14)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	end if
    elsif sector = 8 then
	if sectorstars (8) = 1 then
	    if (photonx = stars (15, 0) and photony = stars (0,
		    15)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	elsif sectorstars (8) = 2 then
	    if (photonx = stars (15, 0) and photony = stars (0,
		    15))
		    or (photonx = stars (16, 0) and photony =
		    stars (0,
		    16)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	end if
    elsif sector = 9 then
	if sectorstars (8) = 1 then
	    if (photonx = stars (17, 0) and photony = stars (0,
		    17)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	elsif sectorstars (8) = 2 then
	    if (photonx = stars (17, 0) and photony = stars (0,
		    17))
		    or (photonx = stars (18, 0) and photony =
		    stars (0,
		    18)) then
		trueorfalse := true
		torpedohitk := false
		torpedohits := true
	    end if
	end if
    end if

    %Klingon collision with Torpedo, tells the text screen if it hit one
    if sector = 1 then
	if (klingonx (1) = photonx and klingony (1) = photony)
		then
	    if klingonhealth (1) not= 1200 then
		klingonhealth (1) := klingonhealth (1) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 1
	    end if
	elsif (klingonx (2) = photonx and klingony (2) =
		photony) then
	    if klingonhealth (2) not= 1200 then
		klingonhealth (2) := klingonhealth (2) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 2
	    end if
	elsif (klingonx (3) = photonx and klingony (3) =
		photony) then
	    if klingonhealth (3) not= 1200 then
		klingonhealth (3) := klingonhealth (3) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 3
	    end if
	elsif (klingonx (4) = photonx and klingony (4) =
		photony) then
	    if klingonhealth (5) not= 1200 then
		klingonhealth (4) := klingonhealth (4) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 4
	    end if
	end if
    elsif sector = 2 then
	if (klingonx (5) = photonx and klingony (5) = photony)
		then
	    if klingonhealth (5) not= 1200 then
		klingonhealth (5) := klingonhealth (5) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 1
	    end if
	elsif (klingonx (6) = photonx and klingony (6) =
		photony) then
	    if klingonhealth (6) not= 1200 then
		klingonhealth (6) := klingonhealth (6) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 2
	    end if
	elsif (klingonx (7) = photonx and klingony (7) =
		photony) then
	    if klingonhealth (7) not= 1200 then
		klingonhealth (7) := klingonhealth (7) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 3
	    end if
	elsif (klingonx (8) = photonx and klingony (8) =
		photony) then
	    if klingonhealth (8) not= 1200 then
		klingonhealth (8) := klingonhealth (8) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 4
	    end if
	end if
    elsif sector = 3 then
	if (klingonx (9) = photonx and klingony (9) = photony)
		then
	    if klingonhealth (9) not= 1200 then
		klingonhealth (9) := klingonhealth (9) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 1
	    end if
	elsif (klingonx (10) = photonx and klingony (10) =
		photony) then
	    if klingonhealth (10) not= 1200 then
		klingonhealth (10) := klingonhealth (10) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 2
	    end if
	elsif (klingonx (11) = photonx and klingony (11) =
		photony) then
	    if klingonhealth (11) not= 1200 then
		klingonhealth (11) := klingonhealth (11) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 3
	    end if
	elsif (klingonx (12) = photonx and klingony (12) =
		photony) then
	    if klingonhealth (12) not= 1200 then
		klingonhealth (12) := klingonhealth (12) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 4
	    end if
	end if
    elsif sector = 4 then
	if (klingonx (13) = photonx and klingony (13) =
		photony) then
	    if klingonhealth (13) not= 1200 then
		klingonhealth (13) := klingonhealth (13) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 1
	    end if
	elsif (klingonx (14) = photonx and klingony (14) =
		photony) then
	    if klingonhealth (14) not= 1200 then
		klingonhealth (14) := klingonhealth (14) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 2
	    end if
	elsif (klingonx (15) = photonx and klingony (15) =
		photony) then
	    if klingonhealth (15) not= 1200 then
		klingonhealth (15) := klingonhealth (15) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 3
	    end if
	elsif (klingonx (16) = photonx and klingony (16) =
		photony) then
	    if klingonhealth (16) not= 1200 then
		klingonhealth (16) := klingonhealth (16) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 4
	    end if
	end if
    elsif sector = 5 then
	if (klingonx (17) = photonx and klingony (17) =
		photony) then
	    if klingonhealth (17) not= 1200 then
		klingonhealth (17) := klingonhealth (17) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 1
	    end if
	elsif (klingonx (18) = photonx and klingony (18) =
		photony) then
	    if klingonhealth (18) not= 1200 then
		klingonhealth (18) := klingonhealth (18) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 2
	    end if
	elsif (klingonx (19) = photonx and klingony (19) =
		photony) then
	    if klingonhealth (19) not= 1200 then
		klingonhealth (19) := klingonhealth (19) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 3
	    end if
	elsif (klingonx (20) = photonx and klingony (20) =
		photony) then
	    if klingonhealth (20) not= 1200 then
		klingonhealth (20) := klingonhealth (20) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 4
	    end if
	end if
    elsif sector = 6 then
	if (klingonx (21) = photonx and klingony (21) =
		photony) then
	    if klingonhealth (21) not= 1200 then
		klingonhealth (21) := klingonhealth (21) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 1
	    end if
	elsif (klingonx (22) = photonx and klingony (22) =
		photony) then
	    if klingonhealth (22) not= 1200 then
		klingonhealth (22) := klingonhealth (22) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 2
	    end if
	elsif (klingonx (23) = photonx and klingony (23) =
		photony) then
	    if klingonhealth (23) not= 1200 then
		klingonhealth (23) := klingonhealth (23) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 3
	    end if
	elsif (klingonx (24) = photonx and klingony (24) =
		photony) then
	    if klingonhealth (24) not= 1200 then
		klingonhealth (24) := klingonhealth (24) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 4
	    end if
	end if
    elsif sector = 7 then
	if (klingonx (25) = photonx and klingony (25) =
		photony) then
	    if klingonhealth (25) not= 1200 then
		klingonhealth (25) := klingonhealth (25) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 1
	    end if
	elsif (klingonx (26) = photonx and klingony (26) =
		photony) then
	    if klingonhealth (26) not= 1200 then
		klingonhealth (26) := klingonhealth (26) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 2
	    end if
	elsif (klingonx (27) = photonx and klingony (27) =
		photony) then
	    if klingonhealth (27) not= 1200 then
		klingonhealth (27) := klingonhealth (27) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 3
	    end if
	elsif (klingonx (28) = photonx and klingony (28) =
		photony) then
	    if klingonhealth (28) not= 1200 then
		klingonhealth (28) := klingonhealth (28) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 4
	    end if
	end if
    elsif sector = 8 then
	if (klingonx (29) = photonx and klingony (29) =
		photony) then
	    if klingonhealth (29) not= 1200 then
		klingonhealth (29) := klingonhealth (29) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 1
	    end if
	elsif (klingonx (30) = photonx and klingony (30) =
		photony) then
	    if klingonhealth (30) not= 1200 then
		klingonhealth (30) := klingonhealth (30) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 2
	    end if
	elsif (klingonx (31) = photonx and klingony (31) =
		photony) then
	    if klingonhealth (31) not= 1200 then
		klingonhealth (31) := klingonhealth (31) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 3
	    end if
	elsif (klingonx (32) = photonx and klingony (32) =
		photony) then
	    if klingonhealth (32) not= 1200 then
		klingonhealth (32) := klingonhealth (32) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 4
	    end if
	end if
    elsif sector = 9 then
	if (klingonx (33) = photonx and klingony (33) =
		photony) then
	    if klingonhealth (33) not= 1200 then
		klingonhealth (33) := klingonhealth (33) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 1
	    end if
	elsif (klingonx (34) = photonx and klingony (34) =
		photony) then
	    if klingonhealth (34) not= 1200 then
		klingonhealth (34) := klingonhealth (34) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 2
	    end if
	elsif (klingonx (35) = photonx and klingony (35) =
		photony) then
	    if klingonhealth (35) not= 1200 then
		klingonhealth (35) := klingonhealth (35) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 3
	    end if
	elsif (klingonx (36) = photonx and klingony (36) =
		photony) then
	    if klingonhealth (36) not= 1200 then
		klingonhealth (36) := klingonhealth (36) - 500
		trueorfalse := true
		torpedohitk := true
		torpedohits := false
		kshiphit := 4
	    end if
	end if
    end if
end collisiontorp

%Photon Torpedoes Procedure
procedure torpedoes ()
    cls
    userinterface
    status
    objects

    Draw.FillBox (maxx div 2 + 75, 10, maxx - 25, 40, blue)
    Draw.Box (maxx div 2 + 75, 10, maxx - 25, 40, white)
    Draw.Text ("CANCEL", maxx div 2 + 145, 20, clickfont, white)
    Draw.Text ("Shoot in Which Direction?", maxx div 2 + 85,
	maxy - 20,
	clickfont, white)

    %Direction Boxes
    Draw.Box (maxx div 2 + 100, maxy div 2 + 20, maxx div 2 +
	145, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 1
    Draw.Box (maxx div 2 + 160, maxy div 2 + 20, maxx div 2 +
	205, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 2
    Draw.Box (maxx div 2 + 220, maxy div 2 + 20, maxx div 2 +
	265, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 3
    Draw.Box (maxx div 2 + 100, maxy div 2 - 40, maxx div 2 +
	145, maxy div
	2,
	white)                                                                                                                                                    % Box 4
    Draw.Box (maxx div 2 + 220, maxy div 2 - 40, maxx div 2 +
	265, maxy div
	2,
	white)                                                                                                                                                    % Box 5
    Draw.Box (maxx div 2 + 100, maxy div 2 - 100, maxx div 2 +
	145, maxy
	div 2
	- 60, white)                                                                                                                                                    % Box 6
    Draw.Box (maxx div 2 + 160, maxy div 2 - 100, maxx div 2 +
	205, maxy
	div 2
	- 60, white)                                                                                                                                                    % Box 7
    Draw.Box (maxx div 2 + 220, maxy div 2 - 100, maxx div 2 +
	265, maxy
	div 2
	- 60, white)                                                                                                                                                    % Box 8

    %Direction Text
    Draw.Text ("Down", maxx div 2 + 167, maxy div 2 - 80,
	smallfont, white)
    Draw.Text ("Up", maxx div 2 + 175, maxy div 2 + 40,
	smallfont, white)
    Draw.Text ("Left", maxx div 2 + 110, maxy div 2 - 20,
	smallfont, white)
    Draw.Text ("Right", maxx div 2 + 228, maxy div 2 - 20,
	smallfont, white)
    Draw.Text ("Up-Left", maxx div 2 + 102, maxy div 2 + 40,
	smallfont,
	white)
    Draw.Text ("Up-Right", maxx div 2 + 220, maxy div 2 + 40,
	smallfont,
	white)
    Draw.Text ("Down", maxx div 2 + 107, maxy div 2 - 93,
	smallfont, white)
    Draw.Text ("Left", maxx div 2 + 112, maxy div 2 - 80,
	smallfont, white)
    Draw.Text ("Down", maxx div 2 + 228, maxy div 2 - 93,
	smallfont, white)
    Draw.Text ("Right", maxx div 2 + 228, maxy div 2 - 80,
	smallfont, white)

    loop
	Mouse.Where (x, y, click)
	exit when click = 0
    end loop

    %User picks which direction the torpedo is firing here
    loop
	Mouse.Where (x, y, click)
	if click = 1 and (x >= maxx div 2 + 75 and x <= maxx -
		25) and (y
		>= 10
		and y <= 40) then
	    torpdirection := 0
	    torpedo := false
	    exit
	elsif click = 1 and (x >= maxx div 2 + 160 and x <=
		maxx div 2 +
		205)
		and (y >= maxy div 2 + 20 and y <= maxy div 2
		+ 60) then
	    impulse := false
	    warpengine := false
	    torpdirection := 2
	    torpedo := true
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 + 20 and y <= maxy div 2
		+ 60) then
	    impulse := false
	    warpengine := false
	    torpdirection := 1
	    torpedo := true
	    exit
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 + 20 and y <= maxy div 2
		+ 60) then
	    impulse := false
	    warpengine := false
	    torpdirection := 3
	    torpedo := true
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 - 40 and y <= maxy div
		2) then
	    impulse := false
	    warpengine := false
	    torpdirection := 4
	    torpedo := true
	    exit
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 - 40 and y <= maxy div
		2) then
	    impulse := false
	    warpengine := false
	    torpdirection := 5
	    torpedo := true
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    impulse := false
	    warpengine := false
	    torpdirection := 6
	    torpedo := true
	    exit
	elsif click = 1 and (x >= maxx div 2 + 160 and x <=
		maxx div 2 +
		205)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    impulse := false
	    warpengine := false
	    torpdirection := 7
	    torpedo := true
	    exit
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 - 100 and y <= maxy div
		2 - 60) then
	    impulse := false
	    warpengine := false
	    torpdirection := 8
	    torpedo := true
	    exit
	end if
    end loop

    %Torpedo animation
    photonx := positionx
    photony := positiony
    photonsize := 8
    photoncolor := 1
    trueorfalse := false
    if torpdirection not= 0 then
	if torpdirection = 1 then
	    loop
		cls
		userinterface
		status
		objects
		Draw.FillOval (map (photonx, 0), map (0,
		    photony), 8, 8,
		    red)
		photonx := photonx - 1
		photony := photony - 1
		delay (300)
		collisiontorp
		if photonx >= 9 or photonx <= 0 or photony <= 0 or photony >= 9 then
		    torpedohitk := false
		    torpedohits := false
		end if
		exit when photonx >= 9 or photonx <= 0 or photony <= 0 or photony >= 9 or trueorfalse = true
	    end loop
	elsif torpdirection = 2 then
	    loop
		cls
		userinterface
		status
		objects
		Draw.FillOval (map (photonx, 0), map (0,
		    photony), 8, 8,
		    red)
		photony := photony - 1
		delay (300)
		collisiontorp
		if photonx >= 9 or photonx <= 0 or photony <= 0 or photony >= 9 then
		    torpedohitk := false
		    torpedohits := false
		end if
		exit when photonx >= 9 or photonx <= 0 or photony <= 0 or photony >= 9 or trueorfalse = true
	    end loop
	elsif torpdirection = 3 then
	    loop
		cls
		userinterface
		status
		objects
		Draw.FillOval (map (photonx, 0), map (0,
		    photony), 8, 8,
		    red)
		photonx := photonx + 1
		photony := photony - 1
		delay (300)
		collisiontorp
		if photonx >= 9 or photonx <= 0 or photony <= 0 or photony >= 9 then
		    torpedohitk := false
		    torpedohits := false
		end if
		exit when photonx >= 9 or photonx <= 0 or
		    photony <= 0 or
		    photony >= 9 or trueorfalse = true
	    end loop
	elsif torpdirection = 4 then
	    loop
		cls
		userinterface
		status
		objects
		Draw.FillOval (map (photonx, 0), map (0,
		    photony), 8, 8,
		    red)
		photonx := photonx - 1
		delay (300)
		collisiontorp
		if photonx >= 9 or photonx <= 0 or photony <= 0 or photony >= 9 then
		    torpedohitk := false
		    torpedohits := false
		end if
		exit when photonx >= 9 or photonx <= 0 or
		    photony <= 0 or
		    photony >= 9 or trueorfalse = true
	    end loop
	elsif torpdirection = 5 then
	    loop
		cls
		userinterface
		status
		objects
		Draw.FillOval (map (photonx, 0), map (0,
		    photony), 8, 8,
		    red)
		photonx := photonx + 1
		delay (300)
		collisiontorp
		if photonx >= 9 or photonx <= 0 or photony <= 0 or photony >= 9 then
		    torpedohitk := false
		    torpedohits := false
		end if
		exit when photonx >= 9 or photonx <= 0 or
		    photony <= 0 or
		    photony >= 9 or trueorfalse = true
	    end loop
	elsif torpdirection = 6 then
	    loop
		cls
		userinterface
		status
		objects
		Draw.FillOval (map (photonx, 0), map (0,
		    photony), 8, 8,
		    red)
		photonx := photonx - 1
		photony := photony + 1
		delay (300)
		collisiontorp
		if photonx >= 9 or photonx <= 0 or photony <= 0 or photony >= 9 then
		    torpedohitk := false
		    torpedohits := false
		end if
		exit when photonx >= 9 or photonx <= 0 or
		    photony <= 0 or
		    photony >= 9 or trueorfalse = true
	    end loop
	elsif torpdirection = 7 then
	    loop
		cls
		userinterface
		status
		objects
		Draw.FillOval (map (photonx, 0), map (0,
		    photony), 8, 8,
		    red)
		photony := photony + 1
		delay (300)
		collisiontorp
		if photonx >= 9 or photonx <= 0 or photony <= 0 or photony >= 9 then
		    torpedohitk := false
		    torpedohits := false
		end if
		exit when photonx >= 9 or photonx <= 0 or
		    photony <= 0 or
		    photony >= 9 or trueorfalse = true
	    end loop
	elsif torpdirection = 8 then
	    loop
		cls
		userinterface
		status
		objects
		Draw.FillOval (map (photonx, 0), map (0,
		    photony), 8, 8,
		    red)
		photonx := photonx + 1
		photony := photony + 1
		delay (300)
		collisiontorp
		if photonx >= 9 or photonx <= 0 or photony <= 0 or photony >= 9 then
		    torpedohitk := false
		    torpedohits := false
		end if
		exit when photonx >= 9 or photonx <= 0 or
		    photony <= 0 or
		    photony >= 9 or trueorfalse = true
	    end loop
	end if
	if photonx = 0 then
	    map (0, 0) := 70
	elsif photony = 0 then
	    map (0, 0) := 375
	end if
	for i : 1 .. 20
	    cls
	    userinterface
	    status
	    objects
	    Draw.FillOval (map (photonx, 0), map (0, photony),
		photonsize,
		photonsize, photoncolor)
	    photonsize := photonsize + 1
	    photoncolor := photoncolor + 1
	    delay (10)
	end for
    end if
end torpedoes

%Phaser damage animation procedure, creates explosion animation
procedure phaserdamage ()
    photonsize := 8
    photoncolor := 1
    for i : 1 .. 20
	cls
	userinterface
	status
	objects
	Draw.FillOval (map (phaserexplosionx, 0), map (0,
	    phaserexplosiony),
	    photonsize, photonsize, photoncolor)
	photonsize := photonsize + 1
	photoncolor := photoncolor + 1
	delay (10)
    end for
end phaserdamage

%Phasers Procedure
procedure phasers ()
    cls
    userinterface
    status
    objects

    Draw.FillBox (maxx div 2 + 75, 10, maxx - 25, 40, blue)
    Draw.Box (maxx div 2 + 75, 10, maxx - 25, 40, white)
    Draw.Text ("CANCEL", maxx div 2 + 145, 20, clickfont, white)
    Draw.Text ("How Much Power?", maxx div 2 + 115, maxy - 20,
	clickfont,
	white)

    %Boxes
    Draw.Box (maxx div 2 + 100, maxy div 2 + 20, maxx div 2 +
	145, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 1
    Draw.Box (maxx div 2 + 160, maxy div 2 + 20, maxx div 2 +
	205, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 2
    Draw.Box (maxx div 2 + 220, maxy div 2 + 20, maxx div 2 +
	265, maxy div
	2 +
	60, white)                                                                                                                                                     % Box 3

    %Numbers
    Draw.Text ("100", maxx div 2 + 110, maxy div 2 + 40,
	clickfont, white)
    Draw.Text ("300", maxx div 2 + 172, maxy div 2 + 40,
	clickfont, white)
    Draw.Text ("500", maxx div 2 + 230, maxy div 2 + 40,
	clickfont, white)
    loop
	Mouse.Where (x, y, click)
	exit when click = 0
    end loop

    %Deciding how much power the user will fire
    loop
	Mouse.Where (x, y, click)
	if click = 1 and (x >= maxx div 2 + 75 and x <= maxx -
		25) and (y
		>= 10
		and y <= 40) then
	    phaserpower := 0
	    exit
	elsif click = 1 and (x >= maxx div 2 + 160 and x <=
		maxx div 2 +
		205)
		and (y >= maxy div 2 + 20 and y <= maxy div 2
		+ 60) then
	    phaserpower := 300
	    warpengine := false
	    impulse := false
	    torpedo := false
	    exit
	elsif click = 1 and (x >= maxx div 2 + 100 and x <=
		maxx div 2 +
		145)
		and (y >= maxy div 2 + 20 and y <= maxy div 2
		+ 60) then
	    phaserpower := 100
	    warpengine := false
	    impulse := false
	    torpedo := false
	    exit
	elsif click = 1 and (x >= maxx div 2 + 220 and x <=
		maxx div 2 +
		265)
		and (y >= maxy div 2 + 20 and y <= maxy div 2
		+ 60) then
	    phaserpower := 500
	    warpengine := false
	    impulse := false
	    torpedo := false
	    exit
	end if
    end loop

    %If phasers fired or not
    if phaserpower > 0 then
	phaser := true
    else
	phaser := false
    end if
    power := power - phaserpower
    phasersize := 8
    phasercolor := 1

    %Phaser animation
    if phaserpower not= 0 then
	for e : 1 .. 150
	    cls
	    userinterface
	    status
	    objects
	    Draw.FillOval (map (positionx, 0), map (0,
		positiony),
		phasersize,
		phasersize, phasercolor)
	    phasersize := phasersize + 1
	    phasercolor := phasercolor + 1
	    delay (5)
	end for

	%Damage to Klingons in the sector, divides the power by the number of Klingons in the sector (seckleft)
	photonsize := 8
	photoncolor := 1
	if sector = 1 then
	    if seckleft (1) not= 0 then
		phaserpower := phaserpower div seckleft (1)
	    end if
	    if seck (1) = 1 then
		if klingonhealth (1) not= 0 then
		    klingonhealth (1) := klingonhealth (1) - phaserpower
		end if
		phaserexplosionx := klingonx (1)
		phaserexplosiony := klingony (1)
		phaserdamage
	    elsif seck (1) = 2 then
		if klingonhealth (1) not= 0 then
		    klingonhealth (1) := klingonhealth (1) - phaserpower
		end if
		phaserexplosionx := klingonx (1)
		phaserexplosiony := klingony (1)
		phaserdamage
		if klingonhealth (2) not= 0 then
		    klingonhealth (2) := klingonhealth (2) - phaserpower
		end if
		phaserexplosionx := klingonx (2)
		phaserexplosiony := klingony (2)
		phaserdamage
	    elsif seck (1) = 3 then
		if klingonhealth (1) not= 0 then
		    klingonhealth (1) := klingonhealth (1) -
			phaserpower
		end if
		phaserexplosionx := klingonx (1)
		phaserexplosiony := klingony (1)
		phaserdamage
		if klingonhealth (2) not= 0 then
		    klingonhealth (2) := klingonhealth (2) -
			phaserpower
		end if
		phaserexplosionx := klingonx (2)
		phaserexplosiony := klingony (2)
		phaserdamage
		if klingonhealth (3) not= 0 then
		    klingonhealth (3) := klingonhealth (3) -
			phaserpower
		end if
		phaserexplosionx := klingonx (3)
		phaserexplosiony := klingony (3)
		phaserdamage
	    elsif seck (1) = 4 then
		if klingonhealth (1) not= 0 then
		    klingonhealth (1) := klingonhealth (1) -
			phaserpower
		end if
		phaserexplosionx := klingonx (1)
		phaserexplosiony := klingony (1)
		phaserdamage
		if klingonhealth (2) not= 0 then
		    klingonhealth (2) := klingonhealth (2) - phaserpower
		end if
		phaserexplosionx := klingonx (2)
		phaserexplosiony := klingony (2)
		phaserdamage
		if klingonhealth (3) not= 0 then
		    klingonhealth (3) := klingonhealth (3) - phaserpower
		end if
		phaserexplosionx := klingonx (3)
		phaserexplosiony := klingony (3)
		phaserdamage
		if klingonhealth (4) not= 0 then
		    klingonhealth (4) := klingonhealth (4) - phaserpower
		end if
		phaserexplosionx := klingonx (4)
		phaserexplosiony := klingony (4)
		phaserdamage
	    end if
	elsif sector = 2 then
	    if seckleft (2) not= 0 then
		phaserpower := phaserpower div seckleft (2)
	    end if
	    if seck (2) = 1 then
		if klingonhealth (5) not= 0 then
		    klingonhealth (5) := klingonhealth (5) -
			phaserpower
		end if
		phaserexplosionx := klingonx (5)
		phaserexplosiony := klingony (5)
		phaserdamage
	    elsif seck (2) = 2 then
		phaserpower := phaserpower div 2
		if klingonhealth (5) not= 0 then
		    klingonhealth (5) := klingonhealth (5) -
			phaserpower
		end if
		phaserexplosionx := klingonx (5)
		phaserexplosiony := klingony (5)
		phaserdamage
		if klingonhealth (6) not= 0 then
		    klingonhealth (6) := klingonhealth (6) -
			phaserpower
		end if
		phaserexplosionx := klingonx (6)
		phaserexplosiony := klingony (6)
		phaserdamage
	    elsif seck (2) = 3 then
		if klingonhealth (5) not= 0 then
		    klingonhealth (5) := klingonhealth (5) -
			phaserpower
		end if
		phaserexplosionx := klingonx (5)
		phaserexplosiony := klingony (5)
		phaserdamage
		if klingonhealth (6) not= 0 then
		    klingonhealth (6) := klingonhealth (6) -
			phaserpower
		end if
		phaserexplosionx := klingonx (6)
		phaserexplosiony := klingony (6)
		phaserdamage
		if klingonhealth (7) not= 0 then
		    klingonhealth (7) := klingonhealth (7) -
			phaserpower
		end if
		phaserexplosionx := klingonx (7)
		phaserexplosiony := klingony (7)
		phaserdamage
	    elsif seck (2) = 4 then
		if klingonhealth (5) not= 0 then
		    klingonhealth (5) := klingonhealth (5) -
			phaserpower
		end if
		phaserexplosionx := klingonx (5)
		phaserexplosiony := klingony (5)
		phaserdamage
		if klingonhealth (6) not= 0 then
		    klingonhealth (6) := klingonhealth (6) -
			phaserpower
		end if
		phaserexplosionx := klingonx (6)
		phaserexplosiony := klingony (6)
		phaserdamage
		if klingonhealth (7) not= 0 then
		    klingonhealth (7) := klingonhealth (7) -
			phaserpower
		end if
		phaserexplosionx := klingonx (7)
		phaserexplosiony := klingony (7)
		phaserdamage
		if klingonhealth (8) not= 0 then
		    klingonhealth (8) := klingonhealth (8) -
			phaserpower
		end if
		phaserexplosionx := klingonx (8)
		phaserexplosiony := klingony (8)
		phaserdamage
	    end if
	elsif sector = 3 then
	    if seckleft (3) not= 0 then
		phaserpower := phaserpower div seckleft (3)
	    end if
	    if seck (3) = 1 then
		if klingonhealth (9) not= 0 then
		    klingonhealth (9) := klingonhealth (9) -
			phaserpower
		end if
		phaserexplosionx := klingonx (9)
		phaserexplosiony := klingony (9)
		phaserdamage
	    elsif seck (3) = 2 then
		if klingonhealth (9) not= 0 then
		    klingonhealth (9) := klingonhealth (9) -
			phaserpower
		end if
		phaserexplosionx := klingonx (9)
		phaserexplosiony := klingony (9)
		phaserdamage
		if klingonhealth (10) not= 0 then
		    klingonhealth (10) := klingonhealth (10) -
			phaserpower
		end if
		phaserexplosionx := klingonx (10)
		phaserexplosiony := klingony (10)
		phaserdamage
	    elsif seck (3) = 3 then
		if klingonhealth (9) not= 0 then
		    klingonhealth (9) := klingonhealth (9) -
			phaserpower
		end if
		phaserexplosionx := klingonx (9)
		phaserexplosiony := klingony (9)
		phaserdamage
		if klingonhealth (10) not= 0 then
		    klingonhealth (10) := klingonhealth (10) -
			phaserpower
		end if
		phaserexplosionx := klingonx (10)
		phaserexplosiony := klingony (10)
		phaserdamage
		if klingonhealth (11) not= 0 then
		    klingonhealth (11) := klingonhealth (11) -
			phaserpower
		end if
		phaserexplosionx := klingonx (11)
		phaserexplosiony := klingony (11)
		phaserdamage
	    elsif seck (3) = 4 then
		if klingonhealth (9) not= 0 then
		    klingonhealth (9) := klingonhealth (9) -
			phaserpower
		end if
		phaserexplosionx := klingonx (9)
		phaserexplosiony := klingony (9)
		phaserdamage
		if klingonhealth (10) not= 0 then
		    klingonhealth (10) := klingonhealth (10) -
			phaserpower
		end if
		phaserexplosionx := klingonx (10)
		phaserexplosiony := klingony (10)
		phaserdamage
		if klingonhealth (11) not= 0 then
		    klingonhealth (11) := klingonhealth (11) -
			phaserpower
		end if
		phaserexplosionx := klingonx (11)
		phaserexplosiony := klingony (11)
		phaserdamage
		if klingonhealth (12) not= 0 then
		    klingonhealth (12) := klingonhealth (12) -
			phaserpower
		end if
		phaserexplosionx := klingonx (12)
		phaserexplosiony := klingony (12)
		phaserdamage
	    end if
	elsif sector = 4 then
	    if seckleft (4) not= 0 then
		phaserpower := phaserpower div seckleft (4)
	    end if
	    if seck (4) = 1 then
		if klingonhealth (13) not= 0 then
		    klingonhealth (13) := klingonhealth (13) -
			phaserpower
		end if
		phaserexplosionx := klingonx (13)
		phaserexplosiony := klingony (13)
		phaserdamage
	    elsif seck (4) = 2 then
		if klingonhealth (13) not= 0 then
		    klingonhealth (13) := klingonhealth (13) -
			phaserpower
		end if
		phaserexplosionx := klingonx (13)
		phaserexplosiony := klingony (13)
		phaserdamage
		if klingonhealth (14) not= 0 then
		    klingonhealth (14) := klingonhealth (14) -
			phaserpower
		end if
		phaserexplosionx := klingonx (14)
		phaserexplosiony := klingony (14)
		phaserdamage
	    elsif seck (4) = 3 then
		if klingonhealth (13) not= 0 then
		    klingonhealth (13) := klingonhealth (13) -
			phaserpower
		end if
		phaserexplosionx := klingonx (13)
		phaserexplosiony := klingony (13)
		phaserdamage
		if klingonhealth (14) not= 0 then
		    klingonhealth (14) := klingonhealth (14) -
			phaserpower
		end if
		phaserexplosionx := klingonx (14)
		phaserexplosiony := klingony (14)
		phaserdamage
		if klingonhealth (15) not= 0 then
		    klingonhealth (15) := klingonhealth (15) -
			phaserpower
		end if
		phaserexplosionx := klingonx (15)
		phaserexplosiony := klingony (15)
		phaserdamage
	    elsif seck (4) = 4 then
		if klingonhealth (13) not= 0 then
		    klingonhealth (13) := klingonhealth (13) -
			phaserpower
		end if
		phaserexplosionx := klingonx (13)
		phaserexplosiony := klingony (13)
		phaserdamage
		if klingonhealth (14) not= 0 then
		    klingonhealth (14) := klingonhealth (14) -
			phaserpower
		end if
		phaserexplosionx := klingonx (14)
		phaserexplosiony := klingony (14)
		phaserdamage
		if klingonhealth (15) not= 0 then
		    klingonhealth (15) := klingonhealth (15) -
			phaserpower
		end if
		phaserexplosionx := klingonx (15)
		phaserexplosiony := klingony (15)
		phaserdamage
		if klingonhealth (16) not= 0 then
		    klingonhealth (16) := klingonhealth (16) -
			phaserpower
		end if
		phaserexplosionx := klingonx (16)
		phaserexplosiony := klingony (16)
		phaserdamage
	    end if
	elsif sector = 5 then
	    if seckleft (5) not= 0 then
		phaserpower := phaserpower div seckleft (5)
	    end if
	    if seck (5) = 1 then
		if klingonhealth (17) not= 0 then
		    klingonhealth (17) := klingonhealth (17) -
			phaserpower
		end if
		phaserexplosionx := klingonx (17)
		phaserexplosiony := klingony (17)
		phaserdamage
	    elsif seck (5) = 2 then
		if klingonhealth (17) not= 0 then
		    klingonhealth (17) := klingonhealth (17) -
			phaserpower
		end if
		phaserexplosionx := klingonx (17)
		phaserexplosiony := klingony (17)
		phaserdamage
		if klingonhealth (18) not= 0 then
		    klingonhealth (18) := klingonhealth (18) -
			phaserpower
		end if
		phaserexplosionx := klingonx (18)
		phaserexplosiony := klingony (18)
		phaserdamage
	    elsif seck (5) = 3 then
		if klingonhealth (17) not= 0 then
		    klingonhealth (17) := klingonhealth (17) -
			phaserpower
		end if
		phaserexplosionx := klingonx (17)
		phaserexplosiony := klingony (17)
		phaserdamage
		if klingonhealth (18) not= 0 then
		    klingonhealth (18) := klingonhealth (18) -
			phaserpower
		end if
		phaserexplosionx := klingonx (18)
		phaserexplosiony := klingony (18)
		phaserdamage
		if klingonhealth (19) not= 0 then
		    klingonhealth (19) := klingonhealth (19) -
			phaserpower
		end if
		phaserexplosionx := klingonx (19)
		phaserexplosiony := klingony (19)
		phaserdamage
	    elsif seck (5) = 4 then
		if klingonhealth (17) not= 0 then
		    klingonhealth (17) := klingonhealth (17) -
			phaserpower
		end if
		phaserexplosionx := klingonx (17)
		phaserexplosiony := klingony (17)
		phaserdamage
		if klingonhealth (18) not= 0 then
		    klingonhealth (18) := klingonhealth (18) -
			phaserpower
		end if
		phaserexplosionx := klingonx (18)
		phaserexplosiony := klingony (18)
		phaserdamage
		if klingonhealth (19) not= 0 then
		    klingonhealth (19) := klingonhealth (19) -
			phaserpower
		end if
		phaserexplosionx := klingonx (19)
		phaserexplosiony := klingony (19)
		phaserdamage
		if klingonhealth (20) not= 0 then
		    klingonhealth (20) := klingonhealth (20) -
			phaserpower
		end if
		phaserexplosionx := klingonx (20)
		phaserexplosiony := klingony (20)
		phaserdamage
	    end if
	elsif sector = 6 then
	    if seckleft (6) not= 0 then
		phaserpower := phaserpower div seckleft (6)
	    end if
	    if seck (6) = 1 then
		if klingonhealth (21) not= 0 then
		    klingonhealth (21) := klingonhealth (21) -
			phaserpower
		end if
		phaserexplosionx := klingonx (21)
		phaserexplosiony := klingony (21)
		phaserdamage
	    elsif seck (6) = 2 then
		if klingonhealth (21) not= 0 then
		    klingonhealth (21) := klingonhealth (21) -
			phaserpower
		end if
		phaserexplosionx := klingonx (21)
		phaserexplosiony := klingony (21)
		phaserdamage
		if klingonhealth (22) not= 0 then
		    klingonhealth (22) := klingonhealth (22) -
			phaserpower
		end if
		phaserexplosionx := klingonx (22)
		phaserexplosiony := klingony (22)
		phaserdamage
	    elsif seck (6) = 3 then
		if klingonhealth (21) not= 0 then
		    klingonhealth (21) := klingonhealth (21) -
			phaserpower
		end if
		phaserexplosionx := klingonx (21)
		phaserexplosiony := klingony (21)
		phaserdamage
		if klingonhealth (22) not= 0 then
		    klingonhealth (22) := klingonhealth (22) -
			phaserpower
		end if
		phaserexplosionx := klingonx (22)
		phaserexplosiony := klingony (22)
		phaserdamage
		if klingonhealth (23) not= 0 then
		    klingonhealth (23) := klingonhealth (23) -
			phaserpower
		end if
		phaserexplosionx := klingonx (23)
		phaserexplosiony := klingony (23)
		phaserdamage
	    elsif seck (6) = 4 then
		if klingonhealth (21) not= 0 then
		    klingonhealth (21) := klingonhealth (21) -
			phaserpower
		end if
		phaserexplosionx := klingonx (21)
		phaserexplosiony := klingony (21)
		phaserdamage
		if klingonhealth (22) not= 0 then
		    klingonhealth (22) := klingonhealth (22) -
			phaserpower
		end if
		phaserexplosionx := klingonx (22)
		phaserexplosiony := klingony (22)
		phaserdamage
		if klingonhealth (23) not= 0 then
		    klingonhealth (23) := klingonhealth (23) -
			phaserpower
		end if
		phaserexplosionx := klingonx (23)
		phaserexplosiony := klingony (23)
		phaserdamage
		if klingonhealth (24) not= 0 then
		    klingonhealth (24) := klingonhealth (24) -
			phaserpower
		end if
		phaserexplosionx := klingonx (24)
		phaserexplosiony := klingony (24)
		phaserdamage
	    end if
	elsif sector = 7 then
	    if seckleft (7) not= 0 then
		phaserpower := phaserpower div seckleft (7)
	    end if
	    if seck (7) = 1 then
		if klingonhealth (25) not= 0 then
		    klingonhealth (25) := klingonhealth (25) -
			phaserpower
		end if
		phaserexplosionx := klingonx (25)
		phaserexplosiony := klingony (25)
		phaserdamage
	    elsif seck (7) = 2 then
		if klingonhealth (25) not= 0 then
		    klingonhealth (25) := klingonhealth (25) -
			phaserpower
		end if
		phaserexplosionx := klingonx (25)
		phaserexplosiony := klingony (25)
		phaserdamage
		if klingonhealth (26) not= 0 then
		    klingonhealth (26) := klingonhealth (26) -
			phaserpower
		end if
		phaserexplosionx := klingonx (26)
		phaserexplosiony := klingony (26)
		phaserdamage
	    elsif seck (7) = 3 then
		if klingonhealth (25) not= 0 then
		    klingonhealth (25) := klingonhealth (25) -
			phaserpower
		end if
		phaserexplosionx := klingonx (25)
		phaserexplosiony := klingony (25)
		phaserdamage
		if klingonhealth (26) not= 0 then
		    klingonhealth (26) := klingonhealth (26) -
			phaserpower
		end if
		phaserexplosionx := klingonx (26)
		phaserexplosiony := klingony (26)
		phaserdamage
		if klingonhealth (27) not= 0 then
		    klingonhealth (27) := klingonhealth (27) -
			phaserpower
		end if
		phaserexplosionx := klingonx (27)
		phaserexplosiony := klingony (27)
		phaserdamage
	    elsif seck (7) = 4 then
		if klingonhealth (25) not= 0 then
		    klingonhealth (25) := klingonhealth (25) -
			phaserpower
		end if
		phaserexplosionx := klingonx (25)
		phaserexplosiony := klingony (25)
		phaserdamage
		if klingonhealth (26) not= 0 then
		    klingonhealth (26) := klingonhealth (26) -
			phaserpower
		end if
		phaserexplosionx := klingonx (26)
		phaserexplosiony := klingony (26)
		phaserdamage
		if klingonhealth (27) not= 0 then
		    klingonhealth (27) := klingonhealth (27) -
			phaserpower
		end if
		phaserexplosionx := klingonx (27)
		phaserexplosiony := klingony (27)
		phaserdamage
		if klingonhealth (28) not= 0 then
		    klingonhealth (28) := klingonhealth (28) -
			phaserpower
		end if
		phaserexplosionx := klingonx (28)
		phaserexplosiony := klingony (28)
		phaserdamage
	    end if
	elsif sector = 8 then
	    if seckleft (8) not= 0 then
		phaserpower := phaserpower div seckleft (8)
	    end if
	    if seck (8) = 1 then
		if klingonhealth (29) not= 0 then
		    klingonhealth (29) := klingonhealth (29) -
			phaserpower
		end if
		phaserexplosionx := klingonx (29)
		phaserexplosiony := klingony (29)
		phaserdamage
	    elsif seck (8) = 2 then
		if klingonhealth (29) not= 0 then
		    klingonhealth (29) := klingonhealth (29) -
			phaserpower
		end if
		phaserexplosionx := klingonx (29)
		phaserexplosiony := klingony (29)
		phaserdamage
		if klingonhealth (30) not= 0 then
		    klingonhealth (30) := klingonhealth (30) -
			phaserpower
		end if
		phaserexplosionx := klingonx (30)
		phaserexplosiony := klingony (30)
		phaserdamage
	    elsif seck (8) = 3 then
		if klingonhealth (29) not= 0 then
		    klingonhealth (29) := klingonhealth (29) -
			phaserpower
		end if
		phaserexplosionx := klingonx (29)
		phaserexplosiony := klingony (29)
		phaserdamage
		if klingonhealth (30) not= 0 then
		    klingonhealth (30) := klingonhealth (30) -
			phaserpower
		end if
		phaserexplosionx := klingonx (30)
		phaserexplosiony := klingony (30)
		phaserdamage
		if klingonhealth (31) not= 0 then
		    klingonhealth (31) := klingonhealth (31) -
			phaserpower
		end if
		phaserexplosionx := klingonx (31)
		phaserexplosiony := klingony (31)
		phaserdamage
	    elsif seck (8) = 4 then
		if klingonhealth (29) not= 0 then
		    klingonhealth (29) := klingonhealth (29) -
			phaserpower
		end if
		phaserexplosionx := klingonx (29)
		phaserexplosiony := klingony (29)
		phaserdamage
		if klingonhealth (30) not= 0 then
		    klingonhealth (30) := klingonhealth (30) -
			phaserpower
		end if
		phaserexplosionx := klingonx (30)
		phaserexplosiony := klingony (30)
		phaserdamage
		if klingonhealth (31) not= 0 then
		    klingonhealth (31) := klingonhealth (31) -
			phaserpower
		end if
		phaserexplosionx := klingonx (31)
		phaserexplosiony := klingony (31)
		phaserdamage
		if klingonhealth (32) not= 0 then
		    klingonhealth (32) := klingonhealth (32) -
			phaserpower
		end if
		phaserexplosionx := klingonx (32)
		phaserexplosiony := klingony (32)
		phaserdamage
	    end if
	elsif sector = 9 then
	    if seckleft (9) not= 0 then
		phaserpower := phaserpower div seckleft (9)
	    end if
	    if seck (9) = 1 then
		if klingonhealth (33) not= 0 then
		    klingonhealth (33) := klingonhealth (33) -
			phaserpower
		end if
		phaserexplosionx := klingonx (33)
		phaserexplosiony := klingony (33)
		phaserdamage
	    elsif seck (9) = 2 then
		if klingonhealth (33) not= 0 then
		    klingonhealth (33) := klingonhealth (33) -
			phaserpower
		end if
		phaserexplosionx := klingonx (33)
		phaserexplosiony := klingony (33)
		phaserdamage
		if klingonhealth (34) not= 0 then
		    klingonhealth (34) := klingonhealth (34) -
			phaserpower
		end if
		phaserexplosionx := klingonx (34)
		phaserexplosiony := klingony (34)
		phaserdamage
	    elsif seck (9) = 3 then
		if klingonhealth (33) not= 0 then
		    klingonhealth (33) := klingonhealth (33) -
			phaserpower
		end if
		phaserexplosionx := klingonx (33)
		phaserexplosiony := klingony (33)
		phaserdamage
		if klingonhealth (34) not= 0 then
		    klingonhealth (34) := klingonhealth (34) -
			phaserpower
		end if
		phaserexplosionx := klingonx (34)
		phaserexplosiony := klingony (34)
		phaserdamage
		if klingonhealth (35) not= 0 then
		    klingonhealth (35) := klingonhealth (35) -
			phaserpower
		end if
		phaserexplosionx := klingonx (35)
		phaserexplosiony := klingony (35)
		phaserdamage
	    elsif seck (9) = 4 then
		if klingonhealth (33) not= 0 then
		    klingonhealth (33) := klingonhealth (33) -
			phaserpower
		end if
		phaserexplosionx := klingonx (33)
		phaserexplosiony := klingony (33)
		phaserdamage
		if klingonhealth (34) not= 0 then
		    klingonhealth (34) := klingonhealth (34) -
			phaserpower
		end if
		phaserexplosionx := klingonx (34)
		phaserexplosiony := klingony (34)
		phaserdamage
		if klingonhealth (35) not= 0 then
		    klingonhealth (35) := klingonhealth (35) -
			phaserpower
		end if
		phaserexplosionx := klingonx (35)
		phaserexplosiony := klingony (35)
		phaserdamage
		if klingonhealth (36) not= 0 then
		    klingonhealth (36) := klingonhealth (36) -
			phaserpower
		end if
		phaserexplosionx := klingonx (36)
		phaserexplosiony := klingony (36)
		phaserdamage
	    end if
	end if
    end if
end phasers

%Procedure for checking if Klingons run into anything
procedure klingoncheck ()
    trueorfalse := false

    %Checking for Star collisions, if torpedo path = star coordinate
    if sector = 1 then
	if sectorstars (1) = 1 then
	    if (shipdetectx = stars (1, 0) and shipdetecty =
		    stars (0, 1))
		    then
		trueorfalse := true
	    end if
	elsif sectorstars (1) = 2 then
	    if (shipdetectx = stars (1, 0) and shipdetecty =
		    stars (0, 1))
		    or (shipdetectx = stars (2, 0) and shipdetecty =
		    stars (0, 2)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 2 then
	if sectorstars (2) = 1 then
	    if (shipdetectx = stars (3, 0) and shipdetecty =
		    stars (0, 3))
		    then
		trueorfalse := true
	    end if
	elsif sectorstars (2) = 2 then
	    if (shipdetectx = stars (3, 0) and shipdetecty =
		    stars (0, 3))
		    or (shipdetectx = stars (4, 0) and shipdetecty =
		    stars (0, 4)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 3 then
	if sectorstars (3) = 1 then
	    if (shipdetectx = stars (5, 0) and shipdetecty =
		    stars (0, 5))
		    then
		trueorfalse := true
	    end if
	elsif sectorstars (3) = 2 then
	    if (shipdetectx = stars (5, 0) and shipdetecty =
		    stars (0, 5))
		    or (shipdetectx = stars (6, 0) and shipdetecty =
		    stars (0, 6)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 4 then
	if sectorstars (4) = 1 then
	    if (shipdetectx = stars (7, 0) and shipdetecty =
		    stars (0, 7))
		    then
		trueorfalse := true
	    end if
	elsif sectorstars (4) = 2 then
	    if (shipdetectx = stars (7, 0) and shipdetecty =
		    stars (0, 7))
		    or (shipdetectx = stars (8, 0) and shipdetecty =
		    stars (0, 8)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 5 then
	if sectorstars (5) = 1 then
	    if (shipdetectx = stars (9, 0) and shipdetecty =
		    stars (0, 9))
		    then
		trueorfalse := true
	    end if
	elsif sectorstars (5) = 2 then
	    if (shipdetectx = stars (9, 0) and shipdetecty =
		    stars (0, 9))
		    or (shipdetectx = stars (10, 0) and shipdetecty
		    = stars (0, 10)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 6 then
	if sectorstars (6) = 1 then
	    if (shipdetectx = stars (11, 0) and shipdetecty =
		    stars (0, 11))
		    then
		trueorfalse := true
	    end if
	elsif sectorstars (6) = 2 then
	    if (shipdetectx = stars (11, 0) and shipdetecty =
		    stars (0, 11))
		    or (shipdetectx = stars (12, 0) and
		    shipdetecty = stars (0, 12)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 7 then
	if sectorstars (7) = 1 then
	    if (shipdetectx = stars (13, 0) and shipdetecty =
		    stars (0, 13))
		    then
		trueorfalse := true
	    end if
	elsif sectorstars (7) = 2 then
	    if (shipdetectx = stars (13, 0) and shipdetecty =
		    stars (0, 13))
		    or (shipdetectx = stars (14, 0) and
		    shipdetecty = stars (0, 14)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 8 then
	if sectorstars (8) = 1 then
	    if (shipdetectx = stars (15, 0) and shipdetecty =
		    stars (0, 15))
		    then
		trueorfalse := true
	    end if
	elsif sectorstars (8) = 2 then
	    if (shipdetectx = stars (15, 0) and shipdetecty =
		    stars (0, 15))
		    or (shipdetectx = stars (16, 0) and
		    shipdetecty = stars (0, 16)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 9 then
	if sectorstars (8) = 1 then
	    if (shipdetectx = stars (17, 0) and shipdetecty =
		    stars (0, 17))
		    then
		trueorfalse := true
	    end if
	elsif sectorstars (8) = 2 then
	    if (shipdetectx = stars (17, 0) and shipdetecty =
		    stars (0, 17))
		    or (shipdetectx = stars (18, 0) and
		    shipdetecty = stars (0, 18)) then
		trueorfalse := true
	    end if
	end if
    end if

    %Checking for other klingons, if torpedo path = another klingon coordinate
    if sector = 1 then
	if klingonhealth (1) not= 1200 then
	    if (klingonx (1) = shipdetectx and klingony (1) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (2) not= 1200 then
	    if (klingonx (2) = shipdetectx and klingony (2) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (3) not= 1200 then
	    if (klingonx (3) = shipdetectx and klingony (3) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (4) not= 1200 then
	    if (klingonx (4) = shipdetectx and klingony (4) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (5) not= 1200 then
	elsif sector = 2 then
	    if (klingonx (5) = shipdetectx and klingony (5) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (6) not= 1200 then
	    if (klingonx (6) = shipdetectx and klingony (6) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (7) not= 1200 then
	    if (klingonx (7) = shipdetectx and klingony (7) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (8) not= 1200 then
	    if (klingonx (8) = shipdetectx and klingony (8) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 3 then
	if klingonhealth (9) not= 1200 then
	    if (klingonx (9) = shipdetectx and klingony (9) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (10) not= 1200 then
	    if (klingonx (10) = shipdetectx and klingony (10) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (11) not= 1200 then
	    if (klingonx (11) = shipdetectx and klingony (11) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (12) not= 1200 then
	    if (klingonx (12) = shipdetectx and klingony (12) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 4 then
	if klingonhealth (13) not= 1200 then
	    if (klingonx (13) = shipdetectx and klingony (13) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (14) not= 1200 then
	    if (klingonx (14) = shipdetectx and klingony (14) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (15) not= 1200 then
	    if (klingonx (15) = shipdetectx and klingony (15) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (16) not= 1200 then
	    if (klingonx (16) = shipdetectx and klingony (16) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 5 then
	if klingonhealth (17) not= 1200 then
	    if (klingonx (17) = shipdetectx and klingony (17) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (18) not= 1200 then
	    if (klingonx (18) = shipdetectx and klingony (18) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (19) not= 1200 then
	    if (klingonx (19) = shipdetectx and klingony (19) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (20) not= 1200 then
	    if (klingonx (20) = shipdetectx and klingony (20) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 6 then
	if klingonhealth (21) not= 1200 then
	    if (klingonx (21) = shipdetectx and klingony (21) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (22) not= 1200 then
	    if (klingonx (22) = shipdetectx and klingony (22) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (23) not= 1200 then
	    if (klingonx (23) = shipdetectx and klingony (23) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (24) not= 1200 then
	    if (klingonx (24) = shipdetectx and klingony (24) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 7 then
	if klingonhealth (25) not= 1200 then
	    if (klingonx (25) = shipdetectx and klingony (25) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (26) not= 1200 then
	    if (klingonx (26) = shipdetectx and klingony (26) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (27) not= 1200 then
	    if (klingonx (27) = shipdetectx and klingony (27) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (28) not= 1200 then
	    if (klingonx (28) = shipdetectx and klingony (28) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 8 then
	if klingonhealth (29) not= 1200 then
	    if (klingonx (29) = shipdetectx and klingony (29) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (30) not= 1200 then
	    if (klingonx (30) = shipdetectx and klingony (30) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (31) not= 1200 then
	    if (klingonx (31) = shipdetectx and klingony (31) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (32) not= 1200 then
	    if (klingonx (32) = shipdetectx and klingony (32) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 9 then
	if klingonhealth (33) not= 1200 then
	    if (klingonx (33) = shipdetectx and klingony (33) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (34) not= 1200 then
	    if (klingonx (34) = shipdetectx and klingony (34) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (35) not= 1200 then
	    if (klingonx (35) = shipdetectx and klingony (35) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
	if klingonhealth (36) not= 1200 then
	    if (klingonx (36) = shipdetectx and klingony (36) = shipdetecty) then
		trueorfalse := true
	    end if
	end if
    end if

    %Checking for Enterprise or Starbase collisions
    if shipdetectx = positionx and shipdetecty = positiony then
	trueorfalse := true
    end if
    if shipdetectx = starbasex and shipdetecty = starbasey then
	trueorfalse := true
    end if
end klingoncheck

%Procedure for moving Klingons
procedure klingonmove ()
    loop
	%Moves the klingon in a random direction
	klingondirection := Rand.Int (1, 8)
	if klingondirection = 1 then
	    shipdetectx := shipdetectx - 1
	    shipdetecty := shipdetecty - 1
	elsif klingondirection = 2 then
	    shipdetecty := shipdetecty - 1
	elsif klingondirection = 3 then
	    shipdetectx := shipdetectx + 1
	    shipdetecty := shipdetecty - 1
	elsif klingondirection = 4 then
	    shipdetectx := shipdetectx - 1
	elsif klingondirection = 5 then
	    shipdetectx := shipdetectx + 1
	elsif klingondirection = 6 then
	    shipdetectx := shipdetectx - 1
	    shipdetecty := shipdetecty + 1
	elsif klingondirection = 7 then
	    shipdetecty := shipdetecty + 1
	elsif klingondirection = 8 then
	    shipdetectx := shipdetectx + 1
	    shipdetecty := shipdetecty + 1
	end if

	%If klingon is off the grid, move it back on
	if shipdetectx = 9 then
	    shipdetectx := 8
	elsif shipdetectx = 0 then
	    shipdetectx := 1
	end if
	if shipdetecty = 9 then
	    shipdetecty := 8
	elsif shipdetecty = 0 then
	    shipdetecty := 1
	end if
	klingoncheck     %Checks for obstructions
	exit when trueorfalse = false
    end loop
end klingonmove

%Animation for Klingon fire explosion
procedure fireexplosion ()
    photonsize := 8
    photoncolor := 1
    for i : 1 .. 20
	cls
	userinterface
	status
	objects
	Draw.FillOval (map (shipdetectx, 0), map (0, shipdetecty),
	    photonsize,
	    photonsize, photoncolor)
	photonsize := photonsize + 1
	photoncolor := photoncolor + 1
	delay (10)
    end for

    %Damage done to the Enterprise
    if shields > 0 then
	shields := shields - 25
    else
	hullintegrity := hullintegrity - 25
    end if
    shiphit := true
end fireexplosion

%Checks to see if Klingon torpedo hits star or another klingon
procedure klingontorpcheck ()

    %Star collision with Torpedo, checks if star coordinates = the path of the torpedo
    if sector = 1 then
	if sectorstars (1) = 1 then
	    if (shipdetectx = stars (1, 0) and shipdetecty = stars (0, 1)) then
		trueorfalse := true
	    end if
	elsif sectorstars (1) = 2 then
	    if (shipdetectx = stars (1, 0) and shipdetecty = stars (0, 1)) or (shipdetectx = stars (2, 0) and shipdetecty = stars (0, 2)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 2 then
	if sectorstars (2) = 1 then
	    if (shipdetectx = stars (3, 0) and shipdetecty = stars (0, 3)) then
		trueorfalse := true
	    end if
	elsif sectorstars (2) = 2 then
	    if (shipdetectx = stars (3, 0) and shipdetecty = stars (0, 3)) or (shipdetectx = stars (4, 0) and shipdetecty = stars (0, 4)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 3 then
	if sectorstars (3) = 1 then
	    if (shipdetectx = stars (5, 0) and shipdetecty = stars (0, 5)) then
		trueorfalse := true
	    end if
	elsif sectorstars (3) = 2 then
	    if (shipdetectx = stars (5, 0) and shipdetecty = stars (0, 5)) or (shipdetectx = stars (6, 0) and shipdetecty = stars (0, 6)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 4 then
	if sectorstars (4) = 1 then
	    if (shipdetectx = stars (7, 0) and shipdetecty = stars (0, 7)) then
		trueorfalse := true
	    end if
	elsif sectorstars (4) = 2 then
	    if (shipdetectx = stars (7, 0) and shipdetecty = stars (0, 7)) or (shipdetectx = stars (8, 0) and shipdetecty = stars (0, 8)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 5 then
	if sectorstars (5) = 1 then
	    if (shipdetectx = stars (9, 0) and shipdetecty = stars (0, 9)) then
		trueorfalse := true
	    end if
	elsif sectorstars (5) = 2 then
	    if (shipdetectx = stars (9, 0) and shipdetecty = stars (0, 9)) or (shipdetectx = stars (10, 0) and shipdetecty = stars (0, 10)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 6 then
	if sectorstars (6) = 1 then
	    if (shipdetectx = stars (11, 0) and shipdetecty = stars (0, 11)) then
		trueorfalse := true
	    end if
	elsif sectorstars (6) = 2 then
	    if (shipdetectx = stars (11, 0) and shipdetecty = stars (0, 11)) or (shipdetectx = stars (12, 0) and shipdetecty = stars (0, 12)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 7 then
	if sectorstars (7) = 1 then
	    if (shipdetectx = stars (13, 0) and shipdetecty = stars (0, 13)) then
		trueorfalse := true
	    end if
	elsif sectorstars (7) = 2 then
	    if (shipdetectx = stars (13, 0) and shipdetecty = stars (0, 13)) or (shipdetectx = stars (14, 0) and shipdetecty = stars (0, 14)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 8 then
	if sectorstars (8) = 1 then
	    if (shipdetectx = stars (15, 0) and shipdetecty = stars (0, 15)) then
		trueorfalse := true
	    end if
	elsif sectorstars (8) = 2 then
	    if (shipdetectx = stars (15, 0) and shipdetecty = stars (0, 15)) or (shipdetectx = stars (16, 0) and shipdetecty = stars (0, 16)) then
		trueorfalse := true
	    end if
	end if
    elsif sector = 9 then
	if sectorstars (8) = 1 then
	    if (shipdetectx = stars (17, 0) and shipdetecty = stars (0, 17)) then
		trueorfalse := true
	    end if
	elsif sectorstars (8) = 2 then
	    if (shipdetectx = stars (17, 0) and shipdetecty = stars (0, 17)) or (shipdetectx = stars (18, 0) and shipdetecty = stars (0, 18)) then
		trueorfalse := true
	    end if
	end if
    end if

    %Klingon collision with torpedo, checks if klingon coordinate = path of the torpedo
    if sector = 1 then
	if (klingonx (1) = shipdetectx and klingony (1) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (2) = shipdetectx and klingony (2) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (3) = shipdetectx and klingony (3) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (4) = shipdetectx and klingony (4) = shipdetecty) then
	    trueorfalse := true
	end if
    elsif sector = 2 then
	if (klingonx (5) = shipdetectx and klingony (5) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (6) = shipdetectx and klingony (6) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (7) = shipdetectx and klingony (7) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (8) = shipdetectx and klingony (8) = shipdetecty) then
	    trueorfalse := true
	end if
    elsif sector = 3 then
	if (klingonx (9) = shipdetectx and klingony (9) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (10) = shipdetectx and klingony (10) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (11) = shipdetectx and klingony (11) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (12) = shipdetectx and klingony (12) = shipdetecty) then
	    trueorfalse := true
	end if
    elsif sector = 4 then
	if (klingonx (13) = shipdetectx and klingony (13) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (14) = shipdetectx and klingony (14) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (15) = shipdetectx and klingony (15) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (16) = shipdetectx and klingony (16) = shipdetecty) then
	    trueorfalse := true
	end if
    elsif sector = 5 then
	if (klingonx (17) = shipdetectx and klingony (17) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (18) = shipdetectx and klingony (18) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (19) = shipdetectx and klingony (19) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (20) = shipdetectx and klingony (20) = shipdetecty) then
	    trueorfalse := true
	end if
    elsif sector = 6 then
	if (klingonx (21) = shipdetectx and klingony (21) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (22) = shipdetectx and klingony (22) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (23) = shipdetectx and klingony (23) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (24) = shipdetectx and klingony (24) = shipdetecty) then
	    trueorfalse := true
	end if
    elsif sector = 7 then
	if (klingonx (25) = shipdetectx and klingony (25) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (26) = shipdetectx and klingony (26) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (27) = shipdetectx and klingony (27) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (28) = shipdetectx and klingony (28) = shipdetecty) then
	    trueorfalse := true
	end if
    elsif sector = 8 then
	if (klingonx (29) = shipdetectx and klingony (29) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (30) = shipdetectx and klingony (30) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (31) = shipdetectx and klingony (31) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (32) = shipdetectx and klingony (32) = shipdetecty) then
	    trueorfalse := true
	end if
    elsif sector = 9 then
	if (klingonx (33) = shipdetectx and klingony (33) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (34) = shipdetectx and klingony (34) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (35) = shipdetectx and klingony (35) = shipdetecty) then
	    trueorfalse := true
	elsif (klingonx (36) = shipdetectx and klingony (36) = shipdetecty) then
	    trueorfalse := true
	end if
    end if
end klingontorpcheck

%Animation for Klingon fire, the moving torpedo
procedure fireanimation ()
    shipdetectx := shipdetectxo
    shipdetecty := shipdetectyo

    %Shoots the torpedo in its predetermined direction, then go to the explosion animation
    if klingondirection = 1 then
	loop
	    cls
	    userinterface
	    status
	    objects
	    Draw.FillOval (map (shipdetectx, 0), map (0,
		shipdetecty), 8, 8,
		red)
	    shipdetectx := shipdetectx - 1
	    shipdetecty := shipdetecty - 1
	    delay (300)
	    exit when shipdetectx = positionx and shipdetecty =
		positiony
	end loop
    elsif klingondirection = 2 then
	loop
	    cls
	    userinterface
	    status
	    objects
	    Draw.FillOval (map (shipdetectx, 0), map (0,
		shipdetecty), 8, 8,
		red)
	    shipdetecty := shipdetecty - 1
	    delay (300)
	    exit when shipdetectx = positionx and shipdetecty =
		positiony
	end loop
    elsif klingondirection = 3 then
	loop
	    cls
	    userinterface
	    status
	    objects
	    Draw.FillOval (map (shipdetectx, 0), map (0,
		shipdetecty), 8, 8,
		red)
	    shipdetecty := shipdetecty - 1
	    shipdetectx := shipdetectx + 1
	    delay (300)
	    exit when shipdetectx = positionx and shipdetecty =
		positiony
	end loop
    elsif klingondirection = 4 then
	loop
	    cls
	    userinterface
	    status
	    objects
	    Draw.FillOval (map (shipdetectx, 0), map (0,
		shipdetecty), 8, 8,
		red)
	    shipdetectx := shipdetectx - 1
	    delay (300)
	    exit when shipdetectx = positionx and shipdetecty =
		positiony
	end loop
    elsif klingondirection = 5 then
	loop
	    cls
	    userinterface
	    status
	    objects
	    Draw.FillOval (map (shipdetectx, 0), map (0,
		shipdetecty), 8, 8,
		red)
	    shipdetectx := shipdetectx + 1
	    delay (300)
	    exit when shipdetectx = positionx and shipdetecty =
		positiony
	end loop
    elsif klingondirection = 6 then
	loop
	    cls
	    userinterface
	    status
	    objects
	    Draw.FillOval (map (shipdetectx, 0), map (0,
		shipdetecty), 8, 8,
		red)
	    shipdetecty := shipdetecty + 1
	    shipdetectx := shipdetectx - 1
	    delay (300)
	    exit when shipdetectx = positionx and shipdetecty =
		positiony
	end loop
    elsif klingondirection = 7 then
	loop
	    cls
	    userinterface
	    status
	    objects
	    Draw.FillOval (map (shipdetectx, 0), map (0,
		shipdetecty), 8, 8,
		red)
	    shipdetecty := shipdetecty + 1
	    delay (300)
	    exit when shipdetectx = positionx and shipdetecty =
		positiony
	end loop
    elsif klingondirection = 8 then
	loop
	    cls
	    userinterface
	    status
	    objects
	    Draw.FillOval (map (shipdetectx, 0), map (0,
		shipdetecty), 8, 8,
		red)
	    shipdetecty := shipdetecty + 1
	    shipdetectx := shipdetectx + 1
	    delay (300)
	    exit when shipdetectx = positionx and shipdetecty =
		positiony
	end loop
    end if
    fireexplosion
end fireanimation

%Procedure for firing Klingons
procedure klingonfire ()
    shipdetectxo := shipdetectx
    shipdetectyo := shipdetecty

    %Determining if the Klingon can shoot the Enterprise from where it is, it does a scan of its straight line surroundings
    loop
	shipdetectx := shipdetectx - 1
	shipdetecty := shipdetecty - 1
	klingontorpcheck
	if shipdetectx = 0 or shipdetectx = 9 or shipdetecty = 0 or
		shipdetecty
		= 9 then
	    shipdetectx := shipdetectxo
	    shipdetecty := shipdetectyo
	    exit
	elsif shipdetectx = positionx and shipdetecty = positiony
		and
		trueorfalse = false then
	    klingondirection := 1
	    fireanimation
	    exit
	end if
    end loop
    loop
	shipdetecty := shipdetecty - 1
	klingontorpcheck
	if shipdetectx = 0 or shipdetectx = 9 or shipdetecty = 0 or
		shipdetecty
		= 9 then
	    shipdetectx := shipdetectxo
	    shipdetecty := shipdetectyo
	    exit
	elsif shipdetectx = positionx and shipdetecty = positiony
		and
		trueorfalse = false then
	    klingondirection := 2
	    fireanimation
	    exit
	end if
    end loop
    loop
	shipdetectx := shipdetectx + 1
	shipdetecty := shipdetecty - 1
	klingontorpcheck
	if shipdetectx = 0 or shipdetectx = 9 or shipdetecty = 0 or
		shipdetecty
		= 9 then
	    shipdetectx := shipdetectxo
	    shipdetecty := shipdetectyo
	    exit
	elsif shipdetectx = positionx and shipdetecty = positiony
		and
		trueorfalse = false then
	    klingondirection := 3
	    fireanimation
	    exit
	end if
    end loop
    loop
	shipdetectx := shipdetectx - 1
	klingontorpcheck
	if shipdetectx = 0 or shipdetectx = 9 or shipdetecty = 0 or
		shipdetecty
		= 9 then
	    shipdetectx := shipdetectxo
	    shipdetecty := shipdetectyo
	    exit
	elsif shipdetectx = positionx and shipdetecty = positiony
		and
		trueorfalse = false then
	    klingondirection := 4
	    fireanimation
	    exit
	end if
    end loop
    loop
	shipdetectx := shipdetectx + 1
	klingontorpcheck
	if shipdetectx = 0 or shipdetectx = 9 or shipdetecty = 0 or
		shipdetecty
		= 9 then
	    shipdetectx := shipdetectxo
	    shipdetecty := shipdetectyo
	    exit
	elsif shipdetectx = positionx and shipdetecty = positiony
		and
		trueorfalse = false then
	    klingondirection := 5
	    fireanimation
	    exit
	end if
    end loop
    loop
	shipdetectx := shipdetectx - 1
	shipdetecty := shipdetecty + 1
	klingontorpcheck
	if shipdetectx = 0 or shipdetectx = 9 or shipdetecty = 0 or
		shipdetecty
		= 9 then
	    shipdetectx := shipdetectxo
	    shipdetecty := shipdetectyo
	    exit
	elsif shipdetectx = positionx and shipdetecty = positiony
		and
		trueorfalse = false then
	    klingondirection := 6
	    fireanimation
	    exit
	end if
    end loop
    loop
	shipdetecty := shipdetecty + 1
	klingontorpcheck
	if shipdetectx = 0 or shipdetectx = 9 or shipdetecty = 0 or
		shipdetecty
		= 9 then
	    shipdetectx := shipdetectxo
	    shipdetecty := shipdetectyo
	    exit
	elsif shipdetectx = positionx and shipdetecty = positiony
		and
		trueorfalse = false then
	    klingondirection := 7
	    fireanimation
	    exit
	end if
    end loop
    loop
	shipdetectx := shipdetectx + 1
	shipdetecty := shipdetecty + 1
	klingontorpcheck
	if shipdetectx = 0 or shipdetectx = 9 or shipdetecty = 0 or shipdetecty = 9 then
	    shipdetectx := shipdetectxo
	    shipdetecty := shipdetectyo
	    exit
	elsif shipdetectx = positionx and shipdetecty = positiony
		and
		trueorfalse = false then
	    klingondirection := 8
	    fireanimation
	    exit
	end if
    end loop
end klingonfire

%Procedure for Klingon turn, picks between moving and firing a photon at the Enterprise
procedure klingonturn ()
    if sector = 1 then
	if klingonhealth (1) > 0 and klingonhealth (1) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (1)
	    shipdetecty := klingony (1)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (1) := shipdetectx
		klingony (1) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (2) > 0 and klingonhealth (2) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (2)
	    shipdetecty := klingony (2)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (2) := shipdetectx
		klingony (2) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (3) > 0 and klingonhealth (3) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (3)
	    shipdetecty := klingony (3)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (3) := shipdetectx
		klingony (3) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (4) > 0 and klingonhealth (4) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (4)
	    shipdetecty := klingony (4)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (4) := shipdetectx
		klingony (4) := shipdetecty
	    else
		klingonfire
	    end if
	end if
    elsif sector = 2 then
	if klingonhealth (5) > 0 and klingonhealth (5) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (5)
	    shipdetecty := klingony (5)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (5) := shipdetectx
		klingony (5) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (6) > 0 and klingonhealth (6) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (6)
	    shipdetecty := klingony (6)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (6) := shipdetectx
		klingony (6) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (7) > 0 and klingonhealth (7) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (7)
	    shipdetecty := klingony (7)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (7) := shipdetectx
		klingony (7) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (8) > 0 and klingonhealth (8) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (8)
	    shipdetecty := klingony (8)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (8) := shipdetectx
		klingony (8) := shipdetecty
	    else
		klingonfire
	    end if
	end if
    elsif sector = 3 then
	if klingonhealth (9) > 0 and klingonhealth (9) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (9)
	    shipdetecty := klingony (9)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (9) := shipdetectx
		klingony (9) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (10) > 0 and klingonhealth (10) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (10)
	    shipdetecty := klingony (10)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (10) := shipdetectx
		klingony (10) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (11) > 0 and klingonhealth (11) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (11)
	    shipdetecty := klingony (11)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (11) := shipdetectx
		klingony (11) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (12) > 0 and klingonhealth (12) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (12)
	    shipdetecty := klingony (12)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (12) := shipdetectx
		klingony (12) := shipdetecty
	    else
		klingonfire
	    end if
	end if
    elsif sector = 4 then
	if klingonhealth (13) > 0 and klingonhealth (13) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (13)
	    shipdetecty := klingony (13)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (13) := shipdetectx
		klingony (13) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (14) > 0 and klingonhealth (14) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (14)
	    shipdetecty := klingony (14)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (14) := shipdetectx
		klingony (14) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (15) > 0 and klingonhealth (15) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (15)
	    shipdetecty := klingony (15)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (15) := shipdetectx
		klingony (15) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (16) > 0 and klingonhealth (16) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (16)
	    shipdetecty := klingony (16)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (16) := shipdetectx
		klingony (16) := shipdetecty
	    else
		klingonfire
	    end if
	end if
    elsif sector = 5 then
	if klingonhealth (17) > 0 and klingonhealth (17) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (17)
	    shipdetecty := klingony (17)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (17) := shipdetectx
		klingony (17) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (18) > 0 and klingonhealth (18) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (18)
	    shipdetecty := klingony (18)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (18) := shipdetectx
		klingony (18) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (19) > 0 and klingonhealth (19) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (19)
	    shipdetecty := klingony (19)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (19) := shipdetectx
		klingony (19) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (20) > 0 and klingonhealth (20) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (20)
	    shipdetecty := klingony (20)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (20) := shipdetectx
		klingony (20) := shipdetecty
	    else
		klingonfire
	    end if
	end if
    elsif sector = 6 then
	if klingonhealth (21) > 0 and klingonhealth (21) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (21)
	    shipdetecty := klingony (21)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (21) := shipdetectx
		klingony (21) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (22) > 0 and klingonhealth (22) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (22)
	    shipdetecty := klingony (22)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (22) := shipdetectx
		klingony (22) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (23) > 0 and klingonhealth (23) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (23)
	    shipdetecty := klingony (23)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (23) := shipdetectx
		klingony (23) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (24) > 0 and klingonhealth (24) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (24)
	    shipdetecty := klingony (24)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (24) := shipdetectx
		klingony (24) := shipdetecty
	    else
		klingonfire
	    end if
	end if
    elsif sector = 7 then
	if klingonhealth (25) > 0 and klingonhealth (25) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (25)
	    shipdetecty := klingony (25)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (25) := shipdetectx
		klingony (25) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (26) > 0 and klingonhealth (26) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (26)
	    shipdetecty := klingony (26)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (26) := shipdetectx
		klingony (26) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (27) > 0 and klingonhealth (27) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (27)
	    shipdetecty := klingony (27)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (27) := shipdetectx
		klingony (27) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (28) > 0 and klingonhealth (28) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (28)
	    shipdetecty := klingony (28)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (28) := shipdetectx
		klingony (28) := shipdetecty
	    else
		klingonfire
	    end if
	end if
    elsif sector = 8 then
	if klingonhealth (29) > 0 and klingonhealth (29) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (29)
	    shipdetecty := klingony (29)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (29) := shipdetectx
		klingony (29) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (30) > 0 and klingonhealth (30) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (30)
	    shipdetecty := klingony (30)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (30) := shipdetectx
		klingony (30) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (31) > 0 and klingonhealth (31) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (31)
	    shipdetecty := klingony (31)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (31) := shipdetectx
		klingony (31) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (32) > 0 and klingonhealth (32) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (32)
	    shipdetecty := klingony (32)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (32) := shipdetectx
		klingony (32) := shipdetecty
	    else
		klingonfire
	    end if
	end if
    elsif sector = 9 then
	if klingonhealth (33) > 0 and klingonhealth (33) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (33)
	    shipdetecty := klingony (33)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (33) := shipdetectx
		klingony (33) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (34) > 0 and klingonhealth (34) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (34)
	    shipdetecty := klingony (34)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (34) := shipdetectx
		klingony (34) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (35) > 0 and klingonhealth (35) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (35)
	    shipdetecty := klingony (35)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (35) := shipdetectx
		klingony (35) := shipdetecty
	    else
		klingonfire
	    end if
	end if
	if klingonhealth (36) > 0 and klingonhealth (36) not= 1200
		then
	    klingonchoice := Rand.Int (1, 2)
	    shipdetectx := klingonx (36)
	    shipdetecty := klingony (36)
	    if klingonchoice = 1 then
		klingonmove
		klingonx (36) := shipdetectx
		klingony (36) := shipdetecty
	    else
		klingonfire
	    end if
	end if
    end if
end klingonturn

%Procedure that turns klingondead true's into false's, so that it won't say "Klingon(s) blew up" every turn
procedure klingonswitch ()
    if klingondead (1) = true then
	klingondead (1) := false
    end if
    if klingondead (2) = true then
	klingondead (2) := false
    end if
    if klingondead (3) = true then
	klingondead (3) := false
    end if
    if klingondead (4) = true then
	klingondead (4) := false
    end if
    if klingondead (5) = true then
	klingondead (5) := false
    end if
    if klingondead (6) = true then
	klingondead (6) := false
    end if
    if klingondead (7) = true then
	klingondead (7) := false
    end if
    if klingondead (8) = true then
	klingondead (8) := false
    end if
    if klingondead (9) = true then
	klingondead (9) := false
    end if
    if klingondead (10) = true then
	klingondead (10) := false
    end if
    if klingondead (11) = true then
	klingondead (11) := false
    end if
    if klingondead (12) = true then
	klingondead (12) := false
    end if
    if klingondead (13) = true then
	klingondead (13) := false
    end if
    if klingondead (14) = true then
	klingondead (14) := false
    end if
    if klingondead (15) = true then
	klingondead (15) := false
    end if
    if klingondead (16) = true then
	klingondead (16) := false
    end if
    if klingondead (17) = true then
	klingondead (17) := false
    end if
    if klingondead (18) = true then
	klingondead (18) := false
    end if
    if klingondead (19) = true then
	klingondead (19) := false
    end if
    if klingondead (20) = true then
	klingondead (20) := false
    end if
    if klingondead (21) = true then
	klingondead (21) := false
    end if
    if klingondead (22) = true then
	klingondead (22) := false
    end if
    if klingondead (23) = true then
	klingondead (23) := false
    end if
    if klingondead (24) = true then
	klingondead (24) := false
    end if
    if klingondead (25) = true then
	klingondead (25) := false
    end if
    if klingondead (26) = true then
	klingondead (26) := false
    end if
    if klingondead (27) = true then
	klingondead (27) := false
    end if
    if klingondead (28) = true then
	klingondead (28) := false
    end if
    if klingondead (29) = true then
	klingondead (29) := false
    end if
    if klingondead (30) = true then
	klingondead (30) := false
    end if
    if klingondead (31) = true then
	klingondead (31) := false
    end if
    if klingondead (32) = true then
	klingondead (32) := false
    end if
    if klingondead (33) = true then
	klingondead (33) := false
    end if
    if klingondead (34) = true then
	klingondead (34) := false
    end if
    if klingondead (35) = true then
	klingondead (35) := false
    end if
    if klingondead (36) = true then
	klingondead (36) := false
    end if
end klingonswitch

%Text procedure, draws text in the top right of the screen
procedure text ()

    %Player action feedback
    if impulse = true then
	Draw.Text ("Moved to:", maxx div 2 + 60, maxy - 20, clickfont, white)
	Draw.Text ("(   ,   )", maxx div 2 + 140, maxy - 20, clickfont, white)
	Draw.Text (intstr (positionx), maxx div 2 + 150, maxy - 20, clickfont, white)
	Draw.Text (intstr (positiony), maxx div 2 + 170, maxy - 20, clickfont, white)
    elsif warpengine = true then
	Draw.Text ("Moved to Sector:", maxx div 2 + 60, maxy - 20, clickfont, white)
	Draw.Text (intstr (sector), maxx div 2 + 200, maxy - 20, clickfont, white)
    elsif torpedo = true then
	if torpedohitk = true then
	    Draw.Text ("Direct torpedo hit on Klingon:", maxx div 2 + 60, maxy - 20, clickfont, white)
	    Draw.Text (intstr (kshiphit), maxx div 2 + 290, maxy - 20, clickfont, white)
	elsif torpedohits = true then
	    Draw.Text ("Torpedo hit star... No effect. ", maxx div 2 + 60, maxy - 20, clickfont, white)
	elsif torpedohitk = false or torpedohits = false then
	    Draw.Text ("Missed torpedo shot...", maxx div 2 + 60, maxy - 20, clickfont, white)
	end if
    elsif phaser = true then
	if sector = 1 then
	    if seckleft (1) >= 1 then
		Draw.Text ("Hit all ships for        damage.", maxx div 2 + 60, maxy - 20, clickfont, white)
		Draw.Text (intstr (phaserpower), maxx div 2 + 180, maxy - 20, clickfont, white)
	    else
		Draw.Text ("No target for the Phasers...", maxx div 2 + 60, maxy - 20, clickfont, white)
	    end if
	end if
	if sector = 2 then
	    if seckleft (2) >= 1 then
		Draw.Text ("Hit all ships for        damage.", maxx div 2 + 60, maxy - 20, clickfont, white)
		Draw.Text (intstr (phaserpower), maxx div 2 + 180, maxy - 20, clickfont, white)
	    else
		Draw.Text ("No target for the Phasers...", maxx div 2 + 60, maxy - 20, clickfont, white)
	    end if
	end if
	if sector = 3 then
	    if seckleft (3) >= 1 then
		Draw.Text ("Hit all ships for        damage.", maxx div 2 + 60, maxy - 20, clickfont, white)
		Draw.Text (intstr (phaserpower), maxx div 2 + 180, maxy - 20, clickfont, white)
	    else
		Draw.Text ("No target for the Phasers...", maxx div 2 + 60, maxy - 20, clickfont, white)
	    end if
	end if
	if sector = 4 then
	    if seckleft (4) >= 1 then
		Draw.Text ("Hit all ships for        damage.", maxx div 2 + 60, maxy - 20, clickfont, white)
		Draw.Text (intstr (phaserpower), maxx div 2 + 180, maxy - 20, clickfont, white)
	    else
		Draw.Text ("No target for the Phasers...", maxx div 2 + 60, maxy - 20, clickfont, white)
	    end if
	end if
	if sector = 5 then
	    if seckleft (5) >= 1 then
		Draw.Text ("Hit all ships for        damage.", maxx div 2 + 60, maxy - 20, clickfont, white)
		Draw.Text (intstr (phaserpower), maxx div 2 + 180, maxy - 20, clickfont, white)
	    else
		Draw.Text ("No target for the Phasers...", maxx div 2 + 60, maxy - 20, clickfont, white)
	    end if
	end if
	if sector = 6 then
	    if seckleft (6) >= 1 then
		Draw.Text ("Hit all ships for        damage.", maxx div 2 + 60, maxy - 20, clickfont, white)
		Draw.Text (intstr (phaserpower), maxx div 2 + 180, maxy - 20, clickfont, white)
	    else
		Draw.Text ("No target for the Phasers...", maxx div 2 + 60, maxy - 20, clickfont, white)
	    end if
	end if
	if sector = 7 then
	    if seckleft (7) >= 1 then
		Draw.Text ("Hit all ships for        damage.", maxx div 2 + 60, maxy - 20, clickfont, white)
		Draw.Text (intstr (phaserpower), maxx div 2 + 180, maxy - 20, clickfont, white)
	    else
		Draw.Text ("No target for the Phasers...", maxx div 2 + 60, maxy - 20, clickfont, white)
	    end if
	end if
	if sector = 8 then
	    if seckleft (8) >= 1 then
		Draw.Text ("Hit all ships for        damage.", maxx div 2 + 60, maxy - 20, clickfont, white)
		Draw.Text (intstr (phaserpower), maxx div 2 + 180, maxy - 20, clickfont, white)
	    else
		Draw.Text ("No target for the Phasers...", maxx div 2 + 60, maxy - 20, clickfont, white)
	    end if
	end if
	if sector = 9 then
	    if seckleft (9) >= 1 then
		Draw.Text ("Hit all ships for        damage.", maxx div 2 + 60, maxy - 20, clickfont, white)
		Draw.Text (intstr (phaserpower), maxx div 2 + 180, maxy - 20, clickfont, white)
	    else
		Draw.Text ("No target for the Phasers...", maxx div 2 + 60, maxy - 20, clickfont, white)
	    end if
	end if
    end if

    %Destroyed Klingon
    if klingondead (1) = true or klingondead (2) = true or klingondead (3) = true or klingondead (4) = true or klingondead (5) = true then
	Draw.Text ("Klingon(s) blew up!", maxx div 2 + 60, maxy - 40, clickfont, white)
    end if
    if klingondead (6) = true or klingondead (7) = true or klingondead (8) = true or klingondead (9) = true or klingondead (10) = true then
	Draw.Text ("Klingon(s) blew up!", maxx div 2 + 60, maxy - 40, clickfont, white)
    end if
    if klingondead (11) = true or klingondead (12) = true or klingondead (13) = true or klingondead (14) = true or klingondead (15) = true then
	Draw.Text ("Klingon(s) blew up!", maxx div 2 + 60, maxy - 40, clickfont, white)
    end if
    if klingondead (16) = true or klingondead (17) = true or klingondead (18) = true or klingondead (19) = true or klingondead (20) = true then
	Draw.Text ("Klingon(s) blew up!", maxx div 2 + 60, maxy - 40, clickfont, white)
    end if
    if klingondead (21) = true or klingondead (22) = true or klingondead (23) = true or klingondead (24) = true or klingondead (25) = true then
	Draw.Text ("Klingon(s) blew up!", maxx div 2 + 60, maxy - 40, clickfont, white)
    end if
    if klingondead (26) = true or klingondead (27) = true or klingondead (28) = true or klingondead (29) = true or klingondead (30) = true then
	Draw.Text ("Klingon(s) blew up!", maxx div 2 + 60, maxy - 40, clickfont, white)
    end if
    if klingondead (31) = true or klingondead (32) = true or klingondead (33) = true or klingondead (34) = true or klingondead (35) = true then
	Draw.Text ("Klingon(s) blew up!", maxx div 2 + 60, maxy - 40, clickfont, white)
    end if
    if klingondead (36) = true then
	Draw.Text ("Klingon(s) blew up!", maxx div 2 + 60, maxy - 40, clickfont, white)
    end if

    %Starbase resources recovered
    if shipcondition = "Docked" then
	Draw.Text ("Hull Integrity Recovered: ", maxx div 2 + 60, maxy - 40, clickfont, white)
	Draw.Text ("Shields Recovered: ", maxx div 2 + 60, maxy - 60, clickfont, white)
	Draw.Text ("Power Recovered: ", maxx div 2 + 60, maxy - 80, clickfont, white)
	Draw.Text (intstr (healthrecovered), maxx div 2 + 250, maxy - 40, clickfont, white)
	Draw.Text (intstr (shieldsrecovered), maxx div 2 + 210, maxy - 60, clickfont, white)
	Draw.Text (intstr (powerrecovered), maxx div 2 + 200, maxy - 80, clickfont, white)
	Draw.Text ("Hull Integrity left on starbase:", maxx div 2 + 60, maxy - 100, clickfont, white)
	Draw.Text ("Shield units left on starbase:", maxx div 2 + 60, maxy - 120, clickfont, white)
	Draw.Text ("Power units left on starbase:", maxx div 2 + 60, maxy - 140, clickfont, white)
	Draw.Text (intstr (starbaserepair), maxx div 2 + 285, maxy - 100, clickfont, white)
	Draw.Text (intstr (starbaseshields), maxx div 2 + 270, maxy - 120, clickfont, white)
	Draw.Text (intstr (starbasepower), maxx div 2 + 270, maxy - 140, clickfont, white)
    end if

    %If Enterprise is hit by a klingon torpedo
    if shiphit = true then
	if shields > 0 then
	    Draw.Text ("Ship hit, shields at: ", maxx div 2 + 60, maxy - 40, clickfont, white)
	    Draw.Text (intstr (shields), maxx div 2 + 210, maxy - 40, clickfont, white)
	else
	    Draw.Text ("Ship hit, hull at: ", maxx div 2 + 60, maxy - 40, clickfont, white)
	    Draw.Text (intstr (hullintegrity), maxx div 2 + 180, maxy - 40, clickfont, white)
	end if
    end if
end text

%Actions option, tactical combat
procedure actions ()
    cls
    userinterface
    status
    objects
    Draw.Box (maxx div 2 + 75, 10, maxx - 25, 40, white)
    Draw.Fill (maxx div 2 + 90, 20, blue, white)
    Draw.Text ("ACTIONS", maxx div 2 + 145, 20, clickfont, white)
    Draw.Box (maxx div 3, 10, maxx div 2, 40, white)
    Draw.Fill (maxx div 3 + 10, 20, blue, white)
    Draw.Text ("SENSORS", maxx div 3 + 10, 20, clickfont, white)
    text
    loop
	Mouse.Where (x, y, click)
	if click = 0 then
	    exit
	end if
    end loop
    loop
	Mouse.Where (x, y, click)
	if click = 1 and (x >= maxx div 2 + 75 and x <= maxx - 25)
		and (y
		>= 10
		and y <= 40) then
	    exit
	elsif click = 1 and (x >= maxx div 3 and x <= maxx div 2)                             %Sensors
		and (y >=
		10
		and y <= 40) then
	    sensors
	    cls
	    userinterface
	    status
	    objects
	    Draw.Box (maxx div 2 + 75, 10, maxx - 25, 40, white)
	    Draw.Fill (maxx div 2 + 90, 20, blue, white)
	    Draw.Text ("ACTIONS", maxx div 2 + 145, 20, clickfont, white)
	    Draw.Box (maxx div 3, 10, maxx div 2, 40, white)
	    Draw.Fill (maxx div 3 + 10, 20, blue, white)
	    Draw.Text ("SENSORS", maxx div 3 + 10, 20, clickfont, white)
	    text
	    loop
		Mouse.Where (x, y, click)
		if click = 0 then
		    exit
		end if
	    end loop
	end if
	delay (5)
    end loop
    loop
	Mouse.Where (x, y, click)
	if click = 0 then
	    exit
	end if
    end loop
    cls
    userinterface
    status
    objects
    text
    klingonswitch
    shiphit := false
    loop
	Draw.Box (maxx div 3, 10, maxx div 2, 40, white)
	Draw.Fill (maxx div 3 + 10, 20, blue, white)
	Draw.Text ("SENSORS", maxx div 3 + 10, 20, clickfont, white)
	Draw.Box (maxx div 2 + 75, 10, maxx - 25, 40, white)
	Draw.Fill (maxx div 2 + 90, 20, blue, white)
	Draw.Text ("CANCEL", maxx div 2 + 145, 20, clickfont, white)
	Draw.FillBox (maxx div 2 + 75, 40, maxx - 25, 70, blue)
	Draw.Box (maxx div 2 + 75, 40, maxx - 25, 70, white)
	Draw.Text ("IMPULSE ENGINES", maxx div 2 + 107, 50, clickfont, white)
	Draw.FillBox (maxx div 2 + 75, 70, maxx - 25, 100, blue)
	Draw.Box (maxx div 2 + 75, 70, maxx - 25, 100, white)
	Draw.Text ("PHASERS", maxx div 2 + 140, 80, clickfont, white)
	Draw.FillBox (maxx div 2 + 75, 100, maxx - 25, 130, blue)
	Draw.Box (maxx div 2 + 75, 100, maxx - 25, 130, white)
	Draw.Text ("PHOTON TORPEDOES", maxx div 2 + 90, 110, clickfont, white)
	Draw.FillBox (maxx div 2 + 75, 130, maxx - 25, 160, blue)
	Draw.Box (maxx div 2 + 75, 130, maxx - 25, 160, white)
	Draw.Text ("WARP DRIVE", maxx div 2 + 125, 140, clickfont, white)
	Mouse.Where (x, y, click)
	if click = 1 and (x >= maxx div 2 + 75 and x <= maxx - 25)                             %Cancel button
		and (y
		>= 10
		and y <= 40) then
	    cls
	    userinterface
	    status
	    objects
	    actions
	elsif click = 1 and (x >= maxx div 2 + 75 and x <= maxx -                             %Impulse Engines
		25)
		and (y >=
		41 and y <= 70) then
	    imp
	    cls
	    userinterface
	    status
	    objects
	    if imppower = 0 then
		actions
	    end if
	    exit
	elsif click = 1 and (x >= maxx div 2 + 75 and x <= maxx -                             %Phasers
		25)
		and (y >=
		71 and y <= 100) then
	    phasers
	    cls
	    userinterface
	    status
	    objects
	    if phaserpower = 0 then
		actions
	    end if
	    exit
	elsif click = 1 and (x >= maxx div 2 + 75 and x <= maxx -                             %Photon Torpedoes
		25)
		and (y >=
		101 and y <= 130) then
	    torpedoes
	    cls
	    userinterface
	    status
	    objects
	    if torpdirection = 0 then
		actions
	    end if
	    exit
	elsif click = 1 and (x >= maxx div 2 + 75 and x <= maxx -                             %Warp Drive
		25)
		and (y >=
		131 and y <= 160) then
	    warp
	    cls
	    userinterface
	    status
	    objects
	    if trueorfalse = true then
		trueorfalse := false
		actions
	    end if
	    exit
	end if
	delay (50)
    end loop
end actions

%Actions procedure while Enterprise is docked, only action you can do is the Impulse engines
procedure dockactions ()
    cls
    userinterface
    status
    objects
    Draw.Box (maxx div 2 + 75, 10, maxx - 25, 40, white)
    Draw.Fill (maxx div 2 + 90, 20, blue, white)
    Draw.Text ("IMPULSE ENGINES", maxx div 2 + 107, 20, clickfont,
	white)
    Draw.Box (maxx div 3, 10, maxx div 2, 40, white)
    Draw.Fill (maxx div 3 + 10, 20, blue, white)
    Draw.Text ("SENSORS", maxx div 3 + 10, 20, clickfont, white)
    text
    klingonswitch
    shiphit := false
    loop
	Mouse.Where (x, y, click)
	if click = 0 then
	    exit
	end if
    end loop
    loop
	Mouse.Where (x, y, click)
	if click = 1 and (x >= maxx div 2 + 75 and x <= maxx - 25)                             %Impulse Engines
		and (y
		>= 10
		and y <= 40) then
	    imp
	    cls
	    userinterface
	    status
	    objects
	    if imppower = 0 then
		actions
	    end if
	    exit
	elsif click = 1 and (x >= maxx div 3 and x <= maxx div 2)                             %Sensors
		and (y >=
		10
		and y <= 40) then
	    sensors
	    cls
	    userinterface
	    status
	    objects
	    Draw.Box (maxx div 2 + 75, 10, maxx - 25, 40, white)
	    Draw.Fill (maxx div 2 + 90, 20, blue, white)
	    Draw.Text ("IMPULSE ENGINES", maxx div 2 + 107, 20, clickfont, white)
	    Draw.Box (maxx div 3, 10, maxx div 2, 40, white)
	    Draw.Fill (maxx div 3 + 10, 20, blue, white)
	    Draw.Text ("SENSORS", maxx div 3 + 10, 20, clickfont, white)
	    text
	    loop
		Mouse.Where (x, y, click)
		if click = 0 then
		    exit
		end if
	    end loop
	end if
	delay (5)
    end loop
end dockactions

%Klingon death animation, explosion animation when a klingon ship is destroyed
procedure deathanimation ()
    phasersize := 8
    phasercolor := 1
    for e : 1 .. 150
	cls
	userinterface
	status
	objects
	Draw.FillOval (map (deathexplosionx, 0), map (0,
	    deathexplosiony),
	    phasersize, phasersize, phasercolor)
	phasersize := phasersize + 1
	phasercolor := phasercolor + 1
	delay (5)
    end for
end deathanimation

%Klingon death check, checks if the klingon is not already, or not part of the game, then does the animation, takes away one Klingon from the count, and sets the health to 0
procedure klingondeathani ()
    if klingonx (1) not= klingonx (37) then
	if klingonhealth (1) <= 0 then
	    deathexplosionx := klingonx (1)
	    deathexplosiony := klingony (1)
	    deathanimation
	    klingonx (1) := klingonx (37)
	    klingony (1) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (1) := seckleft (1) - 1
	    klingonhealth (1) := 0
	    klingondead (1) := true
	end if
    end if
    if klingonx (2) not= klingonx (37) then
	if klingonhealth (2) <= 0 then
	    deathexplosionx := klingonx (2)
	    deathexplosiony := klingony (2)
	    deathanimation
	    klingonx (2) := klingonx (37)
	    klingony (2) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (1) := seckleft (1) - 1
	    klingonhealth (2) := 0
	    klingondead (2) := true
	end if
    end if
    if klingonx (3) not= klingonx (37) then
	if klingonhealth (3) <= 0 then
	    deathexplosionx := klingonx (3)
	    deathexplosiony := klingony (3)
	    deathanimation
	    klingonx (3) := klingonx (37)
	    klingony (3) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (1) := seckleft (1) - 1
	    klingonhealth (3) := 0
	    klingondead (3) := true
	end if
    end if
    if klingonx (4) not= klingonx (37) then
	if klingonhealth (4) <= 0 then
	    deathexplosionx := klingonx (4)
	    deathexplosiony := klingony (4)
	    deathanimation
	    klingonx (4) := klingonx (37)
	    klingony (4) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (1) := seckleft (1) - 1
	    klingonhealth (4) := 0
	    klingondead (4) := true
	end if
    end if
    if klingonx (5) not= klingonx (37) then
	if klingonhealth (5) <= 0 then
	    deathexplosionx := klingonx (5)
	    deathexplosiony := klingony (5)
	    deathanimation
	    klingonx (5) := klingonx (37)
	    klingony (5) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (2) := seckleft (2) - 1
	    klingonhealth (5) := 0
	    klingondead (5) := true
	end if
    end if
    if klingonx (6) not= klingonx (37) then
	if klingonhealth (6) <= 0 then
	    deathexplosionx := klingonx (6)
	    deathexplosiony := klingony (6)
	    deathanimation
	    klingonx (6) := klingonx (37)
	    klingony (6) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (2) := seckleft (2) - 1
	    klingonhealth (6) := 0
	    klingondead (6) := true
	end if
    end if
    if klingonx (7) not= klingonx (37) then
	if klingonhealth (7) <= 0 then
	    deathexplosionx := klingonx (7)
	    deathexplosiony := klingony (7)
	    deathanimation
	    klingonx (7) := klingonx (37)
	    klingony (7) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (2) := seckleft (2) - 1
	    klingonhealth (7) := 0
	    klingondead (7) := true
	end if
    end if
    if klingonx (8) not= klingonx (37) then
	if klingonhealth (8) <= 0 then
	    deathexplosionx := klingonx (8)
	    deathexplosiony := klingony (8)
	    deathanimation
	    klingonx (8) := klingonx (37)
	    klingony (8) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (2) := seckleft (2) - 1
	    klingonhealth (8) := 0
	    klingondead (8) := true
	end if
    end if
    if klingonx (9) not= klingonx (37) then
	if klingonhealth (9) <= 0 then
	    deathexplosionx := klingonx (9)
	    deathexplosiony := klingony (9)
	    deathanimation
	    klingonx (9) := klingonx (37)
	    klingony (9) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (3) := seckleft (3) - 1
	    klingonhealth (9) := 0
	    klingondead (9) := true
	end if
    end if
    if klingonx (10) not= klingonx (37) then
	if klingonhealth (10) <= 0 then
	    deathexplosionx := klingonx (10)
	    deathexplosiony := klingony (10)
	    deathanimation
	    klingonx (10) := klingonx (37)
	    klingony (10) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (3) := seckleft (3) - 1
	    klingonhealth (10) := 0
	    klingondead (10) := true
	end if
    end if
    if klingonx (11) not= klingonx (37) then
	if klingonhealth (11) <= 0 then
	    deathexplosionx := klingonx (11)
	    deathexplosiony := klingony (11)
	    deathanimation
	    klingonx (11) := klingonx (37)
	    klingony (11) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (3) := seckleft (3) - 1
	    klingonhealth (11) := 0
	    klingondead (11) := true
	end if
    end if
    if klingonx (12) not= klingonx (37) then
	if klingonhealth (12) <= 0 then
	    deathexplosionx := klingonx (12)
	    deathexplosiony := klingony (12)
	    deathanimation
	    klingonx (12) := klingonx (37)
	    klingony (12) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (3) := seckleft (3) - 1
	    klingonhealth (12) := 0
	    klingondead (12) := true
	end if
    end if
    if klingonx (13) not= klingonx (37) then
	if klingonhealth (13) <= 0 then
	    deathexplosionx := klingonx (13)
	    deathexplosiony := klingony (13)
	    deathanimation
	    klingonx (13) := klingonx (37)
	    klingony (13) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (4) := seckleft (4) - 1
	    klingonhealth (13) := 0
	    klingondead (13) := true
	end if
    end if
    if klingonx (14) not= klingonx (37) then
	if klingonhealth (14) <= 0 then
	    deathexplosionx := klingonx (14)
	    deathexplosiony := klingony (14)
	    deathanimation
	    klingonx (14) := klingonx (37)
	    klingony (14) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (4) := seckleft (4) - 1
	    klingonhealth (14) := 0
	    klingondead (14) := true
	end if
    end if
    if klingonx (15) not= klingonx (37) then
	if klingonhealth (15) <= 0 then
	    deathexplosionx := klingonx (15)
	    deathexplosiony := klingony (15)
	    deathanimation
	    klingonx (15) := klingonx (37)
	    klingony (15) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (4) := seckleft (4) - 1
	    klingonhealth (15) := 0
	    klingondead (15) := true
	end if
    end if
    if klingonx (16) not= klingonx (37) then
	if klingonhealth (16) <= 0 then
	    deathexplosionx := klingonx (16)
	    deathexplosiony := klingony (16)
	    deathanimation
	    klingonx (16) := klingonx (37)
	    klingony (16) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (4) := seckleft (4) - 1
	    klingonhealth (16) := 0
	    klingondead (16) := true
	end if
    end if
    if klingonx (17) not= klingonx (37) then
	if klingonhealth (17) <= 0 then
	    deathexplosionx := klingonx (17)
	    deathexplosiony := klingony (17)
	    deathanimation
	    klingonx (17) := klingonx (37)
	    klingony (17) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (5) := seckleft (5) - 1
	    klingonhealth (17) := 0
	    klingondead (17) := true
	end if
    end if
    if klingonx (18) not= klingonx (37) then
	if klingonhealth (18) <= 0 then
	    deathexplosionx := klingonx (18)
	    deathexplosiony := klingony (18)
	    deathanimation
	    klingonx (18) := klingonx (37)
	    klingony (18) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (5) := seckleft (5) - 1
	    klingonhealth (18) := 0
	    klingondead (18) := true
	end if
    end if
    if klingonx (19) not= klingonx (37) then
	if klingonhealth (19) <= 0 then
	    deathexplosionx := klingonx (19)
	    deathexplosiony := klingony (19)
	    deathanimation
	    klingonx (19) := klingonx (37)
	    klingony (19) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (5) := seckleft (5) - 1
	    klingonhealth (19) := 0
	    klingondead (19) := true
	end if
    end if
    if klingonx (20) not= klingonx (37) then
	if klingonhealth (20) <= 0 then
	    deathexplosionx := klingonx (20)
	    deathexplosiony := klingony (20)
	    deathanimation
	    klingonx (20) := klingonx (37)
	    klingony (20) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (5) := seckleft (5) - 1
	    klingonhealth (20) := 0
	    klingondead (20) := true
	end if
    end if
    if klingonx (21) not= klingonx (37) then
	if klingonhealth (21) <= 0 then
	    deathexplosionx := klingonx (21)
	    deathexplosiony := klingony (21)
	    deathanimation
	    klingonx (21) := klingonx (37)
	    klingony (21) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (6) := seckleft (6) - 1
	    klingonhealth (21) := 0
	    klingondead (21) := true
	end if
    end if
    if klingonx (22) not= klingonx (37) then
	if klingonhealth (22) <= 0 then
	    deathexplosionx := klingonx (22)
	    deathexplosiony := klingony (22)
	    deathanimation
	    klingonx (22) := klingonx (37)
	    klingony (22) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (6) := seckleft (6) - 1
	    klingonhealth (22) := 0
	    klingondead (22) := true
	end if
    end if
    if klingonx (23) not= klingonx (37) then
	if klingonhealth (23) <= 0 then
	    deathexplosionx := klingonx (23)
	    deathexplosiony := klingony (23)
	    deathanimation
	    klingonx (23) := klingonx (37)
	    klingony (23) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (6) := seckleft (6) - 1
	    klingonhealth (23) := 0
	    klingondead (23) := true
	end if
    end if
    if klingonx (24) not= klingonx (37) then
	if klingonhealth (24) <= 0 then
	    deathexplosionx := klingonx (24)
	    deathexplosiony := klingony (24)
	    deathanimation
	    klingonx (24) := klingonx (37)
	    klingony (24) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (6) := seckleft (6) - 1
	    klingonhealth (24) := 0
	    klingondead (24) := true
	end if
    end if
    if klingonx (25) not= klingonx (37) then
	if klingonhealth (25) <= 0 then
	    deathexplosionx := klingonx (25)
	    deathexplosiony := klingony (25)
	    deathanimation
	    klingonx (25) := klingonx (37)
	    klingony (25) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (7) := seckleft (7) - 1
	    klingonhealth (25) := 0
	    klingondead (25) := true
	end if
    end if
    if klingonx (26) not= klingonx (37) then
	if klingonhealth (26) <= 0 then
	    deathexplosionx := klingonx (26)
	    deathexplosiony := klingony (26)
	    deathanimation
	    klingonx (26) := klingonx (37)
	    klingony (26) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (7) := seckleft (7) - 1
	    klingonhealth (26) := 0
	    klingondead (26) := true
	end if
    end if
    if klingonx (27) not= klingonx (37) then
	if klingonhealth (27) <= 0 then
	    deathexplosionx := klingonx (27)
	    deathexplosiony := klingony (27)
	    deathanimation
	    klingonx (27) := klingonx (37)
	    klingony (27) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (7) := seckleft (7) - 1
	    klingonhealth (27) := 0
	    klingondead (27) := true
	end if
    end if
    if klingonx (28) not= klingonx (37) then
	if klingonhealth (28) <= 0 then
	    deathexplosionx := klingonx (28)
	    deathexplosiony := klingony (28)
	    deathanimation
	    klingonx (28) := klingonx (37)
	    klingony (28) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (7) := seckleft (7) - 1
	    klingonhealth (28) := 0
	    klingondead (28) := true
	end if
    end if
    if klingonx (29) not= klingonx (37) then
	if klingonhealth (29) <= 0 then
	    deathexplosionx := klingonx (29)
	    deathexplosiony := klingony (29)
	    deathanimation
	    klingonx (29) := klingonx (37)
	    klingony (29) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (8) := seckleft (8) - 1
	    klingonhealth (29) := 0
	    klingondead (29) := true
	end if
    end if
    if klingonx (30) not= klingonx (37) then
	if klingonhealth (30) <= 0 then
	    deathexplosionx := klingonx (30)
	    deathexplosiony := klingony (30)
	    deathanimation
	    klingonx (30) := klingonx (37)
	    klingony (30) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (8) := seckleft (8) - 1
	    klingonhealth (30) := 0
	    klingondead (30) := true
	end if
    end if
    if klingonx (31) not= klingonx (37) then
	if klingonhealth (31) <= 0 then
	    deathexplosionx := klingonx (31)
	    deathexplosiony := klingony (31)
	    deathanimation
	    klingonx (31) := klingonx (37)
	    klingony (31) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (8) := seckleft (8) - 1
	    klingonhealth (31) := 0
	    klingondead (31) := true
	end if
    end if
    if klingonx (32) not= klingonx (37) then
	if klingonhealth (32) <= 0 then
	    deathexplosionx := klingonx (32)
	    deathexplosiony := klingony (32)
	    deathanimation
	    klingonx (32) := klingonx (37)
	    klingony (32) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (8) := seckleft (8) - 1
	    klingonhealth (32) := 0
	    klingondead (32) := true
	end if
    end if
    if klingonx (33) not= klingonx (37) then
	if klingonhealth (33) <= 0 then
	    deathexplosionx := klingonx (33)
	    deathexplosiony := klingony (33)
	    deathanimation
	    klingonx (33) := klingonx (37)
	    klingony (33) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (9) := seckleft (9) - 1
	    klingonhealth (33) := 0
	    klingondead (33) := true
	end if
    end if
    if klingonx (34) not= klingonx (37) then
	if klingonhealth (34) <= 0 then
	    deathexplosionx := klingonx (34)
	    deathexplosiony := klingony (34)
	    deathanimation
	    klingonx (34) := klingonx (37)
	    klingony (34) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (9) := seckleft (9) - 1
	    klingonhealth (34) := 0
	    klingondead (34) := true
	end if
    end if
    if klingonx (35) not= klingonx (37) then
	if klingonhealth (35) <= 0 then
	    deathexplosionx := klingonx (35)
	    deathexplosiony := klingony (35)
	    deathanimation
	    klingonx (35) := klingonx (37)
	    klingony (35) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (9) := seckleft (9) - 1
	    klingonhealth (35) := 0
	    klingondead (35) := true
	end if
    end if
    if klingonx (36) not= klingonx (37) then
	if klingonhealth (36) <= 0 then
	    deathexplosionx := klingonx (36)
	    deathexplosiony := klingony (36)
	    deathanimation
	    klingonx (36) := klingonx (37)
	    klingony (36) := klingony (37)
	    klingonsleft := klingonsleft - 1
	    seckleft (9) := seckleft (9) - 1
	    klingonhealth (36) := 0
	    klingondead (36) := true
	end if
    end if
end klingondeathani

%Instructions, 4 pages
procedure instructions ()
    cls
    put "HOW TO PLAY:"
    put ""
    put "BASICS:"
    put "In Star Trek, you are the Starship Enterprise, the ship is symbolized as 'E'."
    put "You spawn in a random spot in sector 5."
    put "You have to destroy the 20 Klingon ships to win the game. "
    put "There are 9 sectors of space you can travel to."
    put "Each sector can have 0-4 Klingon ships, symbolized as 'K'. "
    put "These Klingons can shoot at you, they can also move around the sector. "
    put "There will be stars in each sector too, symbolized as '*'. "
    put "Stars act as barricades, you can't occupy the same space, or shoot through them."
    put "There are 0-2 stars in each sector. "
    put "You start in sector 5, there is a starbase in sector 5 as well. "
    put "The starbase contains resources that you can resupply on as you go. "
    put ""
    put "TO WIN:"
    put "You have 42 days to destroy the Klingons."
    put "You have 10000 units of power on the Enterprise."
    put "You have 100 units of shields and 100 units of hullintegrity (health)."
    put "Run out of any of the above, and you fail the mission."
    Draw.Text ("Click the Mouse!", maxx div 2 - 50, 20, clickfont, white)
    loop
	Mouse.Where (x, y, click)
	exit when click = 0
    end loop
    loop
	Mouse.Where (x, y, click)
	exit when click = 1
    end loop
    cls
    put "THE FUNCTIONS OF THE ENTERPRISE:"
    put ""
    put "The Enterprise has 4 main actions:"
    put ""
    put "It can use its Warp Engine, which transports you to different sectors."
    put "It has a power cost of 500 every time you use it. "
    put ""
    put "It can shoot Photon Torpedoes, which travel in a straight line. "
    put "It travels in only one direction, which you determine. "
    put "It has no power cost, you have an unlimited supply of photon torpedoes."
    put "It does 500 damage to a single klingon ship."
    put ""
    put "It can shoot Phasers, which does damage to all Klingons in the sector,"
    put "You can choose how much power your phaser blast does. 100, 300, or 500."
    put "The amount of power you choose is the cost of using the phasers."
    put "The damage it does is divided by the number of klingons in the sector."
    put "Ex. You choose 500 power, there are 4 klingons, you do 125 damage to each one."
    put ""
    put "It can use its Impulse Engine, which moves the Enterprise around the sector."
    put "You choose which direction you would like to move, and how many spaces."
    put "You cannot travel outside of the sector. You cannot travel into stars."
    put "It has a power cost of 50 every time you use it. "
    Draw.Text ("Click the Mouse!", maxx div 2 - 50, 20, clickfont, white)
    loop
	Mouse.Where (x, y, click)
	exit when click = 0
    end loop
    loop
	Mouse.Where (x, y, click)
	exit when click = 1
    end loop
    cls
    put "THE SENSORS:"
    put ""
    put "The Enterprise can use its sensors to detect things in the different sectors. "
    put "It can detect how many klingons, stars, and starbases there are in each sector."
    put ""
    put "KLINGONS:"
    put ""
    put "The 20 Klingon ships are spread out throughout the 9 sectors."
    put "Klingons have the ability to move around the sector and can shoot back at you."
    put "They never miss."
    put "They shoot torpedoes at you that do 25 damage."
    put "If you use the impulse engine to move into the same spot as a klingon:"
    put "You effectively crash into them, destroying the klingon and you take 25 damage."
    put "Klingons have 1000 health each, their health is shown in your status bar."
    put ""
    put "THE STATUS BAR:"
    put ""
    put "The status bar is located in the bottom left part of the screen. "
    put "It contains info about your ship and mission."
    put "It shows how many days you have left. Every two actions is considered one day."
    put "The Condition bar shows if there are any klingons in your sector."
    put "If there are klingons, your condition is RED, otherwise it's GREEN."
    put "If you are docked on the starbase, it's 'Docked'."
    Draw.Text ("Click the Mouse!", maxx div 2 - 50, 20, clickfont, white)
    loop
	Mouse.Where (x, y, click)
	exit when click = 0
    end loop
    loop
	Mouse.Where (x, y, click)
	exit when click = 1
    end loop
    cls
    put "THE STATUS BAR (continued):"
    put ""
    put "The Hull Integrity bar is you ship's health. It starts at 100 units."
    put "The Shields bar is your ship's shields. It starts as 100 untis as well."
    put "If your shields get to 0, then your hull integrity starts to get damaged."
    put "The Sector bar tells you which of the 9 sectors you are in. "
    put "The Klingons left bar tells you how many Klingons you have left to destroy."
    put "The Power bar tells you how much power the Enterprise has left. "
    put ""
    put "THE STARBASE:"
    put ""
    put "The Starbase is located in sector 5, in a random spot."
    put "Impulse Engine to the same position as the starbase to dock with it."
    put "The Starbase turns green when you are docked."
    put "You can only use your Impulse engines when you are docked."
    put "The Starbase contains 50 hull integrity units, and 100 shield units."
    put "It also contains 3000 power units."
    put "The Starbase will give you as many units as it can until you can hold no more."
    put ""
    put "THE TEXT SCREEN:"
    put "The text screen is located in the top right part of your screen."
    put "It exists only to tell you events and information."
    Draw.Text ("Are you ready to play? Click the Mouse!", maxx div 2 - 120, 20, clickfont, white)
    loop
	Mouse.Where (x, y, click)
	exit when click = 0
    end loop
    loop
	Mouse.Where (x, y, click)
	exit when click = 1
    end loop
end instructions

%Main Program

%Title Screen and Mission Details
colorback (black)
color (white)
cls
%Pic.Draw (coverpic, 90, 40, picCopy)
Draw.Text ("STAR TREK", maxx div 3 - 10, maxy - 50, titlefont, white)
waitforclick
cls

%Mission details
Draw.Text ("STAR TREK", maxx div 3 - 10, maxy - 50, titlefont, white)
Draw.Text ("Welcome, Captain of the Starship Enterprise.", maxx div 2 - 250, maxy - 100, clickfont, white)
Draw.Text ("Your orders are:", maxx div 2 + 100, maxy - 100, clickfont, white)
Draw.Text ("The year is 2450. Destroy the 20 Klingon ships in 42 days.", 100, maxy - 150, clickfont, white)
Draw.Text ("There are 9 sectors of Federation Space.", 180, maxy - 200, clickfont, white)
Draw.Text ("Good luck, Captain!", maxx div 2 - 60, maxy - 250, clickfont, white)
Draw.Text ("Click the Mouse anywhere to start!", maxx div 2 - 100, 20, clickfont, white)
Draw.Text ("How To Play (i)", maxx - 135, 20, clickfont, white)
loop
    Mouse.Where (x, y, click)
    exit when click = 0
end loop

%Decides whether the user wants to see the intructions, or continue to the game
loop
    Mouse.Where (x, y, click)
    Input.KeyDown (chars)
    if chars ('i') then
	instructions
	exit
    end if
    exit when click = 1
end loop
cls
userinterface
status
objects
if shipcondition not= "Docked" then
    actions
else
    dockactions
end if

%Main game
loop

    %Klingon action(s)
    if shipcondition not= "Docked" then
	klingonturn
    end if

    %Checking death conditions
    if hullintegrity <= 0 then
	cls
	Draw.Text ("YOU DIED", maxx div 3 - 10, maxy - 50, titlefont, white)
	exit
    elsif power <= 0 then
	cls
	Draw.Text ("YOU RAN OUT OF POWER", maxx div 8 - 45, maxy - 50, titlefont, white)
	exit
    elsif daysleft <= 0 then
	cls
	Draw.Text ("YOU RAN OUT OF TIME", maxx div 8 - 20, maxy - 50, titlefont, white)
	exit
    end if

    %Starbase check
    starbasedock

    %Player action
    if shipcondition not= "Docked" then
	actions
    elsif shipcondition = "Docked" then
	dockactions
    end if

    %If you warp into a Klingon, it explodes
    collision

    %Klingon death check and animation
    klingondeathani

    %Checking win conditions
    if klingonsleft <= 0 then
	cls
	Draw.Text ("YOU WIN", maxx div 3 - 10, maxy - 50, titlefont, white)
	exit
    end if

    %Half a day passes
    daysleft := daysleft - 5
end loop

%Enterprise destruction
if klingonsleft not= 0 then
    %Pic.Draw (deathpic, maxx div 2 - 100, 40, picCopy)
end if
delay (5000)
Window.Close (0)
