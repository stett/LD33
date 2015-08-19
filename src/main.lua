
-- Create the new sex world - pardon, I meant "secs world"
Secs = require('lib/secs')
world = Secs:new()

-- Import factories
grid = require('factories/grid')

-- Other imports
anim8 = require('lib/anim8')


function love.load()

    -- Settings
    GRID_SIZE = {width=103, height=71}

    -- Make some components
    world:addComponent('hex', {slot=nil})
    world:addComponent('position', {x=0, y=0})
    world:addComponent('neighbors', {
        east={},
        southeast={},
        southwest={},
        west={},
        northwest={},
        northeast={}})
    world:addComponent('children', {list={}})
    world:addComponent('background')
    world:addComponent('sprite_batch', {
        batch=love.graphics.newSpriteBatch(
            love.graphics.newImage("res/gray.png"), GRID_SIZE.width * GRID_SIZE.height)
    })
    world:addComponent('sprite', {image=nil})

    -- Add systems
    world:addSystem('render', require('systems/render'))

    -- Generate the grid
    grid_sprite_batch = world:addEntity({sprite_batch={}})
    grid.generate_grid(world, GRID_SIZE.width, GRID_SIZE.height, 20, grid_sprite_batch.sprite_batch.batch)

    -- Add some hexes to the grid?
    hex = grid.add_hex(world, 51, 35)
    world:attach(hex, {sprite={image=love.graphics.newImage("res/green.png")}})
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
