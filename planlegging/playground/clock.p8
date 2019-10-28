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
  --rect(0,0,127,127, 1)
  --circfill(x, y, 4, 12)

  print("t:"..t, 2, 2, 12)
  print("seconds:"..seconds, 2, 120, 12)
  print(hours ..":".. minutes ..":".. seconds, 80, 2, 12)

  circ(63, 63, 55, 8)
  --line(63,63, 63+55, 63, 7) -- at 3
  --line(63,63, 63, 63+55, 7) -- at 6
  --line(63,63, 63-55, 63, 7) -- at 9
  --line(63,63, 63, 63-55, 7) -- at 12

  for i=1,12 do
    local j = 63 + 45*cos(-i*1.0/12+0.25)
    local k = 63 + 45*sin(-i*1.0/12+0.25)
    print(i, j, k, 7)
  end

  --line(63, 63, 63+55*cos(-t*1.0/60), 63+55*sin(-t*1.0/60), 12)
  line(63, 63, 63+55*cos(-seconds*1.0/60+0.25), 63+55*sin(-seconds*1.0/60+0.25), 12) -- blue 
  line(63, 63, 63+50*cos(-minutes*1.0/60+0.25), 63+50*sin(-minutes*1.0/60+0.25), 3) -- darkgreen
  line(63, 63, 63+45*cos(-hours*1.0/60+0.25), 63+45*sin(-hours*1.0/60+0.25), 1) -- darkblue

end
