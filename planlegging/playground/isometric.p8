pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

palette = {[0]=129,1,131,140,12,7}
numcolors = 6

function _init()
    num = 28
    coords = {}
    for y=0,num-1 do
        for x=0,num-1 do 
            coord = {[0] = x * 4, 0, y * 4}
            add(coords, coord)
        end
    end

    sqrt3 = 3 ^ 0.5
    sqrt2 = 2 ^ 0.5
    sqrt6 = 6 ^ 0.5

    isometricvector = {[0]=sqrt3, 0, -sqrt3,
                     1, 2, 1,
                     sqrt2, -sqrt2, sqrt2}

    t = 0

    for i=0,numcolors-1 do
        pal(i,palette[i], 1)
    end
    pal(14,0,1)
    pal(15,7,1)
end

function _update()
    for y=0,num-1 do
        for x=0,num-1 do
            local coord = coords[y * num + x + 1]
            local wave1 = cos(2 * x / num  + t/60)
            coord[1] = wave1 * 6
            coord[3] = 1 + wave1
        end
    end
    t += 1    
end

function transformvector(vector3, matrix3x3)
    local transformed = {[0] = 0,0,0}
    for newrow=0,2 do
        for col=0,2 do
            transformed[newrow] += vector3[col] * matrix3x3[newrow * 3 + col]
        end
    end
    return transformed
end

function multvector(vector3, val)
    return {[0] = vector3[0] * val, vector3[1] * val, vector3[2] * val}
end

function vectortostring(vector3)
    return "("..vector3[0]..","..vector3[1]..","..vector3[2]..")"
end

function isometric(coord)
    local transformed = transformvector(coord, isometricvector)
    local projected = {[0] = transformed[0], transformed[4], 0}
    local scaled = multvector(transformed, 1 / sqrt6)
    scaled[0] += 64
    scaled[1] += 16
    return scaled
end

function _draw()
    cls(14)
    print(stat(0), 4, 4, 15)
    local count = 0
    for c in all(coords) do
        local i = isometric(c)
        local col = numcolors - (c[3] * numcolors / 2)
        pset(i[0], i[1], col)
        count+=1
    end
end
