pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--globals
--by terje wiesener

--Game
btnup = 2
btndown = 3

paddlewidth = 4
paddleheight = 24
paddlemargin = 2

gamespeed=2
-->8
--update
function _update()
  t += 1
  if ball.velx < 0 then checkcollision(paddle1)
  else checkcollision(paddle2) end
  checkbounds()

  ball.x += ball.velx * gamespeed
  ball.y += ball.vely * gamespeed
  paddle1:move()
  paddle2:move()
end

function checkcollision(paddle)
  if (ball.y) < paddle:top() then return end
  if (ball.y) > paddle:bottom() then return end
  
  local collision = false
  
  if ball.velx > 0 then
      --ball moving right, check left edge:
      collision = ball.x < paddle:left() and ball.x + ball.size >= paddle:left()
  else
      --ball movung left, check right edge
    collision = ball.x > paddle:right() and ball.x - ball.size <= paddle:right()
  end
  if collision then
			 --reverse ball direction
	   ball.velx = -ball.velx
    --offset the ball y direction depending on which side was hit
    local dist = ball.y - paddle:center()
    ball.vely += dist / paddleheight
  end
end

function reset()
    ball.x = 64  
    ball.y = 64    
    ball.vely = 2 - rnd(4)
end
  
function checkbounds()
  if ball.x < ball.size then
    --ballen er utenfor venstre side, poeng til spiller2
    paddle2.points += 1
    reset()
  end
  if ball.x > 128 - ball.size then
    --ballen er utenfor venstre side, poeng til spiller2
    paddle1.points += 1
    reset()
  end
  if ball.y > 128 - ball.size or ball.y < ball.size then
    ball.vely = -ball.vely
  end
end

-->8
--drawing
function _draw()
  cls(7)
  paddle1:draw()
  paddle2:draw()
  drawball(ball)
  print(paddle1.points, 1, 1, 0)
  print(paddle2.points, 117, 0, 0)
end

function drawball(ball)
  circfill(ball.x, ball.y, ball.size, ball.col)
  circ(ball.x, ball.y, ball.size, 5)
end


-->8
--init

function _init()
  t = 0
  
  paddlemax = 128 - paddleheight
  
  paddle1 = paddle:new()
  paddle1.color = 11
  
  paddle2 = paddle:new()
  paddle2.x = 128 - paddlewidth - paddlemargin
		paddle2.color = 12
  
  ball = 
  {
    x = 64,
    y = 64,
    size = 2,
    col = 15,
    velx = 1,
    vely = 0
  }
  
end


-->8
--paddle

--paddle default values:
paddle = {
	width = paddlewidth,
	height = paddleheight,
	x = paddlemargin,
	y = 64,
	color = 15,
	speed = 1,
	points = 0,
	direction = 1,
	player = 0
}

--paddle functions
function paddle.top(p) 
	return p.y
end
	
function paddle.bottom(p) 
	return p.y + p.height
end
	
function paddle.left(p) 
	return p.x
end
	
function paddle.right(p) 
	return p.x + p.width
end
	
function paddle.center(p) 
	return p.y + (p.height / 2)
end
	
function paddle.aimove(p)
  if p:top() > ball.y - ball.size then 
    p.direction = -1 
  elseif p:bottom() < ball.y + ball.size then 
    p.direction = 1 
  else 
    p.direction = 0
  end
end

function paddle.playermove(p)
  if btn(btnup) then 
  	p.direction = -1
  elseif btn(btndown) then 
  	p.direction = 1
  else
  	p.direction = 0
		end
end

function paddle.move(p)
	if p.player == 0 then
		p:aimove()
	else
		p:playermove()
 end

	p.y += p.direction * p.speed * gamespeed
	p.y = clamp(p:top(), 0, paddlemax)
end

function clamp(val, minval, maxval)
    return min(maxval, max(minval, val))
end
  
function paddle.draw(p)
  local x = p:left()
  local y = p:top()
  local x1 = p:right() - 1
  local y1 = p:bottom() - 1
  
  rectfill(x, y, x1, y1, p.color)
  rect(x, y, x1, y1, 0)
end

--paddle constructor:
function paddle:new(o)
	self.__index = self
	return setmetatable(o or {}, self)
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
