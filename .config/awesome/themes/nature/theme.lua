-------------------------------
--  "Natuur" awesome theme   --
--         By Jack S.        --
-------------------------------

local themes_path = os.getenv("HOME") .. "/.config/awesome/themes/"
local theme_name = "nature"
local rnotification = require("ruled.notification")
local dpi = require("beautiful.xresources").apply_dpi
local awful = require("awful")
local gears = require("gears")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local layout_icon_path = themes_path .. theme_name .. "/layouts/"
local titlebar_icon_path = themes_path .. theme_name .. "/titlebar/"
local widget_icon_path = themes_path .. theme_name .. "/widget_icons/"
local tip = titlebar_icon_path --alias to save time/space
local xrdb = xresources.get_current_theme()

-- {{{ Main
local theme = {}
theme.wallpaper = themes_path .. theme_name .. "/zenburn-background.svg"
-- }}}
theme.battery_icon_path = widget_icon_path .. "battery/"

-- {{{ Colours
local focused_colour = "#f2e8cf"
local unfocused_colour = "#344e41"
local urgent_colour = "#bc4749"
-- }}}

-- {{{ Styles
theme.font      = "Noto Sans Mono 9"

-- {{{ Colors
theme.fg_normal  = focused_colour
theme.fg_focus   = unfocused_colour
theme.fg_urgent  = focused_colour
theme.bg_normal  = unfocused_colour
theme.bg_focus   = focused_colour
theme.bg_urgent  = urgent_colour
theme.bg_systray = theme.bg_normal
-- }}}

-- {{{ Borders
theme.useless_gap   = dpi(3)
theme.border_width  = dpi(3)
theme.border_color_normal = unfocused_colour
theme.border_color_active = focused_colour
theme.border_color_marked = "#CC9393"
theme.client_corner_radius = 8
-- }}}

-- {{{ Titlebar
theme.titlebar_size          = dpi(15)
theme.titlebar_position      = "top"
theme.titlebar_bg_focus      = focused_colour
theme.titlebar_bg_normal     = unfocused_colour
theme.titlebar_font          = theme.font
theme.titlebar_title_align   = "left"
theme.titlebar_title_enabled = false
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)
-- }}}

-- {{{ Layout
theme.layout_tile       = layout_icon_path .. "tile.svg"
theme.layout_fairv      = layout_icon_path .. "fairv.svg"
-- }}}


-- {{{ Titlebar Button Icons
local tb_buttons = {
    "minimize",
    "close"
}

local needs_active = {
    "floating",
    "ontop",
    "maximized"
}

for b = 1, #tb_buttons do
    local button = tb_buttons[b]
    local tb_str = string.format("titlebar_%s_button", button)
    theme[tb_str .. "_focus"]         = titlebar_icon_path .. button .. "_focus.svg"
    theme[tb_str .. "_focus_hover"]   = titlebar_icon_path .. button .. "_focus_hover.svg"
    theme[tb_str .. "_normal"]        = titlebar_icon_path .. button .. "_normal.svg"
    theme[tb_str .. "_normal_hover"]  = titlebar_icon_path .. button .. "_normal_hover.svg"
end

for b = 1, #needs_active do
    local button = needs_active[b]
    local tb_str = string.format("titlebar_%s_button", button)
    theme[tb_str .. "_focus_active"]          = titlebar_icon_path .. button .. "_focus_active.svg"
    theme[tb_str .. "_focus_active_hover"]    = titlebar_icon_path .. button .. "_focus_active_hover.svg"
    theme[tb_str .. "_focus_inactive"]        = titlebar_icon_path .. button .. "_focus_inactive.svg"
    theme[tb_str .. "_focus_inactive_hover"]  = titlebar_icon_path .. button .. "_focus_inactive_hover.svg"
    theme[tb_str .. "_normal_active"]         = titlebar_icon_path .. button .. "_normal_active.svg"
    theme[tb_str .. "_normal_active_hover"]   = titlebar_icon_path .. button .. "_normal_active_hover.svg"
    theme[tb_str .. "_normal_inactive"]       = titlebar_icon_path .. button .. "_normal_inactive.svg"
    theme[tb_str .. "_normal_inactive_hover"] = titlebar_icon_path .. button .. "_normal_inactive_hover.svg"
end
-- }}}

-- Set different colors for urgent notifications.
rnotification.connect_signal('request::rules', function()
    rnotification.append_rule {
        rule       = { urgency = 'critical' },
        properties = { bg = '#ff0000', fg = '#ffffff' }
    }
end)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
