pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
    t = 0
    tilesize = 4
    width = 128 / tilesize
    height = 128 / tilesize
    reset()
end

function reset()
    trail = {}
    length = 2
    x = width / 2
    y = height / 2
    spawnfood()
    dirx = 1
    diry = 0
    alive = true
end

function spawnfood()
    --fixme: should check if the food location is empty
    foodx = flr(rnd(width))
    foody = flr(rnd(height))
    while not isempty(foodx,foody) do
        foodx = flr(rnd(width))
        foody = flr(rnd(height))
    end
end

function isempty(x, y)
    for segment in all(trail) do
        if segment.x == x and segment.y == y then
            return false
        end
    end
    return true
end
	
function _update()
    if not alive then
        if btn(❎) then
            _init()
        end
        return
    end

    checkinput()

    t += 1
    if t % tilesize != 0 then return end

    x += dirx
    y += diry

    if x < 0 or x >= width  or y < 0 or y >= height then
        gameover()
    end
    if not isempty(x,y) then
        gameover()
    end
    if not alive then return end

    if x == foodx and y == foody then
 	    length += 1
 	    spawnfood()
    end 
    add(trail, {x = x, y = y})
    if #trail > length then
        del(trail, trail[1])
    end
    
end

function gameover()
	alive = false
	cursor(30, 30, 0)
	print("game over")
	print("score: "..length - 2)
	print("press ❎ to restart")
end
	
function checkinput()
	if btn(⬆️) and diry != 1 then
		diry = -1
		dirx = 0
	elseif btn(⬇️) and diry != -1 then
		diry = 1
		dirx = 0
	elseif btn(⬅️) and dirx != 1 then
	    dirx = -1
	    diry = 0
	elseif btn(➡️) and dirx != -1 then
	    dirx = 1
	    diry = 0
	end
end		

function _draw()
    if not alive then return end
    cls(7)
	for segment in all(trail) do
		drawsegment(segment)
	end
    drawhead()
    drawfood()
end

function drawhead()
    local index = 1
    spr(index, x*tilesize, y*tilesize)
end

function drawsegment(segment)
	spr(0, segment.x * tilesize,segment.y * tilesize)
end

function drawfood()
	spr(2, foodx * tilesize, foody * tilesize)
end
__gfx__
03300000044000000990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3bb300004884000099f9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3bb30000488400009f99000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
03300000044000000990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
