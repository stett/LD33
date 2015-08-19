settings = require('settings')

return {
    register = function(world)

        -- Attaches one entity to a specific slot in the grid system
        world:addComponent('hex', {slot=nil})

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

        -- Graphics properties
        world:addComponent('sprite', {
            image=love.graphics.newImage("res/green.png")})
        world:addComponent('sprite_batch', {
            batch=love.graphics.newSpriteBatch(
                love.graphics.newImage("res/gray.png"),
                settings.GRID_SIZE.width * settings.GRID_SIZE.height)})
    end
}
