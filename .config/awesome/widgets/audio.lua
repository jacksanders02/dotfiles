local audio_info = {
    mute = 1,
    volume = 68,
}

local get_image = function()
    return string.format("volume_%s.svg", math.ceil(audio_info.volume / 33.4) * audio_info.mute)
end

audio_info.widget = wibox.widget {
    image = beautiful.volume_icon_path .. get_image(),
    resize = true,
    widget = wibox.widget.imagebox
}

awesome.connect_signal("custom::volume", function(value)
    print(value)
    audio_info.volume = value
    audio_info.widget:set_image(beautiful.volume_icon_path .. get_image())
end)

awesome.connect_signal("custom::mute", function(value)
    print(value)
    audio_info.mute = value
    audio_info.widget:set_image(beautiful.volume_icon_path .. get_image())
end)

return audio_info
