local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local decorations = require("decorations")
local dpi = require("beautiful.xresources").apply_dpi

client.connect_signal('request::titlebars', function(c)
    awful.titlebar(c).widget = {
        -- left
        {
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal,
        },
        -- middle
        {
            -- title
            {
                align = 'center',
                widget = awful.titlebar.widget.titlewidget(c),
            },
            buttons = decorations.buttons,
            layout  = wibox.layout.flex.horizontal,
        },
        -- right
        {
            awful.titlebar.widget.floatingbutton(c),
            awful.titlebar.widget.ontopbutton(c),
            awful.titlebar.widget.minimizebutton(c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton(c),

            -- Create some extra padding at the edge
            helpers.horizontal_pad(dpi(3)),

            layout = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal,
    }
end)
