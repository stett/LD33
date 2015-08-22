view = require('view')

return {
    update = function(self, dt)

        if love.mouse.isDown('l') then
            for entity in pairs(self.world:query('jumpy hex acceleration')) do
                local mx, my = view.transform(love.mouse.getPosition())
                local nx = mx - entity.hex.slot.position.x
                local ny = my - entity.hex.slot.position.y
                local nmag = 600 / math.sqrt(nx*nx + ny*ny)
                local accx = nx * nmag
                local accy = ny * nmag
                --entity.acceleration.x = entity.acceleration.x + accx
                --entity.acceleration.y = entity.acceleration.y + accy
                entity.acceleration.x = accx
                entity.acceleration.y = accy
            end
        end
    end
}
