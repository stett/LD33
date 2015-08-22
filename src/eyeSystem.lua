local view = require('view')
local grid = require('grid')

local fuz_image = love.graphics.newImage('res/shadowfuz.png')

return {
    update = function(self, dt)
        for entity in pairs(self.world:query('hex eye')) do

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

            -- Make the view follow the eye
            view.position = entity.hex.slot.position


            -- Create fuz all around if necessary
            local function make_fuz(slot)
                if slot ~= nil and #slot.hexes.list == 0 then
                    fuz = self.world:addEntity({
                        hex = {slot=slot},
                        sprite = {image=fuz_image},
                        fuz = {life=2 * math.random()},
                        flicker = {amount=50},
                        jitter = {linear=1, angular=360},
                    })
                    table.insert(slot.hexes.list, fuz)
                end
            end
            make_fuz(entity.hex.slot.neighbors.east)
            make_fuz(entity.hex.slot.neighbors.southeast)
            make_fuz(entity.hex.slot.neighbors.southwest)
            make_fuz(entity.hex.slot.neighbors.west)
            make_fuz(entity.hex.slot.neighbors.northwest)
            make_fuz(entity.hex.slot.neighbors.northeast)
        end
    end,

    draw = function(self)
        for entity in pairs(self.world:query('hex offset eye')) do
            position = {
                x = entity.hex.slot.position.x,
                y = entity.hex.slot.position.y}


            local mx, my = view.transform(love.mouse.getPosition())
            local nx, ny = position.x - mx, position.y - my
            local mag = 2 / math.sqrt(nx*nx + ny*ny)
            pupil_offset = {x = -nx * mag, y = -ny * mag}

            love.graphics.draw(entity.eye.white_image, position.x, position.y, 0, 1, 1, entity.eye.white_image:getWidth() / 2, entity.eye.white_image:getHeight() / 2)
            love.graphics.draw(entity.eye.pupil_image, position.x + pupil_offset.x, position.y + pupil_offset.y, 0, 1, 1, entity.eye.pupil_image:getWidth() / 2, entity.eye.pupil_image:getHeight() / 2)
            entity.eye.lid_anim:draw(entity.eye.lid_image, position.x, position.y, 0, 1, 1, 10, 10)
        end
    end
}