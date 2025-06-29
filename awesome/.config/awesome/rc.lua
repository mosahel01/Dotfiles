pcall(require, "luarocks.loader")

-- Standard Awesome Library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and Layout Library
local wibox = require("wibox")
local beautiful = require("beautiful")
-- Notification Library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")

-- Error handling
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true
        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end

-- Variables
beautiful.init("/home/mos/.config/awesome/themes/default/theme.lua")
beautiful.font = "Ubuntu Mono 12"
terminal = "ghostty"
browser = "brave"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"
altkey = "Mod1"

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.floating,
}

-- Menu
myawesomemenu = {
    { "hotkeys",     function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual",      terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart",     awesome.restart },
    { "quit",        function() awesome.quit() end },
    { "terminal",    terminal },
}

mymainmenu = awful.menu({
    items = {
        { "awesome",       myawesomemenu, beautiful.awesome_icon },
        { "open terminal", terminal }
    }
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

menubar.utils.terminal = terminal
mykeyboardlayout = awful.widget.keyboardlayout()
mytextclock = wibox.widget.textclock()

-- Volume Widget
local volume_widget = wibox.widget {
    widget = wibox.widget.textbox,
    text = "🔊 --%",
    align = "center",
    valign = "center"
}
local function update_volume()
    awful.spawn.easy_async_with_shell(
        "wpctl get-volume @DEFAULT_AUDIO_SINK@",
        function(out)
            local vol = out:match("(%d%.%d+)")
            if vol then
                local percent = math.floor(tonumber(vol) * 100)
                volume_widget.text = "🔊" .. percent .. "%"
            else
                volume_widget.text = "🔊--%"
            end
        end
    )
end
volume_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
        update_volume()
    end),
    awful.button({}, 4, function()
        awful.spawn("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
        update_volume()
    end),
    awful.button({}, 5, function()
        awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
        update_volume()
    end)
))
gears.timer { timeout = 2, autostart = true, call_now = true, callback = update_volume }

-- Brightness Widget
local brightness_widget = wibox.widget {
    widget = wibox.widget.textbox,
    text = "🌞--% ",
    align = "center",
    valign = "center"
}
local function update_brightness()
    awful.spawn.easy_async_with_shell(
        "brightnessctl get && brightnessctl max",
        function(out)
            local current, max = out:match("(%d+)\n(%d+)")
            if current and max then
                local percent = math.floor(tonumber(current) / tonumber(max) * 100)
                brightness_widget.text = "🌞" .. percent .. "% "
            else
                brightness_widget.text = "🌞--%"
            end
        end
    )
end
brightness_widget:buttons(gears.table.join(
    awful.button({}, 1, function()
        awful.spawn.easy_async_with_shell(
            "brightnessctl get && brightnessctl max",
            function(out)
                local current, max = out:match("(%d+)\n(%d+)")
                if tonumber(current) > tonumber(max) * 0.5 then
                    awful.spawn("brightnessctl set 10%")
                else
                    awful.spawn("brightnessctl set 100%")
                end
                update_brightness()
            end
        )
    end),
    awful.button({}, 4, function()
        awful.spawn("brightnessctl set 5%+")
        update_brightness()
    end),
    awful.button({}, 5, function()
        awful.spawn("brightnessctl set 5%-")
        update_brightness()
    end)
))
gears.timer { timeout = 2, autostart = true, call_now = true, callback = update_brightness }

-- Battery Widget
local battery_widget = wibox.widget {
    widget = wibox.widget.textbox,
    text = "🔋 --%",
    align = "center",
    valign = "center"
}
local function update_battery()
    awful.spawn.easy_async_with_shell(
        "acpi -b",
        function(out)
            local status = out:match(": ([^,]+),")
            local percent = out:match("(%d?%d?%d)%%")
            if percent then
                if status and status:lower():find("discharging") then
                    battery_widget.markup = ' 🔋<span foreground="red">' .. percent .. '%</span> '
                else
                    battery_widget.markup = ' 🔋' .. percent .. '% '
                end
            else
                battery_widget.markup = " 🔋--% "
            end
        end
    )
end
gears.timer { timeout = 5, autostart = true, call_now = true, callback = update_battery }
update_battery()

-- Network Widget (Ethernet/WiFi/Disconnected)
local network_widget = wibox.widget {
    widget = wibox.widget.textbox,
    text = "Disconnected",
    align = "center",
    valign = "center"
}
local function update_network()
    awful.spawn.easy_async_with_shell(
        "nmcli -t -f TYPE,STATE dev | grep ':connected' | head -n1",
        function(line)
            if not line or line == "" then
                network_widget.markup = '<span foreground="red">Disconnected</span>'
                return
            end
            local typ = line:match("^(%w+):connected")
            if typ == "ethernet" then
                network_widget.markup = '<span foreground="#8ec07c">Ethernet</span>'
            elseif typ == "wifi" then
                network_widget.markup = '<span foreground="#83a598">WiFi</span>'
            else
                network_widget.markup = '<span foreground="red">Disconnected</span>'
            end
        end
    )
end
gears.timer { timeout = 2, autostart = true, call_now = true, callback = update_network }

-- Taglist & Tasklist Buttons
local taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)
local tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
    awful.button({}, 4, function() awful.client.focus.byidx(1) end),
    awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
)

-- Wallpaper
local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "function" then wallpaper = wallpaper(s) end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end
screen.connect_signal("property::geometry", set_wallpaper)

-- Wibar per screen
awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)
    awful.spawn.once("picom")
    awful.spawn.once("copyq")
    awful.spawn.once("flameshot")
    awful.spawn.once("setxkbmap -option caps:swapescape")
    awful.spawn.once("brightnessctl set 70%")
    awful.spawn.once("betterlockscreen -u ~/.config/awesome/themes/default/custom_wallpapers/001.png")
    awful.spawn.with_shell("xset r rate 200 50")
    awful.spawn.with_shell("xrandr --output eDP-1 --mode 1920x1080")

    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    s.mypromptbox = awful.widget.prompt()
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
    ))
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }
    s.mywibox = awful.wibar({ position = "top", screen = s })
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        {
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist,
        {
            layout = wibox.layout.fixed.horizontal,
            brightness_widget,
            volume_widget,
            battery_widget,
            network_widget,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)

-- Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({ modkey }, 4, awful.tag.viewnext),
    awful.button({ modkey }, 5, awful.tag.viewprev)
))

-- Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
    awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end,
        { description = "focus next by index", group = "client" }),
    awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end,
        { description = "focus previous by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),
    awful.key({ modkey }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then client.focus:raise() end
    end, { description = "go back", group = "client" }),
    awful.key({ modkey }, "b", function() awful.spawn(browser) end, { description = "open browser", group = "launcher" }),
    awful.key({ modkey }, "d", function() awful.spawn("discord") end,
        { description = "open discord", group = "launcher" }),
    awful.key({ modkey }, "e", function() awful.spawn("nautilus") end, { description = "open files", group = "launcher" }),
    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),
    awful.key({ modkey }, ".", function() awful.spawn.with_shell("rofi -modi emoji -show emoji") end,
        { description = "emoji picker", group = "launcher" }),
    awful.key({ modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width factor", group = "layout" }),
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width factor", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(1) end,
        { description = "select next", group = "layout" }),
    awful.key({ modkey, "Mod1" }, "s", function() awful.client.swap.byidx(1) end,
        { description = "swap with next window", group = "client" }),
    awful.key({}, "Print", function() awful.spawn("flameshot full -p /home/mos/Pictures/Random/") end,
        { description = "Fullscreen screenshot", group = "screenshots" }),
    awful.key({ modkey, "Shift" }, "s", function() awful.spawn("flameshot gui") end,
        { description = "take screenshot", group = "launcher" }),
    awful.key({ modkey, altkey }, "l", function() awful.spawn("betterlockscreen -s") end,
        { description = "lock n sleep", group = "system" }),
    awful.key({ modkey, "Shift" }, "l", function() awful.spawn("betterlockscreen -l") end,
        { description = "lock screen", group = "system" }),
    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),
    awful.key({ modkey }, "space",
        function() awful.util.spawn("rofi -modi drun -show drun -show-icons -width 22 -no-click-to-exit", false) end)
)

-- Tag keys (1-9)
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end, { description = "view tag #" .. i, group = "tag" }),
        awful.key({ modkey, "Control" }, "#" .. i + 9, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, { description = "toggle tag #" .. i, group = "tag" }),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end, { description = "move focused client to tag #" .. i, group = "tag" }),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:toggle_tag(tag) end
            end
        end, { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end

-- Homerow tag keys (u i o p y)
local tag_keys = { "u", "i", "o", "p", "y" }
for i, key in ipairs(tag_keys) do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, key, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end, { description = "view tag #" .. i .. " (homerow)", group = "tag" }),
        awful.key({ modkey, "Control" }, key, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, { description = "toggle tag #" .. i .. " (homerow)", group = "tag" }),
        awful.key({ modkey, "Shift" }, key, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end, { description = "move focused client to tag #" .. i .. " (homerow)", group = "tag" }),
        awful.key({ modkey, "Control", "Shift" }, key, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:toggle_tag(tag) end
            end
        end, { description = "toggle focused client on tag #" .. i .. " (homerow)", group = "tag" })
    )
end

clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen; c:raise()
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "q", function(c) c:kill() end, { description = "close", group = "client" }),
    awful.key({ modkey, altkey }, "m", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized; c:raise()
    end, { description = "(un)maximize", group = "client" })
)

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

-- Media keys
globalkeys = gears.table.join(globalkeys,
    awful.key({}, "XF86AudioRaiseVolume", function() awful.spawn("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") end,
        { description = "volume up", group = "media" }),
    awful.key({}, "XF86AudioLowerVolume", function() awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") end,
        { description = "volume down", group = "media" }),
    awful.key({}, "XF86AudioMute", function() awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") end,
        { description = "toggle mute", group = "media" }),
    awful.key({}, "XF86MonBrightnessUp", function() awful.spawn("brightnessctl -e4 -n2 set 5%+") end,
        { description = "brightness up", group = "media" }),
    awful.key({}, "XF86MonBrightnessDown", function() awful.spawn("brightnessctl -e4 -n2 set 5%-") end,
        { description = "brightness down", group = "media" })
)
root.keys(globalkeys)

-- Rules
awful.rules.rules = {
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },
    {
        rule_any = {
            instance = { "DTA", "copyq", "pinentry" },
            class = { "Arandr", "Blueman-manager", "Gpick", "Kruler", "MessageWin", "Sxiv", "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer" },
            name = { "Event Tester" },
            role = { "AlarmWindow", "ConfigManager", "pop-up" }
        },
        properties = { floating = true }
    },
    {
        rule_any = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = false }
    },
}

-- Signals
client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )
    awful.titlebar(c):setup {
        { awful.titlebar.widget.iconwidget(c),                                 buttons = buttons,                        layout = wibox.layout.fixed.horizontal },
        { { align = "center", widget = awful.titlebar.widget.titlewidget(c) }, buttons = buttons,                        layout = wibox.layout.flex.horizontal },
        { awful.titlebar.widget.floatingbutton(c),                             awful.titlebar.widget.maximizedbutton(c), awful.titlebar.widget.closebutton(c),  layout = wibox.layout.fixed.horizontal() },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)
client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- Gaps
beautiful.useless_gap = 2
