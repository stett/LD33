local grid = require('grid')
local module = {}

--[[

    ' ': Nothing

    '#': Earth

    '*': Boulder

    '^': Cottage

    '!': Villager

    '+': Spawn point

]]

function module.clear(world)

    -- Delete all hexes
    for entity in pairs(world:query('hex')) do
        world:delete(entity)
    end

    -- Delete all grid spaces
    for entity in pairs(world:query('hexes')) do
        world:delete(entity)
    end
end

function module.generate(world, background_hex_image, level_table)

    -- Get dimensions from the table
    local grid_width = #level_table[1]
    local grid_height = #level_table

    -- Add the sprite batch entity for the background hex image
    local grid_sprite_batch = world:addEntity({sprite_batch = {
        batch=love.graphics.newSpriteBatch(
            love.graphics.newImage(background_hex_image),
            grid_width * grid_height)}})

    -- Generate the grid spaces
    grid.generate_grid(world, grid_width, grid_height, settings.HEX_SIZE, grid_sprite_batch.sprite_batch.batch)

    -- Loop over the level table and fill in the grid
    for j, row in ipairs(level_table) do
        for i = 1, #row do
            local c = row:sub(i,i)

            -- If this is not empty, make an entity matching the character code
            if c ~= ' ' then
                hex = grid.add_hex(world, i, j)

                -- Earth
                if c == '#' then
                    world:attach(hex, {
                        sprite={image=love.graphics.newImage("res/brown.png")},
                        offset={},
                        velocity={},
                        acceleration={},
                    })
                end
            end
        end
    end
end

return module