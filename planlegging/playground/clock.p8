pico-8 cartridge // http://www.pico-8.com
version 8
__lua__

t=0

seconds=0
minutes=0
hours=0

function _update()
  t+=1
  if t % 30 == 0 then
    if minutes != 0 and minutes % 59 == 0 then
      --one full minute
      hours = hours+1
    end
    -- one full second
    if seconds != 0 and seconds % 59 == 0 then
      --one full minute
      minutes = (minutes+1)%60
    end
    seconds = (seconds+1)%60
  end
end
 
function _draw()
  cls(13)
  print("t:"..t, 2, 2, 12)
  print("seconds:"..seconds, 2, 120, 12)
  print(hours ..":".. minutes ..":".. seconds, 80, 2, 12)

  camera(-63, -63)
  circ(0, 0, 55, 8)
  for i=1,12 do
    local x,y = handpos(i/12, 45)
    print(i, x, y, 7)
  end

  local hands = {
    {
      angle=seconds,
      length = 55,
      color = 12
    },
    {
      angle = minutes,
      length = 50,
      color = 3
    },
    {
      angle = hours,
      length = 45,
      color = 1
    }
  }

  for hand in all(hands) do
    local x,y = handpos(hand.angle / 60, hand.length)
    line(0, 0, x, y, hand.color)
  end
  camera(0,0)
end

function handpos(angle, scale)
  local rotated = 0.25 - angle
  return scale * cos(rotated), scale * sin(rotated)
end
