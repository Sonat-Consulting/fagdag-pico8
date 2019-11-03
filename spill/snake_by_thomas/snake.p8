pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

x=nil
y=nil
direction=nil

cell_size=nil
board_size=32
speed=3
tick=nil
snake_length=nil
snake={}
food=nil
head=nil

function _init()
    x=0
    y=0
    direction=right    
    cell_size=128/board_size
    tick=0
    snake_length=4
    snake={}
    food=nil
    head=nil
end

function _update()
    change_direction()

    tick+=1
    if(tick>=speed) then
        tick=0
        game_loop()
    end
end

function _draw()
    cls(peach) 
    -- rect(0,0,127,127,orange)
    
    draw_snake()
    draw_food()
end

function game_loop()
    feed_snake()
    move_snake()
    grov_snake()
    eat_food()
    start_over()
end 

function move_snake()
    if(direction==right) then
        move_right()
    elseif(direction==up) then
        move_up()
    elseif(direction==left) then
        move_left()
    elseif(direction==down) then
        move_down()
    end
end

function grov_snake()
    add(snake, head)
    if(#snake >= snake_length) then
        del(snake, snake[1])
    end
end

function feed_snake()
    if(food ~= nil) return

    food=random_cell()

    while (snake_collision(food)) do
        food=random_cell()
    end
end

function random_cell()
    local x = flr(rnd(board_size))
    local y = flr(rnd(board_size))

    return {x, y}
end

function snake_collision(thing)
    for coordinate in all(snake) do
        if(collision(coordinate, thing)) then
            return true
        end
    end    
    return false
end

function eat_food()
    if(collision(head, food))then
        snake_length+=4
        food=nil
    end
end

function start_over()
    for coordinate in all(snake) do
        if(collision(coordinate, head)) then
            if(coordinate ~= head) then
                _init()
            end
        end
    end    
end

function draw_snake()
    for coordinate in all(snake) do
        draw_cell(coordinate, orange)
    end
end

function draw_food()
    draw_cell(food, red)
end

function change_direction()
    if(btnp(➡️) and direction ~= left) then
        direction=right
    elseif(btnp(⬅️) and direction ~= right) then
        direction=left
    elseif(btnp(⬆️) and direction ~= down) then
        direction=up
    elseif(btnp(⬇️) and direction ~= up) then
        direction=down
    end
end

function move_down()
    y+=1
    if(y>=board_size)then
        y=0
    end
    head={x,y}
end

function move_left()
    x-=1
    if(x<0)then
        x=board_size-1
    end
    head={x,y}
end

function move_up()
    y-=1
    if(y<0)then
        y=board_size-1
    end
    head={x,y}    
end

function move_right()
    x+=1    
    if (x>=board_size) then
        x=0
    end
    head={x,y}
end

function collision(a, b)
    if(a==nil)return false
    if(b==nil)return false
    return a[1]==b[1] and a[2]==b[2]
end

function draw_cell(coordinate, color)
    if(coordinate == nil) return
    local screen_x = coordinate[1]*cell_size
    local screen_y = coordinate[2]*cell_size

    rectfill(screen_x,screen_y,screen_x+cell_size-1,screen_y+cell_size-1,color)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
