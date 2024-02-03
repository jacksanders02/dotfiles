local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local decorations = require("decorations")
local dpi = require("beautiful.xresources").apply_dpi

-- This decoration theme will round clients according to your theme's
-- border_radius value
--decorations.enable_rounding()
--

function buttons_widget(c)
    return wibox.widget {
        -- Create buttons with padding between
        awful.titlebar.widget.floatingbutton(c),
        awful.titlebar.widget.ontopbutton(c),
        awful.titlebar.widget.minimizebutton(c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.closebutton(c),

        layout = wibox.layout.flex.horizontal,
        spacing = dpi(6),
        forced_height = beautiful.titlebar_size * 0.75,
    }
end

-- Add a titlebar
client.connect_signal("request::titlebars", function(c)
    awful.titlebar(c, {font = beautiful.titlebar_font, position = beautiful.titlebar_position, size = beautiful.titlebar_size}) : setup {
        nil,
        {
            buttons = decorations.titlebar_buttons,
            font = beautiful.titlebar_font,
            align = beautiful.titlebar_title_align or "center",
            widget = beautiful.titlebar_title_enabled and awful.titlebar.widget.titlewidget(c) or wibox.widget.textbox("")
        },
        {
            buttons_widget(c),
            layout = wibox.container.place,
            halign = "right",
            forced_height = beautiful.titlebar_size
        },
        layout = wibox.layout.align.horizontal,
        forced_height = beautiful.titlebar_size
    }
end)
