local widgets = require("themes.nature.widgets")

screen.connect_signal('request::desktop_decoration', function(s)
    awful.tag(config.vars.tags, s, awful.layout.layouts[1])
    -- promptbox: pops up when super+r is pressed
    --s.promptbox = widgets.create_promptbox()

    -- layoutbox: displays current layout (tile, fairv etc)
    s.layoutbox = widgets.create_layoutbox(s)

    -- taglist: displays 'tags' (different desktops)
    s.taglist   = widgets.create_taglist(s)

    -- tasklist: list of running tasks, by default in the center of the screen
    -- s.tasklist  = widgets.create_tasklist(s)

    -- wibox: the entire top bar
    s.wibox     = widgets.create_wibox(s)
end)
