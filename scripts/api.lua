Melodify_disks = {}
Melodify_disks_paths = {}
tracks = {}

function add_disc(disk_stringid, sound_path)
    Melodify_disks_paths[#Melodify_disks_paths + 1] = sound_path
    Melodify_disks[#Melodify_disks + 1] = disk_stringid
end

function add_music(track_name, track_path)
    if not track_name or not track_path then
        print("[E] Необходимо указать имя и путь к треку.")
        return
    end
    table.insert(tracks, { path = track_path, name = track_name })
end