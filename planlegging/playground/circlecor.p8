pico-8 cartridge // http://www.pico-8.com
version 8
__lua__

x=4
y=4

x2 = 123
y2 = 123

x3 = 4
y3 = 123

x4 = 123
y4 = 4

cor = nil
cor2 = nil
cor3 = nil
cor4 = nil

function anim()
  for i=4,123,1 do
    x=i
    y=i
    yield()
  end
end

function anim2()
  for i=123,4,-1 do
    x2=i
    y2=i
    yield()
  end
end
 
function anim3()
  for i=4,123,1 do
    x3=i
    y3=127 - i
    yield()
  end
end

function anim4()
  for i=123,4,-1 do
    x4=i
    y4=127-i
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
  rect(0,0,127,127, 1)
  circfill(x, y, 4, 12)
  circfill(x2, y2, 4, 8)
  circfill(x3, y3, 4, 11)
  circfill(x4, y4, 4, 3)

  print("1:("..x..","..y..")", 1, 53, 12)
  print("2:("..x2..","..y2..")", 1, 58, 8)
  print("3:("..x3..","..y3..")", 1, 64, 11)
  print("4:("..x4..","..y4..")", 1, 70, 3)
end
