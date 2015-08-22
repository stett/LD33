return {
    position = {x=0, y=0},

    transform = function(x, y)
        local w, h = love.window.getWidth(), love.window.getHeight()
        local mx = x + view.position.x - w / 2
        local my = y + view.position.y - h / 2
        return mx, my
    end
}