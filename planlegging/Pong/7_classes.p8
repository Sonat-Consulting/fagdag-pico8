pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

--globals
btnup = 2
btndown = 3

paddlewidth = 4
paddleheight = 24
paddlemargin = 2

gamespeed=2

ballsize = 2

-->8
--init

function _init()
  t = 0
  
  paddlemax = 128 - paddleheight
  
  paddle1 = paddle:new()
  paddle1.color = 11
  paddle1.player = 1

  paddle2 = paddle:new()
  paddle2.x = 128 - paddlewidth - paddlemargin
  paddle2.color = 12
  
  myball = ball:new()
end

-->8
--update
function _update()
  t += 1
  if myball.velx < 0 then 
    checkcollision(paddle1, myball)
  else 
    checkcollision(paddle2, myball) 
  end
  
  local point = myball:checkbounds()
  if point > 0 then
    if point == 1 then 
      paddle1.points += 1
    elseif point == 2 then
      paddle2.points += 1
    end
  end

  paddle1:move()
  paddle2:move()
  myball:move()
end

function checkcollision(paddle, ball)
  if (ball.y) < paddle:top() then return end
  if (ball.y) > paddle:bottom() then return end
  
  local hitpaddle = false
  
  if ball.velx > 0 then
    --ball moving right, check left edge:
    hitpaddle = ball.x < paddle:left() and ball.x + ball.size >= paddle:left()
  else
      --ball moving left, check right edge
      hitpaddle = ball.x > paddle:right() and ball.x - ball.size <= paddle:right()
  end
  if hitpaddle then
    --reverse ball direction
    ball.velx = -ball.velx
    --offset the ball y direction depending on which side was hit
    local dist = ball.y - paddle:center()
    ball.vely += dist / paddleheight
  end
end


-->8
--drawing
function _draw()
  cls(7)
  paddle1:draw()
  paddle2:draw()
  myball:draw()
  print(paddle1.points, 1, 1, 0)
  print(paddle2.points, 117, 0, 0)
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

--paddle constructor:
function paddle:new(o)
	self.__index = self
	return setmetatable(o or {}, self)
end

--paddle methods
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
  if p:top() > myball.y - myball.size then 
    p.direction = -1 
  elseif p:bottom() < myball.y + myball.size then 
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

-->8
--ball

--ball default values
ball = 
{
  x = 64,
  y = 64,
  size = ballsize,
  col = 15,
  velx = 1,
  vely = 0
}  

--ball constructor:
function ball:new(o)
	self.__index = self
	return setmetatable(o or {}, self)
end

--ball methods
function ball.draw(ball)
  circfill(ball.x, ball.y, ball.size, ball.col)
  circ(ball.x, ball.y, ball.size, 5)
end

function ball.reset(ball)
  ball.x = 64  
  ball.y = 64    
  ball.vely = 2 - rnd(4)
end

function ball.checkbounds(ball)
  if ball.x < ball.size then
    --ball has exited on left hand side, points to player 2
    ball:reset()
    return 2
  end
  if ball.x > 128 - ball.size then
    --ball has exited on right hand side, points to player 1
    ball:reset()
    return 1
  end
  if ball.y > 128 - ball.size or ball.y < ball.size then
    ball.vely = -ball.vely
  end
  return -1
end

function ball.move(ball)
  ball.x += ball.velx * gamespeed
  ball.y += ball.vely * gamespeed
end