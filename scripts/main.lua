Melodify_disks = {}
Melodify_disks_paths = {}
tracks = {}
ambient = {}

function add_disc(disk_stringid, sound_path)
    Melodify_disks_paths[#Melodify_disks_paths + 1] = sound_path
    Melodify_disks[#Melodify_disks + 1] = disk_stringid
end

function add_music(track_name, track_path)
    if not track_name or not track_path then
        print("[Ошибка] Необходимо указать имя и путь к треку.")
        return
    end
    table.insert(tracks, { path = track_path, name = track_name })
end

function remove_music(track_name)
    if track_name == "clear_all" then
        tracks = {}
        print("Вся музыка была удалена.")
        return
    end

    for i, track in ipairs(tracks) do
        if track.name == track_name then
            table.remove(tracks, i)
            print("Трек '" .. track_name .. "' удален.")
            return
        end
    end
    print("Трек с именем '" .. track_name .. "' не найден.")
end