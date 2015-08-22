local module = {}

local _grid = {}
local _width = 0
local _height = 0
local _size = 0

function module.get_xy(i, j, width, height, size) 
    local x = (i - width / 2)
    local y = (j - height / 2) * .845
    if j % 2 ~= 0 then x = x - .5 end
    x = x * size
    y = y * size
    return x, y
end

function module.get_hex(x, y)
    i = (x / _size + _width / 2)
    j = (y / _size + _height / 2) / .845
    if j % 2 ~= 0 then i = i + 1 end

    if i > 1 and j <= _width and j > 1 and j <= _height then
        return _grid[math.floor(i)][math.floor(j)]
    else
        return nil
    end
end

function module.get_neighbor(slot, angle)

    -- Convert angle to degrees so I can tell what the hell I'm doing
    local angle = angle * 180 / math.pi
    while angle < 0 do angle = angle + 360 end

    -- Return the corresponding neighbor
    if 330 <= angle or angle < 30 then  
        return slot.neighbors.east
    elseif angle < 90 then              
        return slot.neighbors.southeast
    elseif angle < 150 then             
        return slot.neighbors.southwest
    elseif angle < 210 then             
        return slot.neighbors.west
    elseif angle < 270 then             
        return slot.neighbors.northwest
    elseif angle < 330 then             
        return slot.neighbors.northeast
    else
        return nil
    end
end

function module.generate_grid(world, width, height, size, sprite_batch)

    -- Save the width and height
    _width = width
    _height = height
    _size = size

    -- Generate grid hex entities
    for i = 1, width do
        _grid[i] = {}
        for j = 1, height do
            local x, y = module.get_xy(i, j, width, height, size)
            local id = sprite_batch:add(
                x, y, 0, 1, 1,
                sprite_batch:getImage():getWidth() / 2,
                sprite_batch:getImage():getHeight() / 2)
            _grid[i][j] = world:addEntity({
                position={x=x, y=y},
                neighbors={},
                hexes={list={}},
            })
        end
    end

    -- Connect grid hexes
    for i = 1, width do
        for j = 1, height do
            hex = _grid[i][j]
            hex.neighbors.east = i < width and _grid[i+1][j] or nil
            hex.neighbors.southeast = i < width and (j % 2 == 0 and _grid[i+1][j+1] or _grid[i][j+1]) or nil
            hex.neighbors.southwest = i > 1 and (j % 2 == 0 and _grid[i][j+1] or _grid[i-1][j+1]) or nil
            hex.neighbors.west = i > 1 and _grid[i-1][j] or nil
            hex.neighbors.northwest = i > 1 and (j % 2 == 0 and _grid[i][j-1] or _grid[i-1][j-1]) or nil
            hex.neighbors.northeast = i < width and (j % 2 == 0 and _grid[i+1][j-1] or _grid[i][j-1]) or nil
        end
    end
end

function module.add_hex(world, i, j)
    local slot = _grid[i][j]
    local entity = world:addEntity({hex = {slot=slot}})
    table.insert(slot.hexes.list, entity)
    return entity
end

return module