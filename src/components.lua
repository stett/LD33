local settings = require('settings')
local anim8 = require('lib/anim8')

return {
    register = function(world)

        -- 'hex' attaches one entity to a specific slot in the grid system,
        -- and 'hexes' attaches the grid system to the instance.
        world:addComponent('hex', {slot=nil})
        world:addComponent('hexes', {list={}})

        -- Tracks adjacency between grid spaces.
        -- The neighbors component is owned by the base grid spaces.
        world:addComponent('neighbors', {
            east={},
            southeast={},
            southwest={},
            west={},
            northwest={},
            northeast={}})

        -- Generic position and offset
        world:addComponent('position', {x=0, y=0})
        world:addComponent('offset', {x=0, y=0})

        -- Physics properties 
        world:addComponent('velocity', {x=0, y=0})
        world:addComponent('acceleration', {x=0, y=0})
        world:addComponent('collision', {slot=nil})
        world:addComponent('hover', {height=2})

        -- Behavior properties
        world:addComponent('orbit', {other=nil})

        -- Graphics properties
        world:addComponent('sprite', {
            image=love.graphics.newImage("res/green.png")})
        world:addComponent('sprite_batch', {
            batch=love.graphics.newSpriteBatch(
                love.graphics.newImage("res/gray.png"),
                settings.GRID_SIZE.width * settings.GRID_SIZE.height)})
        world:addComponent('flicker', {amount=100})
        world:addComponent('jitter', {linear=1, angular=10})

        -- Eye properties
        eye_pupil_image = love.graphics.newImage('res/eye-pupil.png')
        eye_white_image = love.graphics.newImage('res/eye-white.png')
        eye_lid_image = love.graphics.newImage('res/eye-lid.png')
        eye_lid_grid = anim8.newGrid(20, 20, eye_lid_image:getWidth(), eye_lid_image:getHeight())
        world:addComponent('eye', {
            blink_timer = 10,
            blink_period = 100,
            pupil_image = eye_pupil_image,
            white_image = eye_white_image,
            lid_image = eye_lid_image,
            lid_anim = anim8.newAnimation(eye_lid_grid('1-3', 1), .2),
        })
        world:addComponent('fuz', {life=100})

        -- Control properties
        world:addComponent('jumpy')
    end
}
