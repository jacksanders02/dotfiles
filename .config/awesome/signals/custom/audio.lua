-- Nabbed from https://github.com/elenapan/dotfiles/blob/master/config/awesome/evil/volume.lua
local volume_script = [[
    sh -c "
        pactl subscribe 2> /dev/null | grep --line-buffered \"Event 'change' on sink #\"
    "
]]

local volume_old = -1
local muted_old = -1

local function emit_volume_info()
    awful.spawn.easy_async_with_shell("pamixer --get-volume", function(stdout)
        local volume_int = tonumber(stdout)

        -- Only send signal if there was a change
        -- We need this since we use `pactl subscribe` to detect
        -- volume events. These are not only triggered when the
        -- user adjusts the volume through a keybind, but also
        -- through `pavucontrol` or even without user intervention,
        -- when a media file starts playing.
        if volume_int ~= volume_old then
            awesome.emit_signal("custom::volume", volume_int)
            volume_old = volume_int
        end
    end)

    awful.spawn.easy_async_with_shell("pamixer --get-mute", function(stdout)
        -- use sub to get only the first character from stdout
        -- eliminates need for awk to filter out linebreak characters
        local mute_int = stdout.sub(stdout, 1, 1) == "t" and 0 or 1

        -- Only send signal if there was a change
        -- We need this since we use `pactl subscribe` to detect
        -- volume events. These are not only triggered when the
        -- user adjusts the volume through a keybind, but also
        -- through `pavucontrol` or even without user intervention,
        -- when a media file starts playing.
        if mute_int ~= muted_old then
            awesome.emit_signal("custom::mute", mute_int)
            mute_old = mute_int
        end
    end)
end

-- Kill old pactl subscribe processes
awful.spawn.easy_async({"pkill", "--full", "--uid", os.getenv("USER"), "^pactl subscribe"}, function ()
    -- Run emit_volume_info() with each line printed
    awful.spawn.with_line_callback(volume_script, {
        stdout = function(line)
            emit_volume_info()
        end
    })
end)
