local settings = require('settings')
local view = require('view')

return {
    draw = function(self)

        local mx, my = view.transform(love.mouse.getPosition())
        love.graphics.circle("line", mx, my, 20)

        -- Draw an offset dot for hex items with offsets
        for entity in pairs(self.world:query('hex offset')) do
            position = {
                x = entity.hex.slot.position.x + entity.offset.x,
                y = entity.hex.slot.position.y + entity.offset.y}
            love.graphics.setColor(255, 0, 0, 255)
            love.graphics.circle("fill", position.x, position.y, 2)
            love.graphics.setColor(0, 0, 0, 255)
            love.graphics.circle("line", position.x, position.y, 3)
            love.graphics.setColor(255, 255, 255, 255)
        end

        -- Highlight hex slots containing hexes
        for entity in pairs(self.world:query('position hexes')) do
            if next(entity.hexes.list) ~= nil then
                num = #entity.hexes.list 
                love.graphics.print(tostring(num), entity.position.x - settings.HEX_SIZE / 3, entity.position.y - settings.HEX_SIZE / 3)
            end
        end

        -- Draw lines between neighbors
        --[[
        love.graphics.setColor(255, 255, 255, 100)
        for entity in pairs(self.world:query('position neighbors')) do

            if entity.neighbors.east ~= nil then
                love.graphics.line(
                    entity.position.x + 6,
                    entity.position.y,
                    entity.neighbors.east.position.x - 6,
                    entity.neighbors.east.position.y)
            end

            if entity.neighbors.southeast ~= nil then
                love.graphics.line(
                    entity.position.x + 3,
                    entity.position.y + 4,
                    entity.neighbors.southeast.position.x - 3,
                    entity.neighbors.southeast.position.y - 4)
            end

            if entity.neighbors.southwest ~= nil then
                love.graphics.line(
                    entity.position.x - 3,
                    entity.position.y + 4,
                    entity.neighbors.southwest.position.x + 3,
                    entity.neighbors.southwest.position.y - 4)
            end
        end
        love.graphics.setColor(255, 255, 255, 255)
        ]]
    end
}
