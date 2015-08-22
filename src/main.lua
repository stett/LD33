
-- Create the new sex world - ahm, "secs world"
local Secs = require('lib/secs')
local world = Secs:new()

-- Others
local settings = require('settings')
local components = require('components')
local grid = require('grid')


function love.load()

    -- Initialize components
    components.register(world)

    -- Add systems
    world:addSystem('render', require('renderSystem'))
    world:addSystem('physics', require('physicsSystem'))

    -- Generate the grid
    grid_sprite_batch = world:addEntity({sprite_batch={}})
    grid.generate_grid(world, settings.GRID_SIZE.width, settings.GRID_SIZE.height, settings.HEX_SIZE, grid_sprite_batch.sprite_batch.batch)

    -- Add some hexes to the grid?

    -- "L"
    world:attach(grid.add_hex(world, 31, 35), {sprite = {}, offset={}, velocity={x=40, y=-45}, acceleration={}})
    world:attach(grid.add_hex(world, 31, 36), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 31, 37), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 31, 38), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 31, 39), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 31, 40), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 32, 40), {sprite = {}, offset={}, velocity={}, acceleration={}})

    -- "D"
    world:attach(grid.add_hex(world, 35, 38), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 34, 38), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 34, 39), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 34, 40), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 35, 40), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 36, 39), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 36, 37), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 35, 36), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 36, 35), {sprite = {}, offset={}, velocity={}, acceleration={}})

    -- "-"
    world:attach(grid.add_hex(world, 38, 38), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 39, 38), {sprite = {}, offset={}, velocity={}, acceleration={}})

    -- "3"
    world:attach(grid.add_hex(world, 42, 35), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 43, 35), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 43, 36), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 43, 37), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 42, 37), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 43, 38), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 43, 39), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 42, 40), {sprite = {}, offset={}, velocity={}, acceleration={}})

    -- "3"
    world:attach(grid.add_hex(world, 45, 35), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 46, 35), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 46, 36), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 46, 37), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 45, 37), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 46, 38), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 46, 39), {sprite = {}, offset={}, velocity={}, acceleration={}})
    world:attach(grid.add_hex(world, 45, 40), {sprite = {}, offset={}, velocity={}, acceleration={}})

    for i = 28, 49 do
        world:attach(grid.add_hex(world, i, 32), {sprite = {}, offset={}, velocity={}, acceleration={}})
        world:attach(grid.add_hex(world, i, 43), {sprite = {}, offset={}, velocity={}, acceleration={}})
    end
    for j = 32, 43 do
        world:attach(grid.add_hex(world, 28, j), {sprite = {}, offset={}, velocity={}, acceleration={}})
        world:attach(grid.add_hex(world, 49, j), {sprite = {}, offset={}, velocity={}, acceleration={}})
    end
end

function love.update(dt)
    world:update(dt)
end

function love.draw()
    w, h = love.window.getWidth(), love.window.getHeight()
    love.graphics.translate(w/2, h/2)
    love.graphics.scale(.5)
    world:draw()
end

-- Escape quits
function love.keypressed(key, isrepeat)
    if key == 'escape' then
        love.event.quit()
    end
end
