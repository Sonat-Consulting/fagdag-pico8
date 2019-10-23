pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
--gameloop

function _init()
    t = 0
    
    mouse = mouse:new()
    mouse:init()

    explosions = {}
end

function _update()
    mouse:update()

    if mouse:ispressed(buttons.left) then
        local explosion = explosion:new({x = mouse.x, y = mouse.y})
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
    mouse:draw()
end


-->8
--mouse

function clamp(num, minval, maxval)
    return max(min(num, maxval), minval)
end

buttons = {
    left = 1,
    right = 2,
    middle = 4
}

mouse = {
    x = 0, 
    y = 0,
    down = {},
    wasdown = {}
}

function mouse:new(o)
	self.__index = self
	return setmetatable(o or {}, self)
end

function mouse:init()
    --enable mouse:
    poke(0x5F2D, 1)
end

function mouse:isdown(v)
    return self.down[v]
end

function mouse:ispressed(v)
    return self.down[v] and not self.wasdown[v]
end

function mouse:isreleased(v)
    return self.wasdown[v] and not self.down[v]
end

function mouse:update()
    self.x = clamp(stat(32), 0, 128)
    self.y = clamp(stat(33), 0, 128)
    
    local buttonstate = stat(34)
    
    for k,v in pairs(buttons) do
        self.wasdown[v] = self.down[v]
        self.down[v] = band(buttonstate, v) > 0
    end
end

function mouse:draw()
    camera(4,4)
    spr(0, self.x, self.y)
    camera(0,0)
end

-->8
--explosion

explosion = {
    duration = 30,
    maxradius = 20,
    radius = 0,
    alive = true
}

--call with {x=...,y=...,}
function explosion:new(o)
    --self is the "default" explosion table declared earlier
    self.__index = self
    local obj = setmetatable(o or {}, self)
    -- obj is our new, "constructed" instance
    obj.starttime = t
    return obj
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
