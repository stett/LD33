local settings = require('settings')
local grid = require('grid')

return {
    update = function(self, dt)

        -- Update the velocities of entities with accelerations
        for entity in pairs(self.world:query('velocity acceleration')) do
            entity.velocity.x = entity.velocity.x + entity.acceleration.x * dt
            entity.velocity.y = entity.velocity.y + entity.acceleration.y * dt
        end

        -- Update the offsets of entities with velocities
        for entity in pairs(self.world:query('offset velocity')) do
            entity.offset.x = entity.offset.x + entity.velocity.x * dt
            entity.offset.y = entity.offset.y + entity.velocity.y * dt
        end

        -- Update the slot of hexes which have offsets
        for entity in pairs(self.world:query('hex offset')) do

            -- If the magnitude of the offset is bigger than half the size of a hex,
            -- then we need to shift to the next hex
            local magnitude_squared = entity.offset.x * entity.offset.x + entity.offset.y * entity.offset.y
            if magnitude_squared > .25 * settings.HEX_SIZE * settings.HEX_SIZE then

                -- Get the neighbor in the space we're moving into
                local slot = entity.hex.slot
                local angle = math.atan2(entity.offset.y, entity.offset.x)
                local neighbor = grid.get_neighbor(slot, angle)

                if neighbor ~= nil then

                    -- Remove from current slot
                    --[[
                    local i
                    for i, hex in ipairs(entity.hex.slot.hexes.list) do
                        if hex == entity then break end
                    end
                    table.remove(entity.hex.slot.hexes.list, i)
                    ]]

                    -- Move into this neighbor
                    entity.hex.slot = neighbor
                    table.insert(neighbor.hexes.list, entity)

                    -- Correct the offset
                    --entity.offset.x = entity.offset.x > 0 and entity.offset.x + 2 or entity.offset.x - 2
                    --entity.offset.y = entity.offset.y > 0 and entity.offset.y + 2 or entity.offset.y - 2
                    entity.offset.x = (entity.offset.x - neighbor.position.x + slot.position.x) * .1
                    entity.offset.y = (entity.offset.y - neighbor.position.y + slot.position.y) * .1
                end
            end
        end
    end
}