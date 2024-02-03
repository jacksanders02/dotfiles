-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load theme
local beautiful = require'beautiful'
local gears = require'gears'
local awful = require'awful'

local themes = {
    "default",
    "gtk",
    "sky",
    "xresources",
    "zenburn",
    "nature",
}
local theme = themes[6] 

local decoration_themes = {
    "nature",
}
local decoration_theme = decoration_themes[1]

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), theme)
beautiful.init(theme_path)

-- load decorations
local decorations = require("decorations")
decorations.init(decoration_theme)

-- load key and mouse bindings
require'bindings'

-- load rules
require'rules'

-- load signals
require'signals'

-- autostart
awful.spawn.with_shell('~/.config/awesome/autostart.sh')


