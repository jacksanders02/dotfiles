local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")

awful.titlebar.enable_tooltip = false

local decorations = {}

decorations.titlebar_buttons = require("decorations.keys")

-- Load theme and custom decorations
function decorations.init(theme_name)
    require("decorations.themes." .. theme_name .. ".desktop")
    require("decorations.themes." .. theme_name .. ".titlebars")
end

return decorations
