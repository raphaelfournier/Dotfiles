local wibox = require("wibox")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local widget = require("szorfein.widgets")
local helpers = require("szorfein.helpers")
local dpi = require('beautiful').xresources.apply_dpi

-- widget for the popup
local mpc = require("szorfein.mpc")
local volume_bar = require("szorfein.volume-bar")

-- beautiful vars
local fg = beautiful.widget_volume_fg or "#FFFFFF"
local bg = beautiful.widget_volume_bg or "#FF0000"

-- for the popup
local fg_p = beautiful.fg_grey or "#aaaaaa"
local bg_p = beautiful.grey_dark or "#222222" -- same than the wibar
local padding = beautiful.widget_popup_padding or 1

-- widget creation
local text = widget.for_one_icon(fg, bg, "  ", "Inconsolata Medium 16")
local popup_time = widget.base_text()

local function update_widget(volume)
  popup_time.markup = helpers.colorize_text("Time: "..volume, "#66ffff")
end

awful.widget.watch(
  os.getenv("HOME").."/.config/awesome/szorfein/audio.sh music", 2,
  function(widget, stdout, stderr, exitreason, exitcode)
    local info = stdout:match('(%d+:%d+.%d+:%d+%s?%d+%%)') or 0
    update_widget(info)
  end
)

local popup_image = wibox.widget {
  resize = true,
  forced_height = 80,
  forced_width = 83,
  widget = wibox.widget.imagebox
}

local popup_title = widget.base_text()
local popup_artist = widget.base_text()
local popup_percbar = widget.base_text()

local w_position -- the postion of the popup depend of the wibar
if beautiful.wibar_position == 'top' then
  w_position = 'bottom' 
else 
  w_position = 'top'
end

local w = awful.popup {
  widget = {
    {
      {
        popup_image,
        layout = wibox.layout.align.horizontal
      },
      {
        {
          popup_title,
          popup_artist,
          popup_time,
          popup_percbar,
          {
            {
              mpc_widget,
              top = 4, -- have to have similar value than bellow
              widget = wibox.container.margin
            },
            {
              volume_bar,
              top = 4, -- same above
              left = 14,
              widget = wibox.container.margin
            },
            layout = wibox.layout.align.horizontal
          },
          layout = wibox.layout.fixed.vertical
        },
        left = 10,
        right = 4,
        widget = wibox.container.margin
      },
      layout = wibox.layout.align.horizontal
    },
    margins = 10,
    widget = wibox.container.margin
  },
  visible = false, -- do not show at start
  ontop = true,
  hide_on_right_click = true,
  preferred_positions = w_position,
  --preferred_anchors = 'middle',
  --current_position = 'bottom',
  offset = { y = padding, x = padding }, -- no pasted on the bar
  bg = bg_p,
}

-- attach popup to widget
w:bind_to_widget(text)

-- audio.sh arguments are: [music_details] [path of your music directory]
local mpc_details_script = [[
  bash -c "
  ~/.config/awesome/szorfein/audio.sh music_details ~/Musique
"]]

local function update_popup()
  awful.widget.watch(mpc_details_script, 15 ,function(widget, stdout)
    local img, title, artist, percbar = stdout:match('img:%[(.*)%]%s?title:%[(.*)%]%s?artist:%[(.*)%]%s?percbar:%[(.*)%]*%]')

    -- default value
    img = img or ''
    title = title or ''
    artist = artist or ''
    percbar = percbar or '----------------------------' -- 28

    if img ~= '' then
      popup_image.image = img
    else
      popup_image.image = beautiful.widget_mpc_time_cover_album
    end

    if title ~= '' then
      popup_title.markup = helpers.colorize_text("Title: "..title, "#ff66ff")
    else
      popup_title.markup = helpers.colorize_text("Unknown", "#ff66ff")
    end

    if artist ~= '' then
      popup_artist.markup = helpers.colorize_text("Artist: "..artist, "#ffff66")
    else
      popup_artist.markup = helpers.colorize_text("Artist: Jane Doe", "#ffff66")
    end

    popup_percbar.markup = helpers.colorize_text(percbar, "#6f6fff")
  end)
end

update_popup()

return text
