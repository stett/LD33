return {
    update = function(self, dt)
        for entity in pairs(self.world:query('eye')) do

            -- Update blink timer
            entity.eye.blink_timer = entity.eye.blink_timer - dt

            -- Blink if necessary
            if entity.eye.blink_timer < 0 then

                -- TODO:
                -- Blinking code...

                entity.eye.blink_timer = love.math.random(entity.eye.blink_period)
            end

            -- Update the animation
            --entity.eye.lid_anim:update(dt)
        end
    end,

    draw = function(self)
        for entity in pairs(self.world:query('hex offset eye')) do
            position = {
                x = entity.hex.slot.position.x + entity.offset.x,
                y = entity.hex.slot.position.y + entity.offset.y,
            }
            love.graphics.draw(entity.eye.white_image, position.x, position.y, 0, 1, 1, entity.eye.white_image:getWidth() / 2, entity.eye.white_image:getHeight() / 2)
            love.graphics.draw(entity.eye.pupil_image, position.x, position.y, 0, 1, 1, entity.eye.pupil_image:getWidth() / 2, entity.eye.pupil_image:getHeight() / 2)
            entity.eye.lid_anim:draw(entity.eye.lid_image, position.x, position.y, 0, 1, 1, 10, 10)
        end
    end
}