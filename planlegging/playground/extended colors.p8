pico-8 cartridge // http://www.pico-8.com
version 8
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

function _init()
  extended = false
end

function _update()
  if btnp(fire1) then
    extended = not extended
  end
end

function _draw()  
  cls()
  for i=0,15 do
    new = i
    if extended then new += 128 end 
    pal(i, new, 1)
  end

  for i=0,3 do
    for j=0,3 do
      rectfill(i * 32, j * 32, i * 32 + 31, j * 32 + 31, i * 4 + j)
    end
  end
end