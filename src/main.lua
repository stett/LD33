
-- Create the new sex world - ahm, "secs world"
local Secs = require('lib/secs')
local world = Secs:new()

-- Others
local settings = require('settings')
local components = require('components')
--local grid = require('grid')
local level = require('level')


function love.load()

    -- Initialize components
    components.register(world)

    -- Add systems
    world:addSystem('render', require('renderSystem'))
    world:addSystem('physics', require('physicsSystem'))

    -- Load a level
    level.generate(world, 'res/gray.png', {0, 0, 0}, {
        '                                                                                          ',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '',
        '                                                          ^^^',
        '                               ##                         |  |',
        '                              ###                        |   |',
        '                             #####                       |    |                     ',
        '                           ######################        | . |                   ',
        '                        ##################################################################',
        '###                #######################################################################',
        '##########################################################################################',
        '##########################################################################################',
        '##########################################################################################',
        '##########################################################################################',
        '##########################################################################################',
        '##########################################################################################',
        '##########################################################################################',
        '##########################################################################################',
        '##########################################################################################',
    })
end

function love.update(dt)
    world:update(dt)
end

function love.draw()

    w, h = love.window.getWidth(), love.window.getHeight()
    love.graphics.translate(w/2, h/2)
    love.graphics.scale(.65)
    world:draw()
end

-- Escape quits
function love.keypressed(key, isrepeat)
    if key == 'escape' then
        love.event.quit()
    end
end
