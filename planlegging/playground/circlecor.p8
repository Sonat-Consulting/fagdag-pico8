pico-8 cartridge // http://www.pico-8.com
version 8
__lua__

x=4
y=4

x2 = 124
y2 = 124

x3 = 4
y3 = 124

x4 = 124
y4 = 4

cor = nil
cor2 = nil
cor3 = nil
cor4 = nil

function anim()
  for i=4,120,4 do
    x=i
    y=i
    yield()
  end
end

function anim2()
  for i=120,4,-4 do
    x2=i+4
    y2=i+4
    yield()
  end
end
 
function anim3()
  for i=4,120,4 do
    x3=i
    y3=120 - i + 4
    yield()
  end
end

function anim4()
  for i=120,4,-4 do
    x4=i+4
    y4=120-i +8
    yield()
  end
end

function _update()
  if btnp(5) then
    if (cor == nil) cor = cocreate(anim)
    if (cor2 == nil) cor2 = cocreate(anim2)
    if (cor3 == nil) cor3 = cocreate(anim3)
    if (cor4 == nil) cor4 = cocreate(anim4)
  end

  if cor and costatus(cor) != 'dead' then
    coresume(cor)
  else
    cor = nil
  end

  if cor2 and costatus(cor2) != 'dead' then
    coresume(cor2)
  else
    cor2 = nil
  end
  if cor3 and costatus(cor3) != 'dead' then
    coresume(cor3)
  else
    cor3 = nil
  end

  if cor4 and costatus(cor4) != 'dead' then
    coresume(cor4)
  else
    cor4 = nil
  end
end
 
function _draw()
  cls(13)
  circfill(x, y, 4, 12)
  circfill(x2, y2, 4, 8)
  circfill(x3, y3, 4, 11)
  circfill(x4, y4, 4, 3)
end
