local naughty   = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")

naughty.config.defaults.screen           = 1
naughty.config.defaults.timeout          = 20
naughty.config.defaults.hover_timeout    = 0.5
naughty.config.defaults.position         = "bottom_right"
--naughty.config.defaults.position         = "top_right"
--naughty.config.defaults.max_height           = 60
naughty.config.defaults.margin           = 10
naughty.config.defaults.max_width            = 600
naughty.config.defaults.gap              = 10
naughty.config.defaults.ontop            = true
naughty.config.defaults.font             = beautiful.notifyfont or "Inconsolata Medium 18"
naughty.config.defaults.icon             = nil
naughty.config.defaults.icon_size        = 50
naughty.config.defaults.border_width     = 4

naughty.config.defaults.shape     = function(cr,w,h)
  gears.shape.rounded_rect(cr,w,h,10)
end

naughty.config.presets.normal.border_color     ="#dcdccc" --beautiful.border_focus or '#535d6c'
naughty.config.presets.normal.bg     = beautiful.wibar_bg --beautiful.fg_focus or '#535d6c'
naughty.config.presets.normal.fg     = beautiful.bg_normal
naughty.config.presets.normal.opacity     = 0.7

naughty.config.presets.low.bg                  = beautiful.bg_normal
naughty.config.presets.low.fg                  = '#f0dfaf'
naughty.config.presets.low.border_color        = '#f0dfaf'
naughty.config.presets.low.border_width     = 6
naughty.config.presets.low.icon_size        = 90
--naughty.config.presets.low.height           = 100
--naughty.config.presets.low.width           = 300
naughty.config.presets.low.timeout          = 20
naughty.config.presets.low.hover_timeout    = 0.5

naughty.config.presets.critical.bg             = '#882222'
naughty.config.presets.critical.fg             = '#dcdccc'
naughty.config.presets.critical.width          = 600
--naughty.config.presets.critical.height         = 350
naughty.config.presets.critical.border_color   = beautiful.border_focus or '#535d6c'
naughty.config.presets.critical.font             = beautiful.notifyfont or "Inconsolata Medium 18"


