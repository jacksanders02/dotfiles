-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, 'luarocks.loader')

-- load global libraries
beautiful = require('beautiful')
gears = require('gears')
awful = require('awful')
wibox = require('wibox')
helpers = require('helpers')
dpi = beautiful.xresources.apply_dpi

config = require("config")

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

-- load key and mouse bindings
require'bindings'

-- load rules
require'rules'

-- load signals
require'signals'

local theme_path = string.format("%s/.config/awesome/themes/%s/theme.lua", os.getenv("HOME"), theme)
beautiful.init(theme_path)

-- load decorations
decorations = require("decorations")
decorations.init(decoration_theme)



-- autostart
awful.spawn.with_shell('~/.config/awesome/autostart.sh')


