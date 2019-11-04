pico-8 cartridge // http://www.pico-8.com
version 18
__lua__

left,right,up,down,fire1,fire2=0,1,2,3,4,5
black,dark_blue,dark_purple,dark_green,brown,dark_gray,light_gray,white,red,orange,yellow,green,blue,indigo,pink,peach=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15

palette = {[0]=129,1,131,140,12,7}
numcolors = 6


function _init()
    dim = 12
    coords = {}
    for y=-dim,dim do
        for x=-dim,dim do 
            coord = {x * 4, 0, y * 4}
            add(coords, coord)
        end
    end

    local c = 16
    cube = buildcube(16)

    t = 0
    for i=0,numcolors-1 do
        pal(i,palette[i], 1)
    end
    pal(14,0,1)
    pal(15,7,1)
end

function _update()
    local scale = 128
    local wavescale = 6
    for c in all(coords) do
        local wave1 = cos(2 * c[1] / scale  - t/60)
        c[2] = wave1 * wavescale
        c[4] = 1 + wave1
    end
    t += 1    
end

function _draw()
    cls(14)
    color(15)    
    print(stat(0))
    print(stat(1))

    local projection = build_axonometric((0 + 45) / 360, 210 / 360)

    camera(-64,-64) --center view on 0,0 in XZ-plane
    for l in all(cube.lines) do
        c1 = transformvector(cube.coords[l[1]], projection)
        c2 = transformvector(cube.coords[l[2]], projection)
        line(c1[1], c1[2], c2[1], c2[2], yellow)
    end

    for c in all(coords) do
        local i = transformvector(c, projection)
        local col = c[4] * numcolors / 2
        pset(i[1], i[2], col)
    end

    local p0 = transformvector({-64,0,-64}, projection)
    local x1 = transformvector({0,0,-64}, projection)
    local z1 = transformvector({-64,0,0}, projection)
    line(p0[1], p0[2], x1[1], x1[2], red)
    line(p0[1], p0[2], z1[1], z1[2], green)

    camera(0,0)
end

function build_axonometric(a, b)
    return {
        cos(a), 0, sin(a),
        sin(b)*sin(a), cos(b), -sin(b)*cos(a),
        -cos(b)*sin(a), sin(b), cos(b)*cos(a)
    } 
end

function buildcube(scale)
    return {
        coords = {
            {-scale, -scale, -scale},
            {-scale, -scale, scale},
            {scale, -scale, scale},
            {scale, -scale, -scale},
            {-scale, scale, -scale},
            {-scale, scale, scale},
            {scale, scale, scale},
            {scale, scale, -scale},
        },
        lines = {
            --bottom
            {1,2},
            {2,3},
            {3,4},
            {4,1},

            --top
            {5,6},
            {6,7},
            {7,8},
            {8,5},

            --pillars
            {1,5},
            {2,6},
            {3,7},
            {4,8},
        }
    }
end

function transformvector(vector3, matrix3x3)
    local transformed = {0,0,0}
    for newrow=1,3 do
        for col=1,3 do
            transformed[newrow] += vector3[col] * matrix3x3[(newrow - 1) * 3 + col]
        end
    end
    return transformed
end

function multvector(vector3, val)
    return {vector3[1] * val, vector3[2] * val, vector3[3] * val}
end

function vectortostring(vector3)
    return "("..vector3[1]..","..vector3[2]..","..vector3[3]..")"
end

