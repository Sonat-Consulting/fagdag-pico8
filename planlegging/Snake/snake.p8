pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
    t = 0
    reset()
end

function reset()
    trail = {}
    length = 2
    x = 64
    y = 64
    spawnfood()
    dirx = 1
    diry = 0
    alive = true
end

function spawnfood()
    --fixme: should check if the food location is empty
    foodx = flr(rnd(128))
    foody = flr(rnd(128))
    while not isempty(foodx,foody) do
        foodx = flr(rnd(128))
        foody = flr(rnd(128))
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

    t += 1
    if t % 2 == 1 then return end


    --animate move to next tile
    x += dirx
    y += diry

    if x < 0 or x > 127 or y < 0 or y > 127 then
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
    add(trail, {x = x,y = y})
    if #trail > length then
        del(trail, trail[1])
    end
    
    checkinput()
end

function gameover()
	alive = false
	cursor(50, 50, 0)
	print("game over")
	print("score: "..length - 2)
	print("press ❎ to restart")
end
	
function checkinput()
	if btn(⬆️) then 
		diry = -1
		dirx = 0
	elseif btn(⬇️) then
		diry = 1
		dirx = 0
	elseif btn(⬅️) then
	    dirx = -1
	    diry = 0
	elseif btn(➡️) then
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
    pset(x,y,13)
end

function drawsegment(segment)
	pset(segment.x,segment.y,8)
end

function drawfood()
	pset(foodx, foody, 9)
end
