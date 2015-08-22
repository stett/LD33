return {
    update = function(self, dt)
        for entity in pairs(self.world:query('hex fuz')) do

            entity.fuz.life = entity.fuz.life - dt

            if entity.fuz.life < 0 then
                local i
                for i, hex in ipairs(entity.hex.slot.hexes.list) do
                    if hex == entity then break end
                end
                table.remove(entity.hex.slot.hexes.list, i)
                self.world:delete(entity)
            end
        end
    end
}