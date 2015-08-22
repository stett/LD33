return {
    update = function(self, dt)

        -- Clear all accelerations
        for entity in pairs(self.world:query('acceleration')) do
            entity.acceleration.x = 0
            entity.acceleration.y = 600
        end
    end
}