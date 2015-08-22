view = require('view')

return {
    update = function(self, dt)

        if love.mouse.isDown('l') then
            for entity in pairs(self.world:query('jumpy hex acceleration')) do
                local mx, my = view.transform(love.mouse.getPosition())
                local nx = mx - entity.hex.slot.position.x
                local ny = my - entity.hex.slot.position.y
                local nmag = 1000 / math.sqrt(nx*nx + ny*ny)
                local accx = nx * nmag
                local accy = ny * nmag
                --entity.acceleration.x = entity.acceleration.x + accx
                --entity.acceleration.y = entity.acceleration.y + accy
                entity.acceleration.x = accx
                entity.acceleration.y = accy
            end
        end


        if love.mouse.isDown('r') then
            for attracted in pairs(self.world:query('hex acceleration attracted')) do
                for attractor in pairs(self.world:query('hex attractor')) do

                    local diff = {
                        x = attractor.hex.slot.position.x - attracted.hex.slot.position.x,
                        y = attractor.hex.slot.position.y - attracted.hex.slot.position.y}
                    local mag = math.sqrt(diff.x*diff.x + diff.y*diff.y)
                    --local mag_div = 1 / mag
                    local acc = {
                        x = mag * diff.x / 20,
                        y = mag * diff.y / 20}
                    attracted.acceleration.x = attracted.acceleration.x + acc.x
                    attracted.acceleration.y = attracted.acceleration.y + acc.y
                end
            end
        end
    end
}
