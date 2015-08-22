return {
    update = function(self, dt)

        -- Clear all accelerations
        for entity in pairs(self.world:query('gravity acceleration')) do
            entity.acceleration.x = 0
            entity.acceleration.y = 1200
        end
    end
}