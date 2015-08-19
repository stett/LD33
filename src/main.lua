
-- Create the new sex world - pardon, I meant "secs world"
Secs = require('lib/secs')
world = Secs:new()

-- Import factories
grid = require('factories/grid')


function love.load()

    -- Settings
    GRID_SIZE = {width=102, height=71}

    -- Make some components
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
    world:addComponent('spriteBatchInstance', {id=nil})
    world:addComponent('sprite_batch', {
        batch=love.graphics.newSpriteBatch(
            love.graphics.newImage("res/gray.png"), GRID_SIZE.width * GRID_SIZE.height)
    })

    -- Add systems
    world:addSystem('render', require('systems/render'))

    -- Make some entities
    grid_sprite_batch = world:addEntity({sprite_batch={}})
    grid.generate_grid(world, GRID_SIZE.width, GRID_SIZE.height, 20, grid_sprite_batch.sprite_batch.batch)--grid_sprite_batch)
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
