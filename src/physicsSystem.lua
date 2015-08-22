local settings = require('settings')
local grid = require('grid')

return {
    update = function(self, dt)

        -- Cause floating things to hover
        for entity in pairs(self.world:query('hex velocity hover')) do
            below = grid.get_hex(
                entity.hex.slot.position.x,
                entity.hex.slot.position.y + 20 * entity.hover.height)

            below_is_empty = true
            if below == nil then
                below_is_empty = false
            else
                for _, hex in ipairs(below.hexes.list) do
                    if hex.fuz ~= nil then
                        below_is_empty = false
                        break
                    end
                end
            end

            if not below_is_empty then
                --entity.acceleration.y = entity.acceleration.y - 800
            end
        end

        -- Resolve collisions
        for entity in pairs(self.world:query('acceleration velocity collision')) do

            -- Get the other entity
            local other = entity.collision.entity

            -- Get the velocities
            local v1 = entity.velocity
            local v2 = other.velocity or {x=0, y=0}

            -- Calculate instantaneous acceleration for this guy
            entity.acceleration.x = entity.acceleration.x + (v2.x - v1.x) / dt
            entity.acceleration.y = entity.acceleration.y + (v2.y - v1.y) / dt

            --io.write('v1.x=', v1.x, ', ', 'v2.x=', v2.x, ', ', '(v2.x-v1.x)/dt=', (v2.x-v1.x)/dt, '\n')

            -- Mark it resolved by removing the collision component
            self.world:detach(entity, 'collision')
        end

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

                -- Make sure we have a neighbor to move into
                if neighbor ~= nil then

                    -- Remove fuz from other slot
                    for i, hex in ipairs(neighbor.hexes.list) do
                        if hex.fuz ~= nil then
                            table.remove(neighbor.hexes.list, i)
                            self.world:delete(hex)
                            break
                        end
                    end

                    -- If the neighbor is empty, make the shift
                    if #neighbor.hexes.list == 0 then

                        -- Remove from current slot
                        local i
                        for i, hex in ipairs(slot.hexes.list) do
                            if hex == entity then break end
                        end
                        table.remove(slot.hexes.list, i)

                        -- Move into this neighbor
                        entity.hex.slot = neighbor
                        table.insert(neighbor.hexes.list, entity)

                        -- Correct the offset
                        entity.offset.x = (entity.offset.x - neighbor.position.x + slot.position.x) * .85
                        entity.offset.y = (entity.offset.y - neighbor.position.y + slot.position.y) * .85

                    -- If there are already hexes in the neighbor, reset the offset and
                    -- mark this one for collision resolution
                    else
                        -- Reset the offset
                        entity.offset.x = 0
                        entity.offset.y = 0

                        -- We co-mark the collision with just the FIRST hex in the neighboring slot
                        local other = neighbor.hexes.list[1]
                        self.world:attach(entity, {collision={entity=other}})
                        self.world:attach(other, {collision={entity=entity}})
                    end
                else
                    entity.offset.x = 0
                    entity.offset.y = 0
                end
            end
        end
    end
}