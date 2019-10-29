pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

function _draw()  
  cls(7)
  local blends = {
    0b1111111111111111,
    0b1011111010111110,
    0b1110010110110101,
    0b0101101001011010,
    0b0001101001011010,
    0b0100000101000001,
  }

  local ramps ={
    {0,2,8,14,7},
    {0,4,9,15,7},
    {7},
    {0,4,9,10,7},
    {0,0,3,11,7},
    {0,0,1,12,7},
    {0,0,1,13,7},
    {7},
    {8,9,10,11,12,13},
    {7},
    {0,5,6,7},
  } 

  local width = 4
  local height = 8
  local spacing = 2

  local y = 10
  for ramp in all(ramps) do
    local x=2
    for i=1,#ramp do
      local j = min(i + 1, #ramp)
      local from = ramp[i]
      local to = ramp[j]
      if i == j then
        fillp(1)
        rectfill(x, y, x + width - 1, y + height - 1, from * 16 + to)
        x += width
      else
        for blend in all(blends) do
          fillp(blend)
          rectfill(x, y, x + width - 1, y + height - 1, from * 16 + to)
          x += width
        end
      end
    end
    y += height + spacing
  end
end
