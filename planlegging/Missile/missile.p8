pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

function _init()
    t = 0
    
    --enable mouse:
    poke(0x5F2D, 1)

    explosions = {}

    button1 = 1
    button2 = 2
    button3 = 4
    buttons = {button1,button2, button3}

    prevstate = 0
end
function clamp(num, minval, maxval)
    return max(min(num, maxval), minval)
end

function getmousepos()
    x = clamp(stat(32), 0, 128)
    y = clamp(stat(33), 0, 128)
    return x, y
end

function checkmousebuttons()
    local buttonstate = stat(34)

    pressed = {}
    for button in all(buttons) do
        local isdown = band(buttonstate, button) > 0
        local wasdown = band(prevstate, button) > 0
        pressed[button] = isdown and not wasdown
    end
    prevstate = buttonstate
    return pressed
end

function _update()
    mousex, mousey = getmousepos()
    pressed = checkmousebuttons()

    if pressed[button1] then
        local explosion = explosion:new({x = mousex, y = mousey, starttime = t})
        add(explosions, explosion)
    end
    for ex in all(explosions) do
        if not ex:isalive() then
            del(explosions, ex)
        else
            ex:update()
        end
    end
    t += 1
end

function _draw()
    cls()
    for ex in all(explosions) do
        ex:draw()
    end
    camera(4,4)
    spr(0, mousex, mousey)
    camera(0,0)
end

mousebuttons = {
    left = 1,
    right = 2,
    middle = 4
}

mouse = {
    x = 0, 
    y = 0,
    currentstate = 0,
    previousstate = 0,
    down = {}
    pressed = {}
    released = {}
}


explosion = {
    x = 64, 
    y = 64,
    starttime = 0,
    duration = 30,
    maxradius = 20,
    radius = 0,
    alive = true
}

function explosion:new(o)
	self.__index = self
	return setmetatable(o or {}, self)
end

function explosion:draw()
    for r=0,self.radius do
        circfill(self.x, self.y, self.radius - r, (self:frame() + r) % 15 + 1)
    end
end

function explosion:update()
    if self:frame() > self.duration then
        self.alive = false
    elseif self.radius < self.maxradius then
        self.radius += 1
    end
end

function explosion:isalive()
    return self.alive
end

function explosion:frame()
    if self.radius < self.maxradius then return 0 end
    return t - self.starttime - self.maxradius
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
