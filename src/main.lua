
-- Create the new sex world - pardon, I meant "secs world"
Secs = require('lib/secs')
world = Secs:new()

-- Others
settings = require('settings')
components = require('components')
grid = require('factories/grid')


function love.load()

    -- Initialize components
    components.register(world)

    -- Add systems
    world:addSystem('render', require('systems/render'))

    -- Generate the grid
    grid_sprite_batch = world:addEntity({sprite_batch={}})
    grid.generate_grid(world, settings.GRID_SIZE.width, settings.GRID_SIZE.height, 20, grid_sprite_batch.sprite_batch.batch)

    -- Add some hexes to the grid?
    hex = grid.add_hex(world, 51, 35)
    world:attach(hex, {
        sprite = {},
        offset = {},
        velocity = {x=3, y=0}})
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
