local view = require('view')

return {
    draw = function(self)
        local w, h = love.window.getWidth(), love.window.getHeight()
        local position = {x=w/2, y=h/2}

        position.x = view.position.x
        position.y = view.position.y

        love.graphics.translate(-position.x, -position.y)
    end
}