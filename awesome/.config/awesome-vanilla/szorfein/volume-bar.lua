local wibox = require("wibox")
local awful = require("awful")
local shape = require("gears.shape")
local beautiful = require("beautiful")

-- Colors
local primary = beautiful.primary or '#ff66ff'
local secondary = beautiful.grey_light or '#6f6fff'

local bar = wibox.widget {
  max_value = 100,
  value = 0,
  forced_height = 3,
  forced_width = 100,
  shape = shape.rounded_bar,
  color = primary,
  background_color = secondary,
  widget = wibox.widget.progressbar
}

awful.widget.watch(
  -- you can change <Pro> with your card name if non detected
  os.getenv("HOME").."/.config/awesome/widgets/audio.sh volume Pro", 4,
  function(widget, stdout, stderr, exitreason, exitcode)
    local volume = stdout:match('%w+:%s?(%d+)') or 0
    bar.value = tonumber(volume)
  end
)

return bar
