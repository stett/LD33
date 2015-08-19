return {
    draw = function(self)

        -- Draw instances of spritebatches with positions that are marked as background images
        for entity in pairs(self.world:query('sprite_batch')) do
            love.graphics.draw(entity.sprite_batch.batch)
        end

        -- Render gridded hexes that have sprites
        for entity in pairs(self.world:query('hex sprite')) do
            position = entity.hex.slot.position
            image = entity.sprite.image
            love.graphics.draw(
                image,
                position.x, position.y,
                0, 1, 1,
                image:getWidth() / 2,
                image:getHeight() / 2)
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
