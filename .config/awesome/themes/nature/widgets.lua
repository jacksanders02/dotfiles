local _M = {}

local mod = require('bindings.mod')

_M.awesomemenu = {
    {'hotkeys', function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
    {'edit config', config.apps.editor_cmd .. ' ' .. awesome.conffile},
    {'restart', awesome.restart},
    {'quit', function() awesome.quit() end},
}

_M.mainmenu = awful.menu{
    items = {
        {'awesome', _M.awesomemenu, beautiful.awesome_icon},
        {'open terminal', config.apps.terminal}
    }
}

_M.launcher = awful.widget.launcher{
    image = beautiful.awesome_icon,
    menu = _M.mainmenu
}

_M.keyboardlayout = awful.widget.keyboardlayout()
_M.textclock      = wibox.widget.textclock()

-- Load battery widget
local bbox = require("widgets.battery")
_M.batterybox = wibox.widget {
    bbox.widget,
    widget = wibox.container.margin,
    left = dpi(6),
    right = dpi(6),
    top = dpi(6),
    bottom = dpi(6),
}

-- Set up tooltip to display battery level on hover
_M.batterytooltip = awful.tooltip {
    objects = { _M.batterybox },
    timer_function = function()
        local charge_string = "Full"
        if not (bbox.level == 100) then
            charge_string = "Charging"
        end
        if not (bbox.charging) then
            charge_string = "Discharging"
        end
        return string.format("%s%%, %s", bbox.level, charge_string)
    end,
}

function _M.create_promptbox() return awful.widget.prompt() end

-- Layout Changer
function _M.create_layoutbox(s)
    return wibox.widget {
        awful.widget.layoutbox {
            screen = s,
            buttons = {
                awful.button{
                    modifiers = {},
                    button    = 1,
                    on_press  = function() awful.layout.inc(1) end,
                },
                awful.button{
                    modifiers = {},
                    button    = 3,
                    on_press  = function() awful.layout.inc(-1) end,
                },
                awful.button{
                    modifiers = {},
                    button    = 4,
                    on_press  = function() awful.layout.inc(-1) end,
                },
                awful.button{
                    modifiers = {},
                    button    = 5,
                    on_press  = function() awful.layout.inc(1) end,
                },
            }
        },
        widget = wibox.container.margin,
        left = dpi(6),
        right = dpi(12),
        top = dpi(6),
        bottom = dpi(6),
    }
end

-- Tag List (1-9 desktops)
function _M.create_taglist(s)
    return awful.widget.taglist{
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = {
            awful.button{
                modifiers = {},
                button    = 1,
                on_press  = function(t) t:view_only() end,
            },
            awful.button{
                modifiers = {mod.super},
                button    = 1,
                on_press  = function(t)
                    if client.focus then
                        client.focus:move_to_tag(t)
                    end
                end,
            },
            awful.button{
                modifiers = {},
                button    = 3,
                on_press  = awful.tag.viewtoggle,
            },
            awful.button{
                modifiers = {mod.super},
                button    = 3,
                on_press  = function(t)
                    if client.focus then
                        client.focus:toggle_tag(t)
                    end
                end
            },
            awful.button{
                modifiers = {},
                button    = 4,
                on_press  = function(t) awful.tag.viewprev(t.screen) end,
            },
            awful.button{
                modifiers = {},
                button    = 5,
                on_press  = function(t) awful.tag.viewnext(t.screen) end,
            },
        }
    }
end

function _M.create_tasklist(s)
    return awful.widget.tasklist{
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button{
                modifiers = {},
                button    = 1,
                on_press  = function(c)
                    c:activate{context = 'tasklist', action = 'toggle_minimization'}
                end,
            },
            awful.button{
                modifiers = {},
                button    = 3,
                on_press  = function() awful.menu.client_list{theme = {width = 250}} end
            },
            awful.button{
                modifiers = {},
                button    = 4,
                on_press  = function() awful.client.focus.byidx(-1) end
            },
            awful.button{
                modifiers = {},
                button    = 5,
                on_press  = function() awful.client.focus.byidx(1) end
            },
        }
    }
end

-- Top bar
function _M.create_wibox(s)
    return awful.wibar{
        screen = s,
        position = 'top',
        height = beautiful.titlebar_size * 1.5,
        bg = beautiful.bg_normal,
        widget = {
            layout = wibox.layout.align.horizontal,
            -- left widgets
            {
                layout = wibox.layout.fixed.horizontal,
                _M.launcher,
                s.taglist,
                s.promptbox,
            },
            -- middle widgets
            s.tasklist,
            -- right widgets
            {
                layout = wibox.layout.fixed.horizontal,
                _M.keyboardlayout,
                wibox.widget.systray(),
                _M.textclock,
                _M.batterybox,
                s.layoutbox,
            }
        }
    }
end

return _M
