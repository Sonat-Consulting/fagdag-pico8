pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

heatmap = {0,1,5,2,3,4,8,9,10,11,12,13,14,15,6,7}

function _init()
	t = 0
	
	for i=0,15 do
		pal(i,heatmap[i+1],0)
	end

	settings = {
		{"pwidth", 1},
		{"pheight",2},
	   	{"numx",64},
	 	{"numy",32},
	 	{"startx",0},
	 	{"starty",0},
	 	{"f1",1},
	 	{"f2",1},
	 	{"f3",2},
		{"borderx", 1},
		{"bordery",2},
	}
	menucount = #settings
		
	debug = false
	selected = 1
	readconfig()
	music(0)
end

function readconfig()
	pw = settings[1][2]
	ph = settings[2][2]
	numx = settings[3][2]
	numy = settings[4][2]	
	startx = settings[5][2]
	starty = settings[6][2]
	f1 = settings[7][2]
	f2 = settings[8][2]
	f3 = settings[9][2]
	borderx = settings[10][2]
	bordery = settings[11][2]
	f = (f1 + f2 + f3)
end

function _update()
 debug = btn(❎)
 if debug then
	 if btnp(⬆️) then selected -= 1 end
	 if btnp(⬇️) then selected += 1 end
	 selected = max(1, selected)
	 selected = min(menucount, selected)
	 if btnp(⬅️) then 
	 	settings[selected][2] -= 1 
	 	readconfig()
	 	end
	 if btnp(➡️) then 
	 	settings[selected][2] += 1
	 	readconfig()
	 end
	end	
end

function _draw()
	cls()
	plasma()
	t += 1
	if debug then 
		drawmenu()
	end
end
 

-->8

function drawmenu()
	local width = 50
	rectfill(0,0,width,(1 + menucount) * 6,7)
 	rectfill(0,selected * 6, width, selected * 6 + 6, 2)
 	color(0)
 	cursor(1,1)
	print(tostr(stat(1)*100).."% cpu")
	
	for i=1,menucount do
		local setting = settings[i]
 		print(setting[1]..": "..setting[2])
	 end
	 
	 for i=0,15 do
		rectfill(120,i * 7, 123, i * 7 + 7, 15 - i)
	end

end
 
-->8

function plasma() 
	local t1 = t / 97
	local t2 = t / 113
	local t3 = (t % (137*4)) / 137
	local cost3 = cos(t1/3)
	local sint = sin(t1)
	local sint4 = sin(t3/4)
	local cost4 = cos(t3/4)

	local pre = {}

	for x=0,numx do
		local col = {}
		col.px = startx + x * (pw + borderx)
		col.px2 = col.px + pw - 1
		col.x1 = col.px / 128
		col.x2 = col.px / 512
		col.v = 0
		col.xsint = x * sint
		col.cx2 = col.x2 + sint4
		col.cx2 *= col.cx2

		if f1 > 0 then
			col.v += sin(col.x1 + t1)
		end

		add(pre, col)
	end

	local factor = 15.5 / (2 * f)

	for y=0,numy-1 do
		local py = starty + y * (ph + bordery)
		local py2 = py + ph - 1
		local y1 = py / 512
		local ycost = py * cost3
		local cy2 = y1 + cost4
		cy2 *= cy2

		for x=0,numx-1 do
			col = pre[x + 1]
			v = col.v
			if f2 > 0 then
				v += sin((col.xsint + ycost) / 64 + t2)
			end

			if f3 > 0 then
				v += sin((col.cx2 + cy2 -0.6 )^0.5)
			end

			rectfill(
				col.px,
				py,
				col.px2,
				py2,
				flr((f + v) * factor) 
			)
		end
	end

end

__sfx__
00180100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000024050290502b050
001800002d0501a0002d05031000320002d0502b050290502b050380002b05000000000002e0502d0502b05029050000002905000000000002905028050290502b050000000000000000000002e0502d0502b050
001800002905005400290500940009400290502805027050260500540029050044003d4002905028050260502405006400240500540005400240502605028050290500140003400034000140024050290502b050
001800001d0501d0501d0501d0501d0501d0501d0501d0501a0501a0501a0501a0501a0501a0501a0501a0501c0501c0501c0501c0501c0501c0501c0501c0501d0501d0501d0501d0501d0501d0501d0501d050
0118000021050210502105021050210502105021050210501d0501d0501d0501d0501d0501d0501d0501d0501f0501f0501f0501f0501f0501f0501f0501f0502105021050210502105021050210502105021050
001800001d0501d0501d0501d0501d0501d0501d0501d0501f0501f0501f0501f0501f0501f0501f0501f0501d0501d0501d0501d0501d0501d0501d0501d0501c0501c0501c0501c0501c0501c0501c0501c050
0018000021050210502105021050210502105021050210501c0501c0501c0501c0501c0501c0501c0501c05021050210502105021050210502105021050210501805018050180501805018050180501805018050
__music__
00 00030444
00 01424344
00 02424344
01 01050644
02 02030444

