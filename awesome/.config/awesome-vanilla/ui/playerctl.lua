local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local gears = require("gears")
local helpers = require("helpers")

local M           = {}
M.font            = "Inconsolata 18"
M.font_icon_large = "Inconsolata 36"

function M.new()
    M.art = wibox.widget({
        image         = beautiful.icon_music or os.getenv("HOME") .. "/.config/awesome/icons/music.svg",
        resize        = true,
        halign        = "center",
        valign        = "center",
        forced_height = 128,
        forced_width  = 128,
        clip_shape    = helpers.rrect(),
        widget        = wibox.widget.imagebox
    })

    M.title_text = wibox.widget({
        markup = "Playing",
        font = M.font,
        halign = "left",
        valign = "center",
        widget = wibox.widget.textbox
    })

    M.title = wibox.widget({
        layout        = wibox.container.scroll.horizontal,
        step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        fps           = 60,
        speed         = 75,
        M.title_text
    })

    M.title:pause()

    M.artist_text = wibox.widget({
      markup = "Nothing",
        font = M.font,
      halign = "left",
      valign = "center",
      widget = wibox.widget.textbox
    })

    M.artist = wibox.widget({
        layout        = wibox.container.scroll.horizontal,
        step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        fps           = 60,
        speed         = 75,
        M.artist_text
    })

    M.artist:pause()

    M.album_text = wibox.widget({
      markup = "No album",
        font = M.font,
      halign = "left",
      valign = "center",
      widget = wibox.widget.textbox
    })

    M.album = wibox.widget({
        layout        = wibox.container.scroll.horizontal,
        step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
        fps           = 60,
        speed         = 75,
        M.album_text
    })

    M.album:pause()

    M.toggle_icon = wibox.widget({
        markup        = "<span foreground=\"#dcdccc\"></span>",
        widget        = wibox.widget.textbox,
        forced_height = 32,
        forced_width  = 32,
        font          = M.font_icon_large,
        halign        = "center",
        valign        = "center"
    })

    M.prev_icon = wibox.widget({
        markup        = "<span foreground=\"#dcdccc\"></span>",
        widget        = wibox.widget.textbox,
        font          = M.font_icon_large,
        forced_height = 32,
        forced_width  = 32,
        halign        = "center",
        valign        = "center"
    })

    M.next_icon = wibox.widget({
        markup        = "<span foreground=\"#dcdccc\"></span>",
        widget        = wibox.widget.textbox,
        font          = M.font_icon_large,
        forced_height = 32,
        forced_width  = 32,
        halign        = "center",
        valign        = "center"
    })

    --M.toggle = helpers.add_margin(M.toggle_icon)
    --M.prev   = helpers.add_margin(M.prev_icon)
    --M.next   = helpers.add_margin(M.next_icon)
    M.toggle = M.toggle_icon
    M.prev   = M.prev_icon
    M.next   = M.next_icon

    M.prev.fg   = "#dcdccc"
    M.next.fg   = "#dcdccc"
    M.toggle.fg = "#dcdccc"

    M.toggle_icon:buttons(gears.table.join(awful.button({}, 1, function()
        awesome.emit_signal("playerctl::toggle")
    end)))

    M.next_icon:buttons(gears.table.join(awful.button({}, 1, function()
        awesome.emit_signal("playerctl::next")
    end)))

    M.prev_icon:buttons(gears.table.join(awful.button({}, 1, function()
        awesome.emit_signal("playerctl::prev")
    end)))

    M.button_group = helpers.add_margin(wibox.widget({
        M.prev,
        M.toggle,
        M.next,
        layout = wibox.layout.align.vertical
    }),10,10)

    M.text_group = helpers.add_margin(wibox.widget({
        M.artist,
        M.title,
        M.album,
        layout = wibox.layout.align.vertical,
        forced_width = 400,
    }),10,10)

    M.widget = helpers.add_margin(helpers.add_bg1(helpers.add_margin(wibox.widget({
        helpers.add_margin(M.art,16,8),
        M.text_group,
        M.button_group,
        layout = wibox.layout.align.horizontal,
    }))), 16, 0)

    M.widget:connect_signal("mouse::enter", function()
        M.title:continue()
        M.artist:continue()
        M.album:continue()
    end)

    M.widget:connect_signal("mouse::leave", function()
        M.title:pause()
        M.artist:pause()
        M.album:pause()
    end)

    awesome.connect_signal("playerctl::metadata::update", function(title, artist, player_name, album)
        M.artist_text.markup = "<span foreground=\"#dcdccc\">".. artist .. "</span>" or "Nothing"
        M.title_text.markup = "<span foreground=\"#dcdccc\">".. title .. "</span>" or "Playing"
        M.album_text.markup = "<span foreground=\"#dcdccc\">".. album .. "</span>" or "No album"
    end)

    awesome.connect_signal("playerctl::art::update", function(art_path)
        if not art_path or art_path == "" then
            M.art.image = beautiful.icon_music
        else
            M.art.image = gears.surface.load_uncached_silently(art_path)
        end
    end)

    awesome.connect_signal("playerctl::toggle::update", function(playing)
        if playing then
            M.toggle_icon.markup = "<span foreground=\"#dcdccc\"></span>"
        else
            M.toggle_icon.markup = "<span foreground=\"#dcdccc\"></span>"
        end
    end)

    return M.widget
end

return M
