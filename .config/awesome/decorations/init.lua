local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

awful.titlebar.enable_tooltip = false

-- Round corners depending on the theme's corner radius
client.connect_signal("manage", function (c)
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, beautiful.client_corner_radius or 0)
    end
end)

local decorations = {}

decorations.titlebar_buttons = require("decorations.keys")



-- Load theme and custom decorations
function decorations.init(theme_name)
    require("decorations.themes." .. theme_name .. ".desktop")
    require("decorations.themes." .. theme_name .. ".titlebars")
end

return decorations
