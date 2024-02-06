local b_info = {}

b_info.charging = ""
b_info.level = 100

local get_image = function()
    return string.format("%s_charging_%s.svg", math.floor(b_info.level / 10 + 0.5) * 10, b_info.charging)
end

b_info.widget = wibox.widget {
    image = beautiful.battery_icon_path .. get_image(),
    resize = true,
    widget = wibox.widget.imagebox
}

awesome.connect_signal("custom::battery", function(value)
    b_info.level = value
    b_info.widget:set_image(beautiful.battery_icon_path .. get_image())
end)

awesome.connect_signal("custom::charging", function(value)
    b_info.charging = value
    b_info.widget:set_image(beautiful.battery_icon_path .. get_image())
end)

return b_info
