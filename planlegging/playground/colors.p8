pico-8 cartridge // http://www.pico-8.com
version 8
__lua__

blends = {
  0b1111111111111111,
  0b1011111010111110,
  0b1110010110110101,
  0b0101101001011010,
  0b0001101001011010,
  0b0100000101000001,
  0b0000000000000000,
}

function _init()
  blendindex = 1
end

function _update()
  if btnp(2) then
    blendindex += 1
    blendindex = min(blendindex, 7)
  elseif btnp(3) then
    blendindex -= 1
    blendindex = max(blendindex, 1)
  end
  percent = (blendindex - 1) / 6
end

function _draw()  
  cls()
  -- dithering:
  fillp(blends[blendindex])
  for i=0,15 do
    for j=i,15 do
      rectfill(i * 8, j * 8, i * 8 + 6, j * 8 + 6, i * 16 + j)
    end
    for j=0,i do
      rectfill(i * 8, j * 8, i * 8 + 6, j * 8 + 6, i * 16 + j)
    end
  end
end