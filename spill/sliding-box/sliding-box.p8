pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

-- Global variables : board sizing
cellsize = 8
numcells = ceil(128 / cellsize)
frame_counter = 1

function _init()
    x, y = 10, 10
    x_direction = 0
    y_direction = 0
    load_new_map = true
    is_moving = false
    map_number = 0
end


function new_coords()

    -- Proposed new coords
    x_new = x + x_direction
    y_new = y + y_direction 

    -- Check if the proposed new coords are on a brick
    sprite_id = mget(x_new + map_number * numcells, y_new)
    blocked_sprite = fget(sprite_id, 0)

    -- If on a brick, return old coords
    if blocked_sprite then
        return x, y
    else
        -- If not not a brick check map border walls
        x_new = min(max(x + x_direction, 0), numcells - 1)
        y_new = min(max(y + y_direction, 0), numcells - 1)
        return x_new, y_new
    end

end

function _update()
    frame_counter = frame_counter + 1

    -- Get new coords from the user if we're not moving
    if (not is_moving) then
        if (btnp(0)) then
            x_direction = -1
            y_direction = 0
        elseif (btnp(1)) then
            x_direction = 1
            y_direction = 0
        elseif (btnp(2)) then
            x_direction = 0
            y_direction = -1
        elseif (btnp(3)) then
            x_direction = 0
            y_direction = 1
        end
    end

    -- Compute new coords, taking care of bricks and map walls
    x_new, y_new = new_coords()

    -- Check if we're moving
    is_moving = not ((x_new == x) and (y_new == y))

    winner = (fget(mget(x_new + map_number * numcells, y_new), 1) 
                and not 
              fget(mget(x + map_number * numcells, y), 1))

    -- Update the current coordinates
    x, y = x_new, y_new

    if (winner) then
        map_number = map_number + 1 
        load_new_map = true
    end

    -- If a new map is loaded, find initial sprite position
    -- move the character and turn off the current movement
    if load_new_map then
        for mx=0,numcells-1 do  
            for my=0,numcells-1 do  
                sprite_id = mget(mx + map_number * numcells, my)
                if fget(sprite_id, 2) then
                    x = mx  
                    y = my
                    is_moving = false
                    load_new_map = false
                    x_direction = 0
                    y_direction = 0
                    break
                end
            end
        end
    end
end

function _draw()
    cls(15)
    map(map_number * 16,0,0,0,16,16)
    rectfill(x * cellsize, y * cellsize, (x + 1) * cellsize -1, (y + 1) * cellsize -1, 3)
    if map_number > 1 then
        cls(15)
        print("\n\n\n\n    You're a god damn winner!")
    end
end


__gfx__
00000000ddddddd63333333311111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d55555563bbbbbb31cccccc1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700d55555563b2222b31cffffc1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000d55555563b2442b31cf11fc1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000d55555563b2442b31cf11fc1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700d55555563b2222b31cffffc1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000d55555563bbbbbb31cccccc1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000666666663333333311111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0001020400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010201010101010101010101010101010101010101020101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000101000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000101000100000000010101010000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000001000000000101000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000101000000010000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000010101000001000000000000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000001000000010000000000000101000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000100000000000101000001000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000101000000000100000001000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000100000000000000000101000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000010000000101000000010000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101000000000000000000000000000101010000000000000000000100000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000101000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000101000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000101000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101030101010101010101010101010101010301010101010101010101010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000