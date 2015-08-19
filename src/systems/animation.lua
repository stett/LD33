return {
    update = function(dt)

        -- Update all animations
        for entity in pairs(self.world:query('animation'))
            entity.animation.anim:update(dt)
        end
    end
}