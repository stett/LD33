
-- Create the new sex world - pardon, I meant "secs world"
Secs = require('lib/secs')
world = Secs:new()


function love.load()
    world:addSystem('render', require('systems/render'))
end
