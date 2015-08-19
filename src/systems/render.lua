return {
    draw = function(self)

        -- Draw instances of spritebatches with positions that are marked as background images
        for entity in pairs(self.world:query('sprite_batch')) do
            love.graphics.draw(entity.sprite_batch.batch)
        end
    end
}
