module = {}

local grid = {}

local function get_xy(i, j, width, height, size) 
    local x = (i - width / 2)
    local y = (j - height / 2) * .845
    if j % 2 ~= 0 then x = x - .5 end
    x = x * size
    y = y * size
    return x, y
end

function module.generate_grid(world, width, height, size, sprite_batch)

    -- Create the components required for a grid object

    -- Generate grid hex entities
    for i = 1, width do
        grid[i] = {}
        for j = 1, height do
            local x, y = get_xy(i, j, width, height, size)
            local id = sprite_batch:add(
                x, y, 0, 1, 1,
                sprite_batch:getImage():getWidth() / 2,
                sprite_batch:getImage():getHeight() / 2)
            grid[i][j] = world:addEntity({
                position={x=x, y=y},
                neighbors={},
                --children={},
                --background={},
            })
        end
    end

    -- Connect grid hexes
    for i = 1, width do
        for j = 1, height do
            neighbors = {}
            hex = grid[i][j]
            hex.neighbors.east = i < width and grid[i+1][j] or nil
            hex.neighbors.southeast = i < width and (j % 2 == 0 and grid[i+1][j+1] or grid[i][j+1]) or nil
            hex.neighbors.southwest = i > 1 and (j % 2 == 0 and grid[i][j+1] or grid[i-1][j+1]) or nil
            hex.neighbors.west = i > 1 and grid[i-1][j] or nil
            hex.neighbors.northwest = i > 1 and (j % 2 == 0 and grid[i][j-1] or grid[i-1][j-1]) or nil
            hex.neighbors.northeast = i < width and (j % 2 == 0 and grid[i][j-1] or grid[i+1][j-1]) or nil
        end
    end
end

function module.add_hex(world, i, j)
    return world:addEntity({hex = {slot=grid[i][j]}})
end

return module