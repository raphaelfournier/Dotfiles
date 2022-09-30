local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widget = require("szorfein.widgets")
local helpers = require("szorfein.helpers")
local naughty = require("naughty")

-- beautiful vars
local icon_prev = beautiful.widget_mpc_prev_icon
local icon_pause = beautiful.widget_mpc_pause_icon
local icon_play = beautiful.widget_mpc_play_icon
local icon_stop = beautiful.widget_mpc_stop_icon
local icon_next = beautiful.widget_mpc_next_icon
local fg = beautiful.widget_mpc_fg
local bg = beautiful.widget_mpc_bg
local l = beautiful.widget_mpc_layout or 'horizontal'

-- widget creation
local icon_1 = widget.base_icon()
local icon_2 = widget.base_icon()
local icon_3 = widget.base_icon()
local icon_margin_1 = widget.icon(icon_1)
local icon_margin_2 = widget.icon(icon_2) 
local icon_margin_3 = widget.icon(icon_3)
mpc_widget = widget.box(l, icon_margin_1, icon_margin_2, icon_margin_3)

local status
local GET_MPD_CMD = "mpc status" 
local TOGGLE_MPD_CMD = "mpc toggle"
local NEXT_MPD_CMD = "mpc next"
local PREV_MPD_CMD = "mpc prev"

awful.widget.watch(GET_MPD_CMD, 3, function(widget, stdout, exitreason, exitcode)
  stdout = string.gsub(stdout, "\n", "")
  status = stdout:match('%[(.*)%]') or "void"
  status = string.gsub(status, '^%s*(.-)%s*$', '%1')
  icon_1.markup = helpers.colorize_text(icon_prev, fg)
  if (status == "playing") then
    icon_2.markup = helpers.colorize_text(icon_pause, fg)
  elseif (status == "paused") then
    icon_2.markup = helpers.colorize_text(icon_play, fg)
  elseif (status == "void") then
    icon_2.markup = helpers.colorize_text(icon_play, fg)
  else
    icon_2.markup = helpers.colorize_text(icon_stop, fg)
  end
  icon_3.markup = helpers.colorize_text(icon_next, fg)
end)

local function show_mpc_warning()
  naughty.notify{
    icon_size=100,
    title = "No playlist",
    text = "Mpc has no playlist to read",
    timeout = 5, hover_timeout = 0.5,
    position = "bottom_right",
    bg = "#F06060",
    fg = "#EEE9EF",
    width = 300,
  }
end

icon_1:connect_signal("button::press", function(_, _, _, button)
  if (button == 1) then 
    if status == 'void' then
      show_mpc_warning()
    else
      awful.spawn(PREV_MPD_CMD, false) 
    end
  end -- left click
end)

icon_2:connect_signal("button::press", function(_, _, _, button)
  if (button == 1) then 
    if status == 'void' then
      show_mpc_warning()
    else
      awful.spawn(TOGGLE_MPD_CMD, false) 
    end
  end -- left click
end)

icon_3:connect_signal("button::press", function(_, _, _, button)
  if (button == 1) then 
    if status == 'void' then
      show_mpc_warning()
    else
      awful.spawn(NEXT_MPD_CMD, false) 
    end
  end -- left click
end)
