load_script("melodify:scripts/api.lua")

local stream_id = 0
local volume = 1

local function play_random_track()
    if #tracks == 0 then
        return
    end
    local track = tracks[math.random(1, #tracks)]
    stream_id = audio.play_stream_2d(track.path, volume, 1, "music", true)
    print("==========================")
    print("=        Melodify        =")
    print("= By FreshGame           =")
    print(string.format("= Sounds %d ", #tracks))
    print("==========================")
    print(string.format("= Now playing: %s  ", track.name))
    print("==========================")
end

function on_world_open()
    play_random_track()
end

function on_world_save()
    audio.stop(stream_id)
end

function on_world_tick()
    local track_duration = audio.get_duration(stream_id)
    local current_time = audio.get_time(stream_id)

    if current_time >= track_duration - 0.1 then
        audio.stop(stream_id)
        play_random_track()
    end
end