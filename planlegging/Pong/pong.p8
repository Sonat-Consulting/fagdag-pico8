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
  
  local side = myball:checkbounds()
  if side != nil then
    if side == "right" then 
      paddle1.points += 1
    elseif side == "left" then
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
function paddle:top() 
	return self.y
end
	
function paddle:bottom() 
	return self.y + self.height
end
	
function paddle:left() 
	return self.x
end
	
function paddle:right() 
	return self.x + self.width
end
	
function paddle:center() 
	return self.y + (self.height / 2)
end
	
function paddle:aimove()
  if self:top() > myball.y - myball.size then 
    self.direction = -1 
  elseif self:bottom() < myball.y + myball.size then 
    self.direction = 1 
  else 
    self.direction = 0
  end
end

function paddle:playermove()
  if btn(btnup) then 
  	self.direction = -1
  elseif btn(btndown) then 
  	self.direction = 1
  else
  	self.direction = 0
		end
end

function paddle:move()
	if self.player == 0 then
		self:aimove()
	else
		self:playermove()
 end

	self.y += self.direction * self.speed * gamespeed
	self.y = clamp(self:top(), 0, paddlemax)
end

function clamp(val, minval, maxval)
    return min(maxval, max(minval, val))
end
  
function paddle:draw()
  local x = self:left()
  local y = self:top()
  local x1 = self:right() - 1
  local y1 = self:bottom() - 1
  
  rectfill(x, y, x1, y1, self.color)
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
function ball:draw()
  circfill(self.x, self.y, self.size, self.col)
  circ(self.x, self.y, self.size, 5)
end

function ball:reset()
  self.x = 64  
  self.y = 64    
  self.vely = 2 - rnd(4)
end

function ball:checkbounds()
  if self.x < self.size then
    --ball has exited on left hand side, points to player 2
    self:reset()
    return "left"
  end
  if self.x > 128 - self.size then
    --ball has exited on right hand side, points to player 1
    self:reset()
    return "right"
  end
  if self.y > 128 - self.size or self.y < self.size then
    self.vely = -self.vely
  end
  return nil
end

function ball:move()
  self.x += self.velx * gamespeed
  self.y += self.vely * gamespeed
end
