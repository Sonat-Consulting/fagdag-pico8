pico-8 cartridge // http://www.pico-8.com
version 8
__lua__

trace = {}

vec = {x = 0, y = 0}

function vec:new(x, y)
  self.__index = self
  return setmetatable({x=x, y=y}, vec)
end

function vec.__add(a, b)
  printh("called add")
  if type(a) == "number" then return vec:new(a + b.x, a + b.y) end
  if type(b) == "number" then return vec:new(a.x + b, a.y + b) end
  return vec:new(a.x + b.x, a.y + b.y)
end

function vec.__sub(a, b)
  if type(a) == "number" then return vec:new(a - b.x, a - b.y) end
  if type(b) == "number" then return vec:new(a.x - b, a.y - b) end
  return vec:new(a.x - b.x, a.y - b.y)
end

function vec.__mul(a, b)
  if type(a) == "number" then return vec:new(a * b.x, a * b.y) end
  if type(b) == "number" then return vec:new(a.x * b, a.y * b) end
  return vec:new(a.x * b.x, a.y * b.y)
end

function vec.__eq(a, b)
  return a.x == b.x and a.y == b.y
end

function vec:rotate(angle)
  return vec:new(flr(self.x*cos(angle) - self.y*sin(angle)),
                 flr(self.x*sin(angle) + self.y*cos(angle)))
end

function vec:norm()
  return vec:new(flr(self.x/len(self)),
                 flr(self.y/len(self)))
end

function len(a) 
  return sqrt(a.x^2 + a.y^2)
end

function dot(a, b)
  return a.x * b.x + a.y * b.y
end

x=4
y=4

cur_dir = vec:new(1, 0)
cur_pos = vec:new(32, 96)

cor = 1
col = 0

function anim_turtle()
  for i=1,10,1 do  
    col = (i % 4)  + 11
    forward(64)
    turn(0.25)
    col = (i% 4) +3
    forward(64)
    turn(0.25)
  end
end

U = vec:new(0, -1)
R = vec:new(1, 0)
D = vec:new(0, 1)
L = vec:new(-1, 0)

function forward(pix)
  local p = nil
  if cur_dir == U or cur_dir == R
   or cur_dir == L or cur_dir == D then
    p = pix
  else
    p = flr(pix / 1.4142)
  end

  for i = 1,p do
    cur_pos = cur_dir + cur_pos
    yield()
  end
end

function turn(angle)
  cur_dir = cur_dir:rotate(angle)
  cur_dir = cur_dir:norm()
  -- changed direction
end

function _update()
  if cor == 1 then
    cor = cocreate(anim_turtle)
  end

  if cor and costatus(cor) != 'dead' then
    coresume(cor)
    add(trace, {pos = cur_pos, c = col})
  else
    cor = nil
  end
end

notcleaned = 1

function _draw()
  if notcleaned then
    cls()
    notcleaned = 0
  end
  
  print("pos(" .. cur_pos.x .. ", " .. cur_pos.y .. ")", 1, 10, 3)
  print("dir(" .. cur_dir.x .. ", " .. cur_dir.y .. ")", 1, 16, 3)

  local v = vec:new(63, 63)

  for tr in all(trace) do
    pset(tr.pos.x, tr.pos.y, tr.c)
  end  
  
  if cor == nil then
    print("turtle stopped", 1, 110, 3)
  end

end
