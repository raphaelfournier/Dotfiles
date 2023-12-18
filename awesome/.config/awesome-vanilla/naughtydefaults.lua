local naughty   = require("naughty")
local beautiful = require("beautiful")
local gears = require("gears")
local rnotification = require("ruled.notification")


-- https://github.com/raven2cz/awesomewm-config/blob/master/themes/multicolor/theme.lua#L769
--------------------------
-- NAUGHTY CONFIGURATION
--------------------------
--naughty.config.defaults.ontop = true
--naughty.config.defaults.icon_size = dpi(360)
--naughty.config.defaults.timeout = 10
--naughty.config.defaults.hover_timeout = 300
--naughty.config.defaults.title = 'System Notification Title'
--naughty.config.defaults.margin = dpi(16)
--naughty.config.defaults.border_width = 0
--naughty.config.defaults.position = 'top_middle'
--naughty.config.defaults.shape = function(cr, w, h)
	--gears.shape.rounded_rect(cr, w, h, dpi(6))
--end

---- Apply theme variables
--naughty.config.padding = dpi(8)
--naughty.config.spacing = dpi(8)
--naughty.config.icon_dirs = {
	--'/usr/share/icons/Papirus-Dark/',
	--'/usr/share/icons/Tela',
	--'/usr/share/icons/Tela-blue-dark',
	----'/usr/share/icons/la-capitaine/'
--}
--naughty.config.icon_formats = { 'svg', 'png', 'jpg', 'gif' }

--rnotification.connect_signal('request::rules', function()
	---- Critical notifs
	--rnotification.append_rule {
		--rule       = { urgency = 'critical' },
		--properties = {
			--font                = theme.font_notify,
			--bg                  = theme.bg_urgent,
			--fg                  = theme.fg_normal,
			--margin              = dpi(16),
			--icon_size           = dpi(360),
			--position            = 'top_middle',
			--implicit_timeout    = 0
		--}
	--}

	---- Normal notifs
	--rnotification.append_rule {
		--rule       = { urgency = 'normal' },
		--properties = {
			--font                = theme.font_notify,
			--bg                  = theme.notification_bg,
			--fg                  = theme.notification_fg,
			--margin              = dpi(16),
			--position            = 'top_middle',
			--implicit_timeout    = 10,
			--icon_size           = dpi(360),
			--opacity             = 0.87
		--}
	--}

	---- Low notifs
	--rnotification.append_rule {
		--rule       = { urgency = 'low' },
		--properties = {
			--font                = theme.font_notify,
			--bg                  = theme.notification_bg,
			--fg                  = theme.notification_fg,
			--margin              = dpi(16),
			--position            = 'top_middle',
			--implicit_timeout    = 10,
			--icon_size           = dpi(360),
			--opacity             = 0.87
		--}
	--}
--end
--)

---- Error handling
--naughty.connect_signal('request::display_error', function(message, startup)
	--naughty.notification {
		--urgency = 'critical',
		--title   = 'Oops, an error happened'..(startup and ' during startup!' or '!'),
		--message = message,
		--app_name = 'System Notification',
		--icon = theme.awesome_icon
	--}
--end
--)
---- naughty.connect_signal("request::display", function(n)
----     naughty.layout.box { notification = n }
---- end
---- )

---- XDG icon lookup
--naughty.connect_signal('request::icon', function(n, context, hints)
	--if context ~= 'app_icon' then
		---- try use random notification portrait from resources
		--if #notif_user >= 1 then
			--n.icon = notifpath_user .. notif_user[math.random(#notif_user)]
		--end
		--return
	--end
	---- try use application icon
	--local path = menubar.utils.lookup_icon(hints.app_icon) or
	--menubar.utils.lookup_icon(hints.app_icon:lower())

	--if path then
		--n.icon = path
	--end
--end
--)

--naughty.connect_signal("request::action_icon", function(a, _, hints)
	--a.icon = menubar.utils.lookup_icon(hints.id)
--end)

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

naughty.config.presets.low.bg                  = '#3F3F3F'
naughty.config.presets.low.fg                  = '#dcdccc'
naughty.config.presets.low.border_color        = "#dcdccc"
naughty.config.presets.low.border_width     = 4
--naughty.config.presets.low.icon_size        = 90
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


