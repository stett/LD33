module = {}

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
    local grid = {}
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
                children={},
                background={},
            })
        end
    end

    -- Connect grid hexes
    for i = 1, width do
        for j = 1, height do
            neighbors = {}

            --table.insert(neighbors, i < width ? grid[i+1][j] : nil)

            --[[
            grid[i][j].neighbors = {
                (i < width) ? grid[i+1][j] : nil,
                (i < width) ? ((j % 2 == 0) ? grid[i][j+1] : grid[i+1][j+1]) : nil,
                (i > 1) ? ((j % 2 == 0) ? grid[i-1][j+1] : grid[i][j+1]) : nil,
                (i > 1) ? grid[i-1][j] : nil,
                (i > 1) ? ((j % 2 == 0) ? grid[i][j-1] : grid[i-1][j-1]) : nil,
                (i < width) ? ((j % 2 == 0) ? grid[i][j-1] : grid[i+1][j-1]) : nil,
            }
            ]]

        end
    end
end

return module