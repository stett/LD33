local grid = require('grid')
local settings = require('settings')
local module = {}

--[[

    ' ': Nothing

    '#': Earth

    '*': Boulder

    '^': Cottage roof

    '|': Wood

    '!': Villager

    '+': Spawn point

    '.': Ember

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

function module.generate(world, background_hex_image, background_color, level_table)

    -- Set the background color
    love.graphics.setBackgroundColor(background_color)

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

                -- Player
                if c == '+' then
                    local player = world:attach(hex, {
                        eye={},
                        offset={},
                        velocity={},
                        acceleration={},
                        hover={height=4},
                        jumpy={},
                        attractor={},
                        gravity={}
                        --explode={},
                    })
                    --world:attach(hex, {
                    --    sprite={image=love.graphics.newImage("res/shadowfuz.png")},
                    --    flicker={amount=10},
                    --    jitter={linear=1, angular=360},
                    --})

                -- Earth
                elseif c == '#' then
                    world:attach(hex, {
                        sprite = {image=love.graphics.newImage("res/green.png")},
                        --gainsPhysicsWhenDestroyed = {},
                        --offset={},
                        --velocity={},
                        --acceleration={},
                        destructable={}
                    })

                -- Stone
                elseif c == "*" then
                    world:attach(hex, {
                        sprite = {image=love.graphics.newImage("res/light.png")},
                        offset={},
                        velocity={},
                        acceleration={},
                        attracted={},
                        gravity={}
                    })

                -- Wood
                elseif c == '|' then
                    world:attach(hex, {
                        sprite={image=love.graphics.newImage("res/brown.png")},
                        --offset={},
                        --velocity={},
                        --acceleration={},
                    })

                -- Roofing
                elseif c == '^' then
                    world:attach(hex, {
                        sprite={image=love.graphics.newImage("res/yellow.png")},
                    })

                -- Ember
                elseif c == '.' then
                    world:attach(hex, {
                        sprite={image=love.graphics.newImage("res/orange.png")},
                        flicker={amount=50},
                    })
                end
            end
        end
    end
end

return module