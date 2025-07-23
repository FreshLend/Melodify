local speaker_ids = {}

load_script("melodify:scripts/api.lua")

function on_interact(x, y, z, playerid)
    local player_invid, player_slot = player.get_inventory(playerid)
    local player_itemid, player_count = inventory.get(player_invid, player_slot)
    local str_itemid = item.name(player_itemid)
    local block_invid = inventory.get_block(x, y, z)

    if block_invid == 0 then
        print("[E] Melodify: музыкальный блок в координатах "..x..", "..y..", "..z.." не имеет инвентаря.")
        return false
    end

    local block_itemid, block_count = inventory.get(block_invid, 0)
    local has_disc_in_block = block_itemid ~= 0

    if not has_disc_in_block then
        for i, disc_id in ipairs(Melodify_disks) do
            if str_itemid == disc_id then
                inventory.set(block_invid, 0, player_itemid, player_count)
                inventory.set(player_invid, player_slot, 0, 0)

                speaker_ids[x] = speaker_ids[x] or {}
                speaker_ids[x][y] = speaker_ids[x][y] or {}
                speaker_ids[x][y][z] = speaker_ids[x][y][z] or 0

                speaker_ids[x][y][z] = audio.play_sound(Melodify_disks_paths[i], x + 0.5, y, z + 0.5, 2.0, 1.0, "regular", false)
                return true
            end
        end
        return false
    end

    if player_itemid == 0 then
        inventory.set(player_invid, player_slot, block_itemid, block_count)
        inventory.set(block_invid, 0, 0, 0)

        stop_sound_at(x, y, z)
    else
        if inventory.add(player_invid, block_itemid, block_count) == 0 then
            inventory.set(block_invid, 0, 0, 0)
            stop_sound_at(x, y, z)
        end
    end
    return true
end

function stop_sound_at(x, y, z)
    if speaker_ids[x] and speaker_ids[x][y] and speaker_ids[x][y][z] then
        audio.stop(speaker_ids[x][y][z])
    end
end

function on_broken(x, y, z, playerid)
    stop_sound_at(x, y, z)
    return true
end


function on_placed(x, y, z, playerid)
    local block_invid = inventory.get_block(x, y, z)
    inventory.set(block_invid, 0, 0, 0)
end