-- {{{ local require
os.setlocale( os.getenv( 'LANG' ), 'time' )
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local rubato = require("rubato")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
local theme_file = os.getenv("HOME") .. '/.config/awesome/theme.lua'
-- Notification library
local naughty       = require("naughty")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
--local vicious       = require("vicious")
local lain          = require("lain")
local rofi = require("rofi")
local xrandr = require("xrandr")
local poppin = require('poppin')
local bling = require("bling")
local sidebar = require("sidebar")
--local fakescreen = require("awesomewm-fakescreen")

local tagBlocked = false
local SCREENLOCK_COMMAND = "xautolock -locknow"

--local bling = require("bling")

local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
--batteryarc_widget:connect_signal('mouse::enter', function()
--awful.util.spawn("/home/raph/Dotfiles/rofi/.config/rofi/scripts/battery.sh")
--end)

--local pomodoroarc_widget = require("awesome-wm-widgets.pomodoroarc-widget.pomodoroarc")
local watsonarc_widget = require("awesome-wm-widgets.watsonarc-widget.watsonarc")
local watson_shell = require("awesome-wm-widgets.watson-shell.watson-shell")
local demoMode_widget = require("awesome-wm-widgets.demoMode-widget.demomode") -- teaching mode
--local buttonmpc = require("szorfein.button_only_mpc")

local mpd_widget = require("awesome-wm-widgets.mpd-widget.mpd")
local mpdarc_widget = require("awesome-wm-widgets.mpdarc-widget.mpdarc")
--mpdarc_widget:connect_signal('mouse::enter', function()
--awful.util.spawn("/home/raph/Dotfiles/rofi/.config/rofi/scripts/mpd.sh")
--end)

--bling.module.flash_focus.enable()

require("naughtydefaults")
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notification({ preset = naughty.config.presets.critical,
	title = "Oops, there were errors during startup!",
	text = awesome.startup_errors })
end

-- https://www.reddit.com/r/awesomewm/comments/yrc88m/possible_to_tile_with_fill_policymw_factor_but/
local hacky_layout = {
	name = "h"
}
hacky_layout.arrange = function(s)
	if #s.clients == 1 then
		local c = s.clients[1]
		local t = awful.screen.focused().selected_tag
		local g = {
			x = s.workarea.x,
			y = s.workarea.y,
			width = s.workarea.width * t.master_width_factor,
			height = s.workarea.height,
		}
		s.geometries[c] = g
		return
	end
	awful.layout.suit.tile.arrange(s)
end

function splittokens(s)
	local res = {}
	for w in s:gmatch("%S+") do
		res[#res+1] = w
	end
	return res
end

function textwrap(text, linewidth)
	if not linewidth then
		linewidth = 75
	end

	local spaceleft = linewidth
	local res = {}
	local line = {}

	for _, word in ipairs(splittokens(text)) do
		if #word + 1 > spaceleft then
			table.insert(res, table.concat(line, ' '))
			line = {word}
			spaceleft = linewidth - #word
		else
			table.insert(line, word)
			spaceleft = spaceleft - (#word + 1)
		end
	end

	table.insert(res, table.concat(line, ' '))
	return table.concat(res, '\n')
end

-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notification({ preset = naughty.config.presets.critical,
		title = "Oops, an error happened!",
		--text = textwrap(tostring(err)) })
		text = textwrap(tostring(err)) })
		in_error = false
	end)
end
-- }}}

-- {{{ Change config set 

function change_config_set(name)
	local theme_cmd = "cat "..theme_file.." | grep 'al the_them' | cut -c20-"
	theme_cmd = string.gsub(theme_cmd, '"', '')
	naughty.notification{ text = "bla: " .. theme_cmd}
	local current_theme = awful.spawn.easy_async_with_shell(theme_cmd,
	function(stdout, stderr, reason, exit_code)
		naughty.notification{
			text = stderr,
			title = "current_theme",
			timeout = 5, hover_timeout = 0.5,
			width = 400,
		}
	end
	)
	naughty.notification{ text = "coucou" .. current_theme }
	--update_cmd = "cat " .. theme_file .. " | sed 's/" .. current_theme .. "/"..name.."/g' | tee " .. theme_file
	--current_theme = name
	--naughty.notify{ text = update_cmd }
	--awful.spawn.easy_async_with_shell(update_cmd, function ()
	--awesome.restart()
	--end)
end

-- configset 
configsets = {
	{ "zenburn", function () change_config_set("myzenburn") end },
	{ "xresources", function () change_config_set("myxresources") end }
} -- config set
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
require("theme")
--beautiful.init(awful.util.getdir("config") .. "/themes/myzenburn/theme.lua")

-- Pomodoro https://github.com/nikolavp/awesome-pomodoro
--pomodoro.format = function (t) return "<span font='Inconsolata 13' color='#b3b3ff'>" .. t .. "</span>" end
--pomodoro.on_work_pomodoro_finish_callbacks = {
--function()
--exec('xscreensaver-command -lock')
--end
--}
--pomodoro.init()
--
--beautiful.init( awful.util.getdir("config") .. "/themes/awesome-solarized/light/theme.lua" )
--beautiful.init(awful.util.get_themes_dir() .. "zenburn/theme.lua")

local volumearc_widget = require("awesome-wm-widgets.volumearc-widget.volumearc")

-- This is used later as the default terminal and editor to run.
--terminal = "kitty"
terminal = "urxvt"
terminal = "alacritty" -- -o font.size=12"
multiplexer = "screen"
multiplexer = "tmux"
editor = os.getenv("EDITOR") or "nano"
editor = "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
mod1 = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
	--awful.layout.suit.spiral.dwindle,
	awful.layout.suit.tile, 
	awful.layout.suit.max, 
	awful.layout.suit.tile.bottom, 
	awful.layout.suit.tile.left, 
	awful.layout.suit.floating, 
	hacky_layout,
	--awful.layout.suit.max.fullscreen, 
	--awful.layout.suit.corner.nw,
	--awful.layout.suit.magnifier, 
	--awful.layout.suit.spiral,
	--lain.layout.termfair.center,
	--bling.layout.mstab,
	--bling.layout.centered,
	--bling.layout.vertical,
	--bling.layout.horizontal,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
	local instance = nil

	return function ()
		if instance and instance.wibox.visible then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ theme = { width = 250 } })
		end
	end
end

-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
	{ "hotkeys", function() return false, hotkeys_popup.show_help end},
	{ "manual", terminal .. " -e man awesome" },
	{ "arandr", function() awful.util.spawn("arandr") end},
	{ "edit config", editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{ "quit", function() awesome.quit() end}
}

followcursormenu = {
	{"start follow", function() awful.util.spawn("find-cursor --repeat 0 --follow --distance 1 --wait 1000 --line-width 18 --size 18 --color red") end },
	{"stop follow", function() awful.util.spawn("killall find-cursor") end },
	{"gromit-mpx", function() awful.util.spawn("gromit-mpx") end },
}
mpdmenu = {
	{"random", function() awful.util.spawn("mpc random") end },
	{"toggle", function() awful.util.spawn("mpc toggle") end },
	{"next", function() awful.util.spawn("mpc next") end },
	{"previous", function() awful.util.spawn("mpc previous") end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, icon=beautiful.awesome_icon },
{ "set config", configsets },
{ "coffee break", function() awful.util.spawn(SCREENLOCK_COMMAND) end, beautiful.coffee },
{ "insideOutside", function() awful.util.spawn_with_shell("bash ~/.scripts/insideOutside.sh") end },
{ "passwords", function() awful.util.spawn("rofi-pass") end },
{ "cursor", followcursormenu, beautiful.menu_submenu_icon },
{ "mpc", mpdmenu, beautiful.menu_submenu_icon },
{ "blockOnTag", function(self) 
	tagBlocked = not tagBlocked
	if tagBlocked then
		mylauncher.image = gears.color.recolor_image(beautiful.awesome_icon, beautiful.fg_urgent)
		local s = awful.screen.focused()
		local i = find_empty_tag()
		local tag = s.tags[i]
		if tag then
			tag:view_only()
		end
		--naughty.notify{ title="emptytag", text = tostring(find_empty_tag()), timeout = 5} 
	else
		mylauncher.image = beautiful.awesome_icon
	end
	--naughty.notify{ title="TagBlocked", text = tostring(tagBlocked), timeout = 3} 
end }, { "open terminal", terminal } } })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

smallspace = wibox.widget.textbox()
smallspace:set_text(' ')
smallspace.font = beautiful.font

space = wibox.widget.textbox()
space:set_text(' ')
mytextclock = wibox.widget.textclock("%a %d %H:%M")
mytextclock2 = wibox.widget.textclock("%a\n%d\n%H\n%M")
mytextclock.font = beautiful.font
mytextclock2.font = beautiful.font

local styles = {}
local function rounded_shape(size, partial)
	if partial then
		return function(cr, width, height)
			gears.shape.partially_rounded_rect(cr, width, height,
			false, true, false, true, 5)
		end
	else
		return function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, size)
		end
	end
end

styles.month   = { 
	padding      = 5, 
	bg_color     = beautiful.fg_normal or '#555555', 
	border_width = 2, 
	--shape        = rounded_shape(10)
}
styles.normal  = { shape    = rounded_shape(5), }
styles.focus   = { fg_color = beautiful.fg_focus or '#000000',
bg_color = beautiful.default_focus or '#ff9800',
markup   = function(t) return '<b>' .. t .. '</b>' end,
shape    = rounded_shape(5, true)
}
styles.header  = { fg_color = beautiful.fg_normal,
bg_color = beautiful.default_focus or '#ff9800',
markup   = function(t) return '<b>' .. t .. '</b>' end,
shape    = rounded_shape(10)
}
styles.weeknumber = { fg_color = beautiful.fg_urgent,
markup   = function(t) return '<b>' .. t .. '</b>' end,
shape    = rounded_shape(5)
}
styles.weekday = { fg_color = '#7788af',
markup   = function(t) return '<b>' .. t .. '</b>' end,
shape    = rounded_shape(5)
}

local month_calendar = awful.widget.calendar_popup.month(
{
	bg=beautiful.fg_normal,
	week_numbers=true,
	start_sunday=false,
	long_weekdays=false,
	font="Inconsolata 18",
	style_month=styles.month,
	style_header=styles.header,
	style_weekday=styles.weekday,
	style_weeknumber=styles.weeknumber,
	style_normal=styles.normal,
	style_focus=styles.focus,
	margin = 8,
})
month_calendar:attach( mytextclock, "tr", {on_hover=true} )
month_calendar:attach( mytextclock2, "bl", {on_hover=true} )
--month_calendar:attach( time, "bl", {on_hover=true} )


-- Create a wibox for each screen and add it
-- colours
coldef  = "</span>"
red  = "<span background='#ff0000' color='#000000'>"
white  = "<span color='#cdcdcd'>"
orange = "<span background='#ffa500' color='#000000'>"
green = "<span color='#87af5f'>"
--lightblue = "<span color='#7DC1CF'>"
--blue = "<span foreground='#1793d1'>"
--brown = "<span color='#db842f'>"
--fuchsia = "<span color='#800080'>"
--gold = "<span color='#e7b400'>"
--yellow = "<span color='#e0da37'>"
--lightpurple = "<span color='#eca4c4'>"
--azure = "<span color='#80d9d8'>"
--lightgreen = "<span color='#62b786'>"
--font = "<span font='Source Code Pro 10'>"

--volumewidget = wibox.widget.textbox()
--volumewidget:buttons(awful.util.table.join(
--awful.button({ }, 1, function () awful.util.spawn("amixer -q -c 1 sset Master toggle", false) end),
--awful.button({ }, 4, function () awful.util.spawn("amixer -q -c 0 sset Master 2dB+", false) end),
--awful.button({ }, 5, function () awful.util.spawn("amixer -q -c 0 sset Master 2dB-", false) end),
--awful.button({ }, 3, function () awful.util.spawn("pavucontrol", false) end)
----awful.button({ }, 2, function () awful.util.spawn("".. terminal.. " -e alsamixer", true) end)
--))
--vicious.register(volumewidget, vicious.widgets.volume, "$1%",1,"Master")
--batwidget = wibox.widget.textbox()
--vicious.register(batwidget, vicious.widgets.bat,
--function(widget, args)
--if args[2]<=10 then
--return red .. args[1].. args[2] .."%" .. coldef 
--end
--if args[2]>10 and args[2]<24 then
--return orange .. args[1] .. args[2] .. "%" .. coldef 
--else
--return white .. args[1] .. args[2] .. "%" .. coldef
--end
--end, 61, "BAT0")

--local notif = naughty.notification {
--title   = 'A notification',
--message = 'This notification has actions!',
--actions = {
--naughty.action {
--name = 'Accept',
--},
--naughty.action {
--name = 'Refuse',
--},
--naughty.action {
--name = 'Ignore',
--},
--}
--}

--wibox.widget {
--notification = notif,
--widget = naughty.list.actions,
--}


local taglist_buttons = awful.util.table.join(
awful.button({ }, 1, function(t) 
	if not tagBlocked then
		t:view_only() 
	end
end),
awful.button({ modkey }, 1, function(t)
	if client.focus then
		client.focus:move_to_tag(t)
	end
end),
--awful.button({ }, 2, function(t) naughty.notify{ title="tag debug", text = editor } end),
awful.button({ }, 3, function(t) 
	if not tagBlocked then
		awful.tag.viewtoggle()
	end
end),
awful.button({ modkey }, 3, function(t)
	if client.focus then
		client.focus:toggle_tag(t)
	end
end),
awful.button({ }, 4, function(t) 
	if not tagBlocked then
		awful.tag.viewnext(t.screen) 
	end
end),
awful.button({ }, 5, function(t) 
	if not tagBlocked then
		awful.tag.viewprev(t.screen) 
	end
end)
)

testpopup = awful.popup {
	widget = awful.widget.tasklist {
		hide_on_right_click = true,
		screen   = screen[1],
		filter   = awful.widget.tasklist.filter.allscreen,
		style    = {
			shape = gears.shape.rounded_rect,
		},
		layout   = {
			spacing = 5,
			forced_num_rows = 2,
			layout = wibox.layout.grid.horizontal
		},
		widget_template = {
			{
				{
					id     = 'clienticon',
					buttons  = alttabpopup_buttons,
					widget = awful.widget.clienticon,
				},
				margins = 4,
				widget  = wibox.container.margin,
			},
			id              = 'background_role',
			forced_width    = 96,
			forced_height   = 96,
			widget          = wibox.container.background,
			create_callback = function(self, c, index, objects)
				self:get_children_by_id('clienticon')[1].client = c
			end,
		},
	},
	border_color = beautiful.border_focus,
	border_width = 6,
	bg           = beautiful.bg_normal,
	placement    = awful.placement.centered,
	shape        = gears.shape.rounded_rect,
	visible      = false,
	ontop        = true,
	hide_on_right_click = true,
}

--tagpopup = awful.popup : setup {{
--{
--{
--{
--id = 'maintext',
--text   = 'foobar',
--widget = wibox.widget.textbox
--},
--{
--{
--text   = 'barbaz',
--widget = wibox.widget.textbox
--},
--bg     = '#ff00ff',
--clip   = true,
--shape  = gears.shape.rounded_bar,
--widget = wibox.widget.background
--},
--{
--value         = 0.5,
--forced_height = 30,
--forced_width  = 100,
--widget        = wibox.widget.progressbar
--},
--layout = wibox.layout.fixed.vertical,
--},
--id = 'margins',
--margins = 10,
--widget  = wibox.container.margin
--},
--id = 'tagpopup',
--border_color = '#00ff00',
--border_width = 5,
--placement    = awful.placement.centered,
--shape        = gears.shape.rounded_rect,
--ontop        = true,
--visible      = false,
--},
--layout = wibox.layout.align.horizontal
--}


-- https://www.reddit.com/r/awesomewm/comments/bqzxz8/alttablike_cycle_widget_on_two_screens/
--awful.keygrabber {
--keybindings = {
--{{modkey    }, 'Tab', function() awful.client.focus.byidx(-1) end,}
--},
--stop_key       = modkey,
--stop_event     = "release",
--start_callback = function()
--testpopup.visible = true
--end,
--stop_callback  = function()
--testpopup.visible = false
--end,
--export_keybindings = true,
--}

--testpopup = awful.popup {
--widget = {
--{
--{
--text   = 'foobar',
--widget = wibox.widget.textbox
--},
--{
--{
--text   = 'foobar',
--widget = wibox.widget.textbox
--},
--bg     = '#ff00ff',
--clip   = true,
--shape  = gears.shape.rounded_bar,
--widget = wibox.widget.background
--},
--{
--value         = 0.5,
--forced_height = 30,
--forced_width  = 100,
--widget        = wibox.widget.progressbar
--},
--layout = wibox.layout.fixed.vertical,
--},
--margins = 10,
--widget  = wibox.container.margin
--},
--border_color = '#00ff00',
--border_width = 5,
--placement    = awful.placement.top_left,
--shape        = gears.shape.rounded_rect,
--visible      = true,
--}

local alttabpopup_buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
	if c == client.focus then
		c.minimized = true
	else
		-- Without this, the following
		-- :isvisible() makes no sense
		c.minimized = false
		if not c:isvisible() and c.first_tag then
			c.first_tag:view_only()
		end
		-- This will also un-minimize
		-- the client, if needed
		client.focus = c
		c:raise()
	end
end),
awful.button({ }, 2, function (client) client:kill() end),
awful.button({ }, 3, client_menu_toggle_fn()),
awful.button({ }, 4, function ()
	awful.client.focus.byidx(1)
end),
awful.button({ }, 5, function ()
	awful.client.focus.byidx(-1)
end))
testpopup:buttons(alttabpopup_buttons)

local tasklist_buttons = awful.util.table.join(
awful.button({ }, 1, function (c)
	if c == client.focus then
		c.minimized = true
	else
		-- Without this, the following
		-- :isvisible() makes no sense
		c.minimized = false
		if not c:isvisible() and c.first_tag then
			c.first_tag:view_only()
		end
		-- This will also un-minimize
		-- the client, if needed
		client.focus = c
		c:raise()
	end
end),
awful.button({ }, 2, function (c) 
	if not tagBlocked then
		if c.class ~= "firefox" then
			c:kill() 
		end
	end
end),
awful.button({ }, 3, function (c) rofi.client_flags(c) end),
--awful.button({ }, 3, client_menu_toggle_fn()),
awful.button({ }, 4, function ()
	if not tagBlocked then
		awful.client.focus.byidx(1)
	end
end),
awful.button({ }, 5, function ()
	if not tagBlocked then
		awful.client.focus.byidx(-1)
	end
end))

function set_wallpaper(s)
	--awful.util.spawn("nitrogen --restore")
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		--local wallpaper2 = beautiful.wallpaper2
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		for i = 1, screen.count() do
			if i < 2 then
				gears.wallpaper.maximized(wallpaper, i, true)
			elseif s.geometry.height < s.geometry.width then -- it's the second screen
				gears.wallpaper.maximized(beautiful.wallpaperlandscape, s, true)
			else
				gears.wallpaper.maximized(beautiful.wallpaperportrait, s, true)
			end
		end
	end
end

--local function set_taglist(s)
--s.mytaglist = awful.widget.taglist {
--screen  = s,
--filter  = awful.widget.taglist.filter.noempty,
--style   = {
--shape        = gears.shape.circle,
--},
--widget_template = {
----{
--{
--{
--id     = 'index_role',
--widget = wibox.widget.textbox,
--},
--margins = 2,
--widget  = wibox.container.margin,
--},
--id     = 'background_role',
--fg     = beautiful.fg_normal,
--bg     = beautiful.bg_focus .. "80",
--shape  = gears.shape.circle,
--widget = wibox.container.background,

--create_callback = function(self, c3, index, objects)
--local tooltip = awful.tooltip({
--objects = { self },
--timer_function = function()
--return c3.index .. ": " .. c3.name .. " | " .. c3.layout.name
--end,
--delay_show = 0.6
--})
---- Then you can set tooltip props if required
--tooltip.margins_leftright = 8
--tooltip.margins_topbottom = 4

--self:get_children_by_id('index_role')[1].markup = '<b> '..tostring(c3.index%10)..' </b>'
--self:connect_signal('mouse::enter', function()
--self.bgbackup     = self.bg
--self.fgbackup     = self.fg
--self.has_backup = true
--self.bg = beautiful.fg_focus
--self.fg = beautiful.bg_normal
--end)
--self:connect_signal('mouse::leave', function()
----if self.has_backup then 
--self.bg = self.bgbackup 
--self.fg = self.fgbackup 
----end
--end)
--end,

--update_callback = function(self, c3, index, objects)
--self:get_children_by_id('index_role')[1].markup = '<b> '..tostring(c3.index%10)..' </b>'
--end,
--},
--buttons = taglist_buttons
----},
----shape        = gears.shape.rounded_bar,
----bg           = beautiful.tasklist_bg_normal,
----fg           = beautiful.tasklist_fg_normal,
----widget = wibox.container.background,
----},
----right =8,
----widget = wibox.container.margin
--}
--end



local function set_taglist(s)
	s.mytaglist = 
	{
		{
			awful.widget.taglist {
				screen  = s,
				filter  = awful.widget.taglist.filter.noempty,
				style   = {
					shape        = gears.shape.rounded_bar,
					spacing = 2,
				},
				widget_template = 
				{
					{
						{
							{
								id     = 'index_role',
								font = beautiful.font,
								widget = wibox.widget.textbox,
							},
							{
								id     = 'icon_role',
								widget = wibox.widget.imagebox,
							},
							layout  = wibox.layout.fixed.horizontal,
							spacing = 0,
						},
						left = 0,
						right = 4,
						widget  = wibox.container.margin,
					},
					id     = 'background_role',
					bg     = beautiful.bg_focus .. "00",
					widget = wibox.container.background,

					create_callback = function(self, c3, index, objects)
						local tooltip = awful.tooltip({
							objects = { self },
							timer_function = function()
								return c3.index .. ": " .. c3.name .. " | " .. c3.layout.name
							end,
							delay_show = 0.6
						})
						-- Then you can set tooltip props if required
						tooltip.margins_leftright = 8
						tooltip.margins_topbottom = 4

						self:get_children_by_id('index_role')[1].markup = '<b> '..tostring(c3.index%10)..' </b>'

						--self:connect_signal('mouse::enter', function()
						--self.bgbackup     = self.bg
						--self.fgbackup     = self.fg
						--self.has_backup = true
						--self.bg = beautiful.fg_focus
						--self.fg = beautiful.bg_normal
						--end)
						--self:connect_signal('mouse::leave', function()
						--self.bg = self.bgbackup 
						--self.fg = self.fgbackup 
						--end)
					end,

					update_callback = function(self, c3, index, objects)
						self:get_children_by_id('index_role')[1].markup = '<b> '..tostring(c3.index%10)..' </b>'
					end,
				},
				buttons = taglist_buttons
			},
			shape        = gears.shape.rounded_bar,
			bg           = beautiful.tasklist_bg_normal .. "00",
			fg           = beautiful.tasklist_fg_normal, -- couleurs des chiffres des tags
			widget = wibox.container.background,
		},
		right =8,
		widget = wibox.container.margin
	}

	s.mytaglist2 = 
	{
		{
			awful.widget.taglist {
				screen  = s,
				filter  = awful.widget.taglist.filter.noempty,
				style   = {
					--shape        = gears.shape.rounded_bar,
					--spacing = 2,
				},
				widget_template = 
				{
					{
						{
							{
								id     = 'index_role',
								font = beautiful.font,
								widget = wibox.widget.textbox,
							},
							{
								id     = 'icon_role',
								widget = wibox.widget.imagebox,
							},
							layout  = wibox.layout.fixed.vertical,
							spacing = 0,
						},
						left = 2,
						--right = 4,
						widget  = wibox.container.margin,
					},
					id     = 'background_role',
					bg     = beautiful.bg_focus .. "00",
					widget = wibox.container.background,

					create_callback = function(self, c3, index, objects)
						local tooltip = awful.tooltip({
							objects = { self },
							timer_function = function()
								return c3.index .. ": " .. c3.name .. " | " .. c3.layout.name
							end,
							delay_show = 0.1
						})
						-- Then you can set tooltip props if required
						tooltip.margins_leftright = 8
						tooltip.margins_topbottom = 4

						self:get_children_by_id('index_role')[1].markup = '<b> '..tostring(c3.index%10)..' </b>'

					end,

					update_callback = function(self, c3, index, objects)
						self:get_children_by_id('index_role')[1].markup = '<b> '..tostring(c3.index%10)..' </b>'
					end,
				},
				buttons = taglist_buttons
			},
			shape        = gears.shape.rounded_bar,
			bg           = beautiful.tasklist_bg_normal .. "00",
			fg           = beautiful.tasklist_fg_normal, -- couleurs des chiffres des tags
			widget = wibox.container.background,
		},
		--right =8,
		widget = wibox.container.margin
	}
end




-- local myclock_t = awful.tooltip {margins = 14 }
-- myclock_t:add_to_object(s.mytaglist)
-- s.mytaglist:connect_signal('mouse::enter', function()
--myclock_t.text = os.date('Today is %A %B %d %Y\nThe time is %T')
--end)
--end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

--if screen:count() == 2 then 
--naughty.notify{ 
--title= "debug",
--text = " nbscreens: "..tostring(screen:count())
--}
--local geo = screen[2].geometry
--local new_height = math.ceil(geo.height/4)
--local new_height2 = geo.height - new_height
--screen[2]:fake_resize(geo.x, geo.y, geo.width, new_height)
--screen.fake_add(geo.x, geo.y + new_height, geo.width, new_height2)
--end

--local geo = screen[1].geometry
--local width_portrait = 764
--local width_landscape = geo.width - width_portrait

--screen[1]:fake_resize(geo.x, geo.y, width_landscape, geo.height)
--screen.fake_add(geo.x + width_landscape, geo.y, width_portrait, geo.height)

--local systray = wibox.widget.systray()
--systray.opacity = 0.1
--systray.visible = true

--local systray2 = wibox.widget.systray()
--systray2.visible = true
--systray2:set_horizontal(false)

local tray = wibox.widget {
	widget = wibox.container.background,
	--bg     = beautiful.taglist_bg_normal,
	{
		layout = wibox.layout.fixed.vertical,
		{
			widget = wibox.container.place,
			halign = "center",
			{
				widget = wibox.container.margin,
				margins = { top = 8, bottom = 2 },
				id = "tray",
				visible = false,
					opacity = 0.1,
				{
					widget = wibox.widget.systray,
					horizontal = false,
					base_size = 36,
				}
			}
		},
		{
			widget = wibox.container.margin,
			margins = { top = 2, bottom = 2 },
			{
				widget = wibox.widget.textbox,
				id = "button",
				text = "▲",
				font = beautiful.font.. " 16",
				halign = "center",
			}
		}
	}
}

awesome.connect_signal("show::tray", function()
	if not tray:get_children_by_id("tray")[1].visible then
		tray:get_children_by_id("button")[1].text = "▼"
		tray:get_children_by_id("tray")[1].visible = true
	else
		tray:get_children_by_id("button")[1].text = "▲"
		tray:get_children_by_id("tray")[1].visible = false
	end
end)

tray:buttons{
	awful.button({}, 1, function() awesome.emit_signal("show::tray") end)
}

awful.screen.connect_for_each_screen(function(s)
	awful.screen.padding(s,0) -- voir dans le theme.lua useless_gap
	-- gaps on the edges of the screen
	--s.padding = 0
	-- Wallpaper
	set_wallpaper(s)

	--{"work",
	--"web",
	--"mail",
	--"im",
	--"media",
	--"pdf",
	--"graph",
	--"root",
	--"term"

	if s.index == 1 then
		awful.tag.add("work", {
			icon = beautiful.tag_icon_term,
			layout             = awful.layout.suit.max,
			master_width_factor = 0.77,
			master_fill_policy = "master_width_factor",
			--gap_single_client  = true,
			--gap                = 15,
			screen             = 1,
			selected           = true,
		})

		awful.tag.add("web", {
			icon = beautiful.tag_icon_web,
			layout = awful.layout.suit.max,
			--layout = awful.layout.suit.tile.bottom,
			--master_fill_policy = "master_width_factor",
			master_width_factor = 0.75,
			screen = 1,
		})

		awful.tag.add("mail", {
			icon = beautiful.tag_icon_mail,
			layout = awful.layout.suit.tile,
			master_width_factor = 0.6,
			--master_fill_policy = "master_width_factor",
			screen = 1,
		})

	end

	if s.index == screen:count() then
		awful.tag.add("im", {
			icon = beautiful.tag_icon_im,
			layout = awful.layout.suit.max,
			screen = screen:count(),
			--selected = true,
		})

		if s.index == 1 then
			awful.tag.add("media", {
				icon = beautiful.tag_icon_media,
				layout = awful.layout.suit.tile.bottom,
				master_width_factor = 0.66,
				screen = screen:count(),
			})

		else
			awful.tag.add("media", {
				icon = beautiful.tag_icon_media,
				layout = awful.layout.suit.tile.bottom,
				master_width_factor = 0.66,
				screen = screen:count(),
			})
		end


	end

	if s.index == 1 then
		awful.tag.add("pdf", {
			icon = beautiful.tag_icon_pdf,
			layout = awful.layout.suit.max,
			master_fill_policy = "master_width_factor",
			master_width_factor = 0.80,
			--column_count = 1,
			screen = 1,
		})

		awful.tag.add("graph", {
			icon = beautiful.tag_icon_graph,
			layout = awful.layout.suit.tile,
			--master_fill_policy = "master_width_factor",
			screen = 1,
		})

		awful.tag.add("root", {
			icon = beautiful.tag_icon_root,
			layout = awful.layout.suit.max,
			master_fill_policy = "master_width_factor",
			screen = 1,
		})

		awful.tag.add("term2", { -- hat icon
			icon = beautiful.tag_icon_term2,
			layout = awful.layout.suit.max,
			master_fill_policy = "master_width_factor",
			screen = 1,
		})
	end

	if s.index == screen:count() then
		if s.index == 1 then -- laptop only
			awful.tag.add("todo", {
				icon = beautiful.tag_icon_todo,
				layout = awful.layout.suit.max,
				screen = screen:count(),
			})
		else
			awful.tag.add("todo", {
				icon = beautiful.tag_icon_todo,
				layout = awful.layout.suit.tile.bottom,
				screen = screen:count(),
			})
		end
	end

	if s.index == 2 then
		awful.tag.add("foo", {
			icon = beautiful.tag_icon_todo,
			layout = awful.layout.suit.tile.bottom,
			screen = 2,
			selected = true,
		})
	end

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	s.screencount = wibox.widget.textbox()
	if screen:count() ~= 1 then
		s.screencount:set_text(s.index .. "/" .. screen:count())
	end

	--local coffeebreak_widget = wibox.widget {
	--image  = beautiful.coffee,
	--resize = true,
	--widget = wibox.widget.imagebox
	--}
	--coffeebreak_widget:buttons(awful.util.table.join(
	--awful.button({ }, 1, function () awful.util.spawn("xscreensaver-command -lock")   end)
	--))

	local taglist = awful.widget.taglist {
		screen = s,
		filter = awful.widget.taglist.filter.noempty,
		buttons = taglist_buttons,
		layout = {
			spacing = 4,
			layout = wibox.layout.fixed.vertical
		},
		style = { 
			squares_sel = "", 
			squares_unsel = "", 
			squares_sel_empty = "", 
			squares_unsel_empty = ""
		},
		widget_template = 
		{
			{
				{
					{
						{
							id     = 'index_role',
							font = beautiful.font,
							align  = 'left',
							widget = wibox.widget.textbox,
							left = -4,
						},
						{
							{
								id     = 'icon_role',
								widget = wibox.widget.imagebox,
							},
							widget = wibox.container.place,
							valign = "center",
						},
						layout  = wibox.layout.fixed.horizontal,
						spacing = -6,
					},
					left = -6,
					widget  = wibox.container.margin,
				},
			id     = 'background_role',
			bg     = "00ff00",
			widget = wibox.container.background,
			forced_height = 40,
			},

				widget  = wibox.container.background,
				shape   = gears.shape.rounded_bar,

			create_callback = function(self, c3, index, objects)
				local tooltip = awful.tooltip({
					objects = { self },
					timer_function = function()
						return c3.index .. ": " .. c3.name .. " | " .. c3.layout.name
					end,
					delay_show = 0.01
				})
				-- Then you can set tooltip props if required
				tooltip.margins_leftright = 8
				tooltip.margins_topbottom = 4

				self:get_children_by_id('index_role')[1].markup = '<b> '..tostring(c3.index%10)..' </b>'

			end,

			update_callback = function(self, c3, index, objects)
				self:get_children_by_id('index_role')[1].markup = '<b> '..tostring(c3.index%10)..' </b>'
			end,
		},

	}

	-- remplace textclock
	local time = wibox.widget {
		layout = wibox.layout.fixed.vertical,
		{
			widget = wibox.container.background,
			id = "clock",
			bg = beautiful.background_alt,
			{
				widget = wibox.container.margin,
				margins = { bottom = 6, top = 0 },
				{
					layout = wibox.layout.fixed.vertical,
					spacing = 8,
					{
						widget = wibox.widget.textclock,
						font = "Inconsolata 14",
						format = "%a%d",
						refresh = 61,
						halign = "center"
					},
					{
						widget = wibox.widget.textclock,
						font = "Inconsolata 18",
						format = "%H\n%M",
						refresh = 1,
						halign = "center"
					}
				}
			}
		}
	}
	month_calendar:attach( time, "br", {on_hover=true} )

	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)

	local layoutpopup = awful.popup {
		widget = wibox.widget {
			awful.widget.layoutlist {
				source      = awful.widget.layoutlist.source.default_layouts,
				style    = {
					shape_selected        = gears.shape.rounded_rect,
					bg_selected = beautiful.default_focus,
				},
				base_layout = wibox.widget {
					spacing         = 5,
					forced_num_cols = 2,
					layout          = wibox.layout.grid.vertical,
				},
				widget_template = {
					{
						{
							id            = 'icon_role',
							forced_height = 46,
							forced_width  = 46,
							widget        = wibox.widget.imagebox,
						},
						margins = 4,
						widget  = wibox.container.margin,
					},
					id              = 'background_role',
					forced_width    = 48,
					forced_height   = 48,
					shape           = gears.shape.rounded_rect,
					widget          = wibox.container.background,
				},
			},
			margins = 8,
			widget  = wibox.container.margin,
		},
		preferred_positions = 'left',
		preferred_anchors = 'middle',
		screen   = s,
		-- https://awesomewm.org/doc/api/classes/awful.popup.html#awful.popup.preferred_positions
		--preferred_positions = 'left',
		--preferred_anchors   = {'front', 'back'},
		border_color      = beautiful.border_focus,
		border_width      = beautiful.border_width,
		shape             = gears.shape.rounded_rect,
		hide_on_right_click = true,
		visible = false,
		--placement    = awful.placement.top_right,
		y = 40,
		x = s.geometry.width - 170,
		--s.geometries[c] = g
		ontop = true,
	}
	layoutpopup:bind_to_widget(s.mylayoutbox)

	s.mylayoutbox:buttons(awful.util.table.join(
	--awful.button({ }, 1, function () awful.layout.inc( 1) end),
	--awful.button({ }, 3, function () awful.layout.inc(-1) end),
	awful.button({ }, 4, function () 
		if not tagBlocked then
			awful.layout.inc( 1) 
		end
	end),
	awful.button({ }, 5, function () 
		if not tagBlocked then
			awful.layout.inc(-1) 
		end
	end)))

	-- Create a taglist widget
	--s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)
	set_taglist(s)

	-- Create a tasklist widget
	--s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)
	s.mytasklist = awful.widget.tasklist {
		screen   = s,
		filter   = awful.widget.tasklist.filter.currenttags,
		buttons  = tasklist_buttons,
		--style    = {
		--border_width = 1,
		--border_color = '#777777',
		--shape        = gears.shape.rounded_bar,
		--},
		layout   = {
			spacing = 8,
			layout  = wibox.layout.flex.horizontal
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{
							id     = 'icon_role',
							widget = wibox.widget.imagebox,
						},
						--margins = 4,
						left = 4,
						right = 6,
						widget  = wibox.container.margin,
					},
					{
						id     = 'text_role',
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left  = 4,
				right = 4,
				widget = wibox.container.margin
			},
			id     = 'background_role',
			widget = wibox.container.background,
			create_callback = function(self, client, index, objects)
				local tooltip = awful.tooltip({
					objects = { self },
					timer_function = function()
						return client.name .. " | " .. tostring(client.width) .. "x" .. tostring(client.height)
					end,
					delay_show = 0.1
				})
				-- Then you can set tooltip props if required
				tooltip.margins_leftright = 4
				tooltip.margins_topbottom = 8
			end
		},
	}

	s.mytasklist2 = awful.widget.tasklist {
		screen   = s,
		filter   = awful.widget.tasklist.filter.currenttags,
		buttons  = tasklist_buttons,
		layout   = {
			spacing = 10,
			layout  = wibox.layout.fixed.vertical
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{
							id     = 'icon_role',
							widget = wibox.widget.imagebox,
						},
						--margins = 4,
						left = 4,
						right = 6,
						widget  = wibox.container.margin,
					},
					--{
					--id     = 'text_role',
					--widget = wibox.widget.textbox,
					--},
					layout = wibox.layout.fixed.vertical,
				},
				top  = 4,
				bottom = 4,
				widget = wibox.container.margin
			},
			id     = 'background_role',
			widget = wibox.container.background,
			create_callback = function(self, client, index, objects)
				local tooltip = awful.tooltip({
					objects = { self },
					timer_function = function()
						return client.name .. " | " .. tostring(client.width) .. "x" .. tostring(client.height)
					end,
					delay_show = 0.1
				})
				-- Then you can set tooltip props if required
				tooltip.margins_leftright = 12
				tooltip.margins_topbottom = 4
			end
		},
	}
	-- Create the wibox
	--s.mywibox = awful.wibar({ 
	--position = "top", 
	--screen = s,
	--height = 28,
	--shape              = gears.shape.rounded_bar,
	--bg = beautiful.wibar_bg,
	--fg = beautiful.wibar_fg
	--})
	--
	-- Create the wibox
	s.mywibox2 = awful.wibar({ 
		position = "right", 
		screen = s,
		width = 40,
		--shape              = gears.shape.rounded_bar,
		bg = beautiful.wibar_bg,
		fg = beautiful.wibar_fg
	})
	s.mywibox2:setup {
		layout = wibox.layout.align.vertical,
		{   
			{ -- Left widgets
				layout = wibox.layout.fixed.vertical,
				spacing       = 4,
				{
					{
						wibox.widget {
							--smallspace,
							mylauncher,
							s.mylayoutbox,
							demoMode_widget,
							s.mypromptbox,
							--coffeebreak_widget,
							layout  = wibox.layout.fixed.vertical,
							spacing       = 2,
						},
						--shape        = gears.shape.rounded_bar,
						bg           = beautiful.taglist_bg_normal,
						fg           = beautiful.tasklist_fg_normal,
						widget       = wibox.container.background
					},
					left = 0,
					widget       = wibox.container.margin
				},
			},
			--s.mytaglist2,
			{
				taglist,
				widget = wibox.container.margin,
				margins = { top = 8, bottom = 8 },
			},
			spacing       = 2,
			layout        = wibox.layout.align.vertical
		},
		{
			s.mytasklist2, -- Middle widget
			widget = wibox.container.place,
			valign = "center",
			content_fill_horizontal = true,
		},
		-- Right widgets
		{ 
			layout = wibox.layout.fixed.vertical,
			spacing       = 2,
			{
				{
					wibox.widget {
						mpdarc_widget,
						volumearc_widget,
						batteryarc_widget,
						layout  = wibox.layout.fixed.vertical,
						spacing       = 8,
					},
					bg           = beautiful.taglist_bg_normal,
					fg           = beautiful.tasklist_fg_normal,
					widget       = wibox.container.background
				},
				top = 4,
				widget       = wibox.container.margin
			},
			tray,
			time,
		},
	}

end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
awful.button({ }, 3, function () mymainmenu:toggle() end),
awful.button({ }, 4, function() 
	if not tagBlocked then
		awful.tag.viewnext()
	end
end),
awful.button({ }, 5, function() 
	if not tagBlocked then
		awful.tag.viewprev()
	end
end)
))
-- }}}

-- {{{ Tag manipulation
local function delete_tag()
	local t = awful.screen.focused().selected_tag
	if not t then return end
	t:delete()
end

local function add_tag()
	foo = #awful.screen.focused().tags + 1
	awful.tag.add(foo .. "_term",
	{
		screen = awful.screen.focused(),
		layout = awful.layout.suit.max,
		volatile = true,
	}):view_only()
end

local function rename_tag()
	awful.prompt.run {
		prompt       = "New tag name: ",
		textbox      = awful.screen.focused().mypromptbox.widget,
		exe_callback = function(new_name)
			if not new_name or #new_name == 0 then return end

			local t = awful.screen.focused().selected_tag
			if t then
				t.name = new_name
			end
		end
	}
end

local function move_to_new_tag()
	local c = client.focus
	if not c then return end

	local t = awful.tag.add(c.class,{screen= c.screen })
	c:tags({t})
	t:view_only()
end

local function copy_tag()
	local t = awful.screen.focused().selected_tag
	if not t then return end

	local clients = t:clients()
	local t2 = awful.tag.add(t.name, awful.tag.getdata(t))
	t2:clients(clients)
	t2:view_only()
end

function find_empty_tag()
	local s = awful.screen.focused()
	--local next = next
	for i = 1, #s.tags do
		local tag = s.tags[i]
		if next(tag:clients()) == nil then return i end
	end
end

-- }}}

-- {{{ Key bindings

--local muttcommand = terminal .. " -e zsh -c \'echo -en \"\\e]1;mutt\\a\";echo -en \"\\e]2;mutt\\a\";echo -en \"\\e]0;mutt\\a\";sleep 0.05s; ".. multiplexer .. " -S mutt mutt -F .muttrc\'"
local muttcommand = terminal .. " -e zsh -c \'echo -en \"\\e]1;mutt\\a\";echo -en \"\\e]2;mutt\\a\";echo -en \"\\e]0;mutt\\a\";sleep 0.05s; screen -S mutt mutt -F .muttrc\'"
--local muttcommand = terminal .. " -e sleep 0.05s && mux mutt"
--local muttcommand = terminal .. " -e zsh -c \'echo -en \"\\e]1;mutt\\a\";echo -en \"\\e]2;mutt\\a\";echo -en \"\\e]0;mutt\\a\";sleep 0.05s; screen -c ~/.screen/mutt.screenrc"
--local muttcommand = "urxvt -e zsh -c \'echo -en \"\\e]1;mutt\\a\";echo -en \"\\e]2;mutt\\a\";echo -en \"\\e]0;mutt\\a\";sleep 0.05s; screen -S mutt mutt -F .muttrc\'"
--local muttcommand = "zenity --error --text=crontab-webmail"

globalkeys = awful.util.table.join(
awful.key({ modkey, "Control"   }, "s",      hotkeys_popup.show_help, {description="show help", group="awesome"}),
--awful.key({ modkey, "Control"   }, "x",       function() xrandr.xrandr() end, {description="show help", group="awesome"}),
-- {{{ Non-empty tag browsing
awful.key({ modkey,           }, "Prior",   awful.tag.viewprev, {description = "view previous", group = "tag"}),
awful.key({ modkey,           }, "Next",  awful.tag.viewnext, {description = "view next", group = "tag"}),

awful.key({ modkey,  }, "h", function () lain.util.tag_view_nonempty(-1) end, {description = "view previous nonempty", group = "tag"}),
awful.key({ modkey,  }, "l", function () lain.util.tag_view_nonempty(1) end, {description = "view next nonempty", group = "tag"}),
awful.key({ modkey,           }, "Left", function () lain.util.tag_view_nonempty(-1) end, {description = "view previous nonempty", group = "tag"}),
awful.key({ modkey,           }, "Right", function () lain.util.tag_view_nonempty(1) end, {description = "view next nonempty", group = "tag"}),
-- }}}
awful.key({ modkey,           }, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),

awful.key({ modkey, "Mod1"    }, "a", add_tag, {description = "add a tag", group = "tag"}),
--awful.key({ modkey, "Control" }, "a", move_to_new_tag, {description = "add a tag with the focused client", group = "tag"}),
--awful.key({ modkey, "Mod1"    }, "a", copy_tag, {description = "create a copy of the current tag", group = "tag"}),
awful.key({ modkey, "Mod1"    }, "d", delete_tag, {description = "delete the current tag", group = "tag"}),
awful.key({ modkey, "Mod1"    }, "r", rename_tag, {description = "rename the current tag", group = "tag"}),

awful.key({ modkey,           }, "=", function () awful.util.spawn("= --") end, {description = "Calc", group = "Calc"}),
--awful.key({ modkey, "Shift"   }, "p", function () awful.util.spawn("cours/home/raph/.scripts/rofi/rofi-notes/rofi_notes.sh") end, {description = "Notes", group = "Calc"}),
--awful.key({ modkey,  "Shift"  }, "p", function () awful.spawn.with_shell("/usr/bin/grep cours /home/raph/.fzf-marks | rofi -config ~/.config/rofi/config.rasi -dmenu -p Cours | cut -d ':' -f 2 | xargs --no-run-if-empty " .. terminal .. " -e ranger")       end), 
--
-- from terminal : cat ~/.fzf-marks | rofi -dmenu | sed "s_^.*: __" | xargs nemo
--awful.key({ modkey,  "Shift"  }, "p", function () awful.spawn.with_shell(terminal .. " -e ranger /home/raph/Responsabilités/MasterTRIED")       end), 
awful.key({ modkey,  }, "p", function () awesome.emit_signal("profile::control") end),
awful.key({ modkey, "Shift"   }, "p", function () awful.util.spawn("/home/raph/.scripts/rofi/rofi-fzf-marks.sh") end, {description = "FZF", group = "Calc"}),
awful.key({ "Mod1",  "Shift"  }, "p", function () awful.spawn.with_shell(terminal .. " -e ranger /home/raph/Responsabilités/MasterTRIED")       end), 
awful.key({ modkey, "Shift"   }, "=", function () awful.util.spawn("/home/raph/.scripts/rofi/rofi-notes/rofi_notes.sh") end, {description = "Notes", group = "Calc"}),
awful.key({                   }, "XF86AudioPrev", function () awful.util.spawn("mpc prev") end, {description = "Previous track", group = "Audio"}),
awful.key({                   }, "XF86AudioNext", function () awful.util.spawn("mpc next") end, {description = "Next track", group = "Audio"}),
awful.key({                   }, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end, {description = "Toggle mpc", group = "Audio"}),
awful.key({                   }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q -c 0 sset Master 2dB-") end, {description = "Lower volume", group = "Audio"}),
awful.key({                   }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q -c 0 sset Master 2dB+") end, {description = "Raise volume", group = "Audio"}),
awful.key({                   }, "XF86AudioMute", function () awful.util.spawn("amixer -q -c 0 sset Master toggle") end, {description = "Mute", group = "Audio"}),

awful.key({ "Mod1", "Shift" }, "a", function () awful.util.spawn("/home/raph/.config/rofi/applets/menu/backlight.sh") end, {description = "Mute", group = "helpers"}),
awful.key({ "Mod1", "Shift" }, "q", function () awful.util.spawn("/home/raph/.config/rofi/applets/menu/powermenu.sh") end, {description = "Mute", group = "helpers"}),
awful.key({ "Mod1", "Shift" }, "s", function () awful.util.spawn("/home/raph/.config/rofi/applets/menu/screenshot.sh") end, {description = "Mute", group = "helpers"}),
awful.key({ "Mod1", "Shift" }, "d", function () awful.util.spawn("/home/raph/.config/rofi/applets/menu/mpd.sh") end, {description = "Mute", group = "helpers"}),
awful.key({ "Mod1", "Shift" }, "w", function () awful.util.spawn("/home/raph/.config/rofi/applets/menu/volume.sh") end, {description = "Mute", group = "helpers"}),
--awful.key({ "Mod1", "Shift" }, "e", function () awful.util.spawn("zoomx") end, {description = "Mute", group = "helpers"}),

-- 0 for tag 10
awful.key({ modkey }, "à",
function ()
	local screen = awful.screen.focused()
	local tag = screen.tags[10]
	if tag then
		tag:view_only()
	end
end,
{description = "view tag 10", group = "tag"}),

awful.key({ modkey, "Shift" }, "à",
function ()
	if client.focus then
		local tag = client.focus.screen.tags[10]
		if tag then
			client.focus:move_to_tag(tag)
		end
	end
end,
{description = "move focused client to tag 10", group = "tag"}),

awful.key({ modkey }, "#49",
function ()
	local screen = awful.screen.focused()
	local tag = screen.tags[11]
	if tag then
		tag:view_only()
	end
end,
{description = "view tag 11", group = "tag"}),

awful.key({ modkey, "Shift" }, "#49",
function ()
	if client.focus then
		local tag = client.focus.screen.tags[11]
		if tag then
			client.focus:move_to_tag(tag)
		end
	end
end,
{description = "move focused client to tag 10", group = "tag"}),

awful.key({ modkey,           }, "j",
function ()
	awful.client.focus.byidx( 1)
end,
{description = "focus next by index", group = "client"}
),
awful.key({ modkey,           }, "k",
function ()
	awful.client.focus.byidx(-1)
end,
{description = "focus previous by index", group = "client"}
),
--awful.key({ modkey,           }, "w", function () mymainmenu:show() end, {description = "show main menu", group = "awesome"}),

awful.key({ modkey, "Ctrl" }, "w", function ()
	--awful.key({ "Mod1" }, "Escape", function ()
	-- If you want to always position the menu on the same place set coordinates
	awful.menu.menu_keys.down = { "Down", "Alt_L", "j" }
	awful.menu.clients({theme = { width = 450 }}, { keygrabber=true, coords={x=525, y=330} })
end),
--awful.key({ mod1,  }, "Tab", function () 
----tagpopup.tagpopup.margins.maintext.text = "bla"
--if testpopup.visible then 
--testpopup.visible = false 
--else testpopup.visible = true
--end
--end
--),

-- Layout manipulation
awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
{description = "swap with next client by index", group = "client"}),
awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
{description = "swap with previous client by index", group = "client"}),


awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
{description = "focus the next screen", group = "screen"}),
awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
{description = "focus the previous screen", group = "screen"}),

awful.key({ modkey, "Control" }, "l", function () mouse.coords { x = 185, y = 38, silent=true } end,{description = "remove cursor", group = "mouse"}),
awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
{description = "jump to urgent client", group = "client"}),
awful.key({ mod1,           }, "Tab", function () awful.spawn.with_shell("rofi -modi windowcd -show windowcd -kb-accept-entry '!Alt-Tab' -kb-row-down Alt-Tab,Down -kb-row-up Alt+Shift+Tab,Up") end),
awful.key({ modkey,           }, "Tab",
function ()
	awful.client.focus.history.previous()
	if client.focus then
		client.focus:raise()
	end
end,
{description = "go back", group = "client"}),

-- Standard program
awful.key({ modkey,           }, "x", function () awful.spawn(terminal) end, {description = "open a terminal", group = "launcher"}),
awful.key({ modkey,           }, "s", function () awful.spawn("urxvt") end, {description = "open urxvt terminal", group = "launcher"}),

awful.key({ modkey, "Shift" }, "s", function () sidebar.toggle() end, {description = "sidebar", group = "launcher"}),

awful.key({ modkey, "Shift"}, "Down",     function () awful.client.incwfact(-0.03)          end, {}),
awful.key({ modkey, "Shift"}, "Up",     function () awful.client.incwfact( 0.03)          end, {}),
--awful.key({ modkey, "Shift" }, "x", function () awful.spawn(terminal,false,function(c) awful.client.setslave(c) end) end, {description = "open a terminal SLAVE", group = "launcher"}),
awful.key({ modkey, "Shift" }, "x", function () awful.spawn("alacritty --class Alacritty-slave") end),
--awful.key({ modkey, "Shift" }, "x", function () awful.spawn(terminal .." -name slaveterm -title urxvt") end),
awful.key({ modkey, "Control" }, "r", awesome.restart, {description = "reload awesome", group = "awesome"}),
awful.key({ modkey, "Shift"}, "l",     function () awful.tag.incmwfact( 0.05)          end,
{description = "increase master width factor", group = "layout"}),

awful.key({ modkey, "Shift"}, "g",     function () awful.tag.setmwfact(0.5)          end,
{description = "decrease master width factor", group = "layout"}),
awful.key({ modkey, "Shift"}, "h",     function () awful.tag.incmwfact(-0.05)          end,
{description = "decrease master width factor", group = "layout"}),
awful.key({ modkey,           }, "n",     function () awful.tag.incnmaster( 1, nil, true) end,
{description = "increase the number of master clients", group = "layout"}),

--awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
--{description = "decrease the number of master clients", group = "layout"}),
awful.key({ modkey,           }, "p",  function () awful.tag.incnmaster(-1, nil, true) end, {description = "decrease the number of master clients", group = "layout"}),
awful.key({ modkey, "Control" }, "h",  function () awful.tag.incncol( 1, nil, true)    end, {description = "increase the number of columns", group = "layout"}),
awful.key({ modkey, "Control" }, "l",  function () awful.tag.incncol(-1, nil, true)    end, {description = "decrease the number of columns", group = "layout"}),

awful.key({ modkey,           }, "<", function () awful.layout.inc( 1)  end, {description = "select next", group = "layout"}),
--awful.key({ modkey, "Shift"   }, "<", function () awful.layout.inc(-1)  end),
awful.key({ modkey, "Shift"   }, "<", function () awful.spawn("find-cursor --color red --line-width 16")  end),
awful.key({ modkey,           }, "w", function () awful.layout.set(awful.layout.suit.max) end, {description = "Layout max", group = "layout"}),
awful.key({ modkey, "Shift"   }, "w", function () awful.layout.set(awful.layout.suit.tile) end, {description = "Layout tile", group = "layout"}),
--awful.key({ modkey, "Control" }, "<", function () systray.visible = not systray.visible end, {description = "Toggle systray visibility", group = "custom"}, {description = "select previous", group = "layout"}),


awful.key({ modkey, "Control" }, "n",
function ()
	local c = awful.client.restore()
	-- Focus restored client
	if c then
		client.focus = c
		c:raise()
	end
end,
{description = "restore minimized", group = "client"}),

-- scratchpads
-- poppin.pop(name, command, [position[, size[, properties[, callback]]]])
-- https://github.com/raksooo/poppin
awful.key({ modkey,           }, "z", function () poppin.pop("terminal", terminal, "center", 600) end),
awful.key({ modkey,           }, "a", function () poppin.pop("calc", terminal .. " -e sh -c 'echo \"---- eva ----\nprevious answer _\n\";eva'", "center", 600) end),
awful.key({ modkey, "Shift"   }, "z", function () poppin.pop("python", "kitty --name scratchpad -e python", "center", 600) end),
-- Prompt
awful.key({ modkey },            "Return",     function () awful.screen.focused().mypromptbox:run() end,
{description = "run prompt", group = "launcher"}),
--awful.key({ modkey,        }, "v", function () watson_shell.launch() end),
awful.key({ modkey,        }, "v", function () awful.util.spawn(terminal .." -e ".. editor .." -c SimplenoteList") end),
--awful.key({ modkey,           }, "d", function () awful.util.spawn("urxvt -e ncmpcpp") end, {description = "run ncmpcpp", group = "apps"}),
--awful.key({ modkey, "Shift" }, "d", function ()
--local matcher = function (c)
--return awful.rules.match(c, {name = "Rambox"})
--end
--awful.client.run_or_raise('rambox', matcher)
--end),
--awful.key({ modkey, }, "s", function ()
--local matcher = function (c)
--return awful.rules.match(c, {class = "calendar"})
--end
--awful.client.run_or_raise('vimb --class=calendar https://calendar.google.com/calendar/r/month', matcher)
--end),
--awful.key({ modkey, "Shift" }, "s", function ()
--local matcher = function (c)
--return awful.rules.match(c, {class = "todolist"})
--end
--awful.client.run_or_raise('vimb --class=todolist https://www.ticktick.com/', matcher)
--end),
awful.key({ modkey, }, "d", function ()
	local matcher = function (c)
		return awful.rules.match(c, {name = "ncmpcpp"})
	end
	--awful.client.run_or_raise("urxvt" .. ' -e ncmpcpp', matcher)
	awful.client.run_or_raise(terminal .. ' --class ncmpcpp -e ncmpcpp', matcher)
end),
--awful.key({ modkey, "Control" }, "d", function () awful.util.spawn("kmag") end),
awful.key({ modkey, "Control"}, "d", function () awesome.emit_signal("demomode::toggle") end),
awful.key({ modkey, "Control"}, "f", function ()
	local matcher = function (c)
		return awful.rules.match(c, {class = "kmag"})
	end
	awful.client.run_or_raise('kmag', matcher)
end),
awful.key({ modkey, "Shift"}, "q", function ()
	local matcher = function (c)
		return awful.rules.match(c, {name = "icktick"})
	end
	awful.client.run_or_raise('icktick', matcher)
end),
awful.key({ modkey, }, "e", function () awful.util.spawn(terminal .." --class ranger -e ranger") end),
awful.key({ modkey, "Shift" }, "d", function () awful.spawn.with_shell("mpc lsplaylists| rofi -config ~/.config/rofi/config.rasi -dmenu -p \"Choose playlist\" | xargs --no-run-if-empty /home/raph/.scripts/mpc-startPlaylist.sh") end),
awful.key({ modkey, "Shift" }, "e", function () awful.util.spawn("nemo") end, {description = "run pcmanfm", group = "apps"}),
--awful.key({ modkey,           }, "e", function () awful.util.spawn("thunar") end, {description = "run pcmanfm", group = "apps"}),
--awful.key({ modkey,           }, "w", function () awful.util.spawn("firefox") end, {description = "run firefox", group = "apps"}),

--awful.key({ modkey, }, "w", function ()
--local matcher = function (c)
--return awful.rules.match(c, {class = 'firefox'})
--end
--awful.client.run_or_raise('firefox', matcher)
--end),

--
--awful.key({ modkey,           }, "c", function () awful.util.spawn("urxvt -e neomutt -F .muttrc") end, {description = "run mutt", group = "apps"}),
--awful.key({ modkey,           }, "c", function () awful.util.with_shell("urxvt -e zsh -c \"sleep 0.1s ; screen -S mutt mutt -F .muttrc\"", {tag = "mail"}) end, {description = "run mutt", group = "apps"}),
awful.key({ modkey,           }, "c", function () 
	if not naughty.is_suspended() then
		awful.screen.focus(1)
		awful.tag.viewonly(awful.tag.find_by_name(screen[1], "mail"))
		awful.util.spawn(muttcommand, {tag = "mail"}) 
	end
end, {description = "run mutt", group = "apps"}),

--awful.key({ modkey,           }, "w", function () awful.util.spawn("surf https://calendar.google.com/calendar") end, --{description = "agenda", group = "apps"}),
--awful.key({ modkey, "Shift" }, "w", function () awful.util.spawn("surf https://ticktick.com/") end, --{description = "ticktick", group = "apps"}),

--awful.key({ modkey, "Control" }, "a", function () awful.util.spawn("xscreensaver-command -lock")   end, {description = "lock screen", group = "apps"}),
awful.key({ modkey, "Control" }, "a", function () awful.util.spawn(SCREENLOCK_COMMAND) end, {description = "lock screen", group = "apps"}),
-- 

--awful.key({ modkey,           }, "<", function () dmenuhelpers.run()       end,{description = "run", group = "launcher"}), 
awful.key({ modkey,   }, "q", function () awful.util.spawn("rofi-mpc -config ~/.config/rofi/config.rasi ")       end,{description = "rofi-mpc", group = "launcher"}), 
--awful.key({ modkey,  "Shift"  }, "w", function () awful.spawn.with_shell("/usr/bin/cat /home/raph/.fzf-marks | rofi -config ~/.config/rofi/config -dmenu -p ranger-marks | cut -d ':' -f 2 | xargs --no-run-if-empty " .. terminal .. "-e ranger")       end), 
--awful.key({ modkey,           }, "space", function () awful.util.spawn("rofi -config ~/.config/rofi/config -show combi -combi-modi \"window,run,snippet\" -modi combi,snippet:/home/raph/Code/langageBash/rofi-modi-snippets/snippets.sh,calc,emoji,fileb_:/usr/share/doc/rofi/examples/rofi-file-browser.sh,top,ssh")       end,{description = "run", group = "launcher"}), 
awful.key({ modkey,           }, "space", function () awful.util.spawn("rofi -config ~/.config/rofi/config.rasi -show combi -combi-modi \"window,run\" -modi combi,xr:/home/raph/Code/langageBash/rofi-modi-autorandr.sh,ssh,clip:\"greenclip print\",emoji:~/.scripts/rofiemoji/rofiemoji.sh,snip:/home/raph/Code/langageBash/rofi-modi-snippets/snippets.sh,calc")       end,{description = "run", group = "launcher"}), 
--awful.key({ modkey,           }, "b", function () awful.util.spawn("rofi -modi \"file:./scripts/rofi/rofi-file-browser.sh\" -show file")       end,{description = "run", group = "launcher"}), 
awful.key({ modkey, "Shift" }, "b", function () awesome.emit_signal("show::tray") end, {description = "toggle tray", group = "awesome"}),
awful.key({ modkey }, "b", function ()
	for s in screen do
		s.mywibox2.visible = not s.mywibox2.visible
	end
end,
{description = "toggle wibox", group = "awesome"}),
awful.key({ modkey, "Shift" }, "space",     function () awful.util.spawn("rofi-pass")             end),
--
awful.key({ modkey }, "r",
function ()
	awful.prompt.run {
		prompt       = "Run Lua code: ",
		textbox      = awful.screen.focused().mypromptbox.widget,
		exe_callback = awful.util.eval,
		history_path = awful.util.get_cache_dir() .. "/history_eval"
	}
end,
{description = "lua execute prompt", group = "awesome"}),
-- Menubar
awful.key({ modkey, "Control" }, "p", function() menubar.show() end, {description = "show the menubar", group = "launcher"})
)

clientkeys = awful.util.table.join(
awful.key({ modkey,           }, "f",
function (c)
	c.fullscreen = not c.fullscreen
	c:raise()
end,
{description = "toggle fullscreen", group = "client"}),

awful.key({ modkey, "Shift"   }, "c", 
function (c) 
	c:kill()
end, 
{description = "close", group = "client"}),

awful.key({ modkey, "Shift"}, "a", function (c) 
	rofi.client_flags(c)
	--naughty.notify{ 
	--title= "debug",
	--text = " coucou "..tostring(c.screen.geometry.height).."-"..tostring(c.screen.index)
	--}
end),
awful.key({ modkey, "Shift"}, "i", 
function (c)   
	naughty.notify{ 
		title= "debug",
		text = 'This notification has actions!',
		actions = {
			naughty.action {
				name = 'Accept',
			},
			naughty.action {
				name = 'Refuse',
			},
			naughty.action {
				name = 'Ignore',
			},
		}
	}
end),
awful.key({ modkey, "Shift" }, "f", 
function (c)   
	c.floating = not c.floating
	c.width = c.screen.geometry.width*3/5
	c.x = c.screen.geometry.x+(c.screen.geometry.width/5)
	c.height = c.screen.geometry.height * 0.93
	c.y = c.screen.geometry.y+c.screen.geometry.height* 0.04
	--naughty.notify{ 
	--title= "debug",
	--text = tostring(c.screen.geometry.height).."-"..tostring(c.screen.index)
	--}
end),
--awful.key({ modkey, "Shift" }, "g", 
--function (c)   
--c.setwfact(5)
--end),
--awful.key({ modkey, "Control" }, "<",  awful.client.floating.toggle                     , {description = "toggle floating", group = "client"}),
--
-- BLING TABS
awful.key( {mod1, "Shift"}, "t", function() bling.module.tabbed.pick() end, { description = "Add tab to tabbing group", group = "User" }),
awful.key( {mod1, "Shift"}, "r", function() bling.module.tabbed.pop() end, {description = "Remove tab from tabbing group", group = "User"}),
-- END

--
awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, {description = "move to master", group = "client"}),
awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end, {description = "move to screen", group = "client"}),
awful.key({ modkey, "Shift"   }, "o",  
function (c) 
	c:tags(c.original_tags)          
	c.screen = c.original_screen
end, 
{description = "restore tags", group = "client"}),
awful.key({ modkey, "Control"   }, "o",  
function (c) 
	awful.rules.apply(c)
end, 
{description = "rules on the client", group = "client"}),
awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end, {description = "toggle keep on top", group = "client"}),
awful.key({ modkey,  "Shift"  }, "t",      awful.client.floating.toggle                     , {description = "toggle floating", group = "client"}),
awful.key({ modkey,  "Control"  }, "m",
function ()
	for _, c in ipairs(mouse.screen.selected_tag:clients()) do
		if c ~= client.focus then
			c.minimized = true
		end
	end
end ,
{description = "minimize all but focused", group = "client"}),
awful.key({ modkey,  "Shift"  }, "m",
function (c)
	-- The client currently has the input focus, so it cannot be
	-- minimized, since minimized clients can't have the focus.
	-- Restore with Mod Control n
	c.minimized = true
end ,
{description = "minimize", group = "client"}),
awful.key({ modkey,           }, "m",
function (c)
	c.maximized = not c.maximized
	c:raise()
end ,
{description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
	globalkeys = awful.util.table.join(globalkeys,
	-- View tag only.
	awful.key({ modkey }, "#" .. i + 9,
	function ()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			tag:view_only()
		end
	end,
	{description = "view tag #"..i, group = "tag"}),
	-- Toggle tag display.
	awful.key({ modkey, "Control" }, "#" .. i + 9,
	function ()
		local screen = awful.screen.focused()
		local tag = screen.tags[i]
		if tag then
			awful.tag.viewtoggle(tag)
		end
	end,
	{description = "toggle tag #" .. i, group = "tag"}),
	-- Move client to tag.
	awful.key({ modkey, "Shift" }, "#" .. i + 9,
	function ()
		if client.focus then
			local tag = client.focus.screen.tags[i]
			if tag then
				client.focus:move_to_tag(tag)
			end
		end
	end,
	{description = "move focused client to tag #"..i, group = "tag"}),
	-- Toggle tag on focused client.
	awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
	function ()
		if client.focus then
			local tag = client.focus.screen.tags[i]
			if tag then
				client.focus:toggle_tag(tag)
			end
		end
	end,
	{description = "toggle focused client on tag #" .. i, group = "tag"})
	)
end

clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
awful.button({ modkey }, 1, awful.mouse.client.move),
awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
	properties = { border_width = beautiful.border_width,
	border_color = beautiful.border_normal,
	focus = awful.client.focus.filter,
	raise = true,
	keys = clientkeys,
	size_hints_honor = false,
	buttons = clientbuttons,
	screen = awful.screen.preferred,
	placement = awful.placement.no_overlap+awful.placement.no_offscreen
}
	},
	-- get the name of the created windows/clients
	--{rule = {}, callback = function(c) naughty.notification{ title="new window", text = c.name } end },

	-- Floating clients.
	{ rule_any = {
		instance = {
			"DTA",  -- Firefox addon DownThemAll.
			"copyq",  -- Includes session name in class.
			"scratch",  -- Includes session name in class.
		},
		class = {
			"Gpick",
			"Kruler",
			"MessageWin",  -- kalarm.
			"Sxiv",
			"Audacious",
			"Wpa_gui",
			"pinentry",
			"veromix",
			"xtightvncviewer"},

			name = {
				"Event Tester",  -- xev.
			},
			role = {
				"AlarmWindow",  -- Thunderbird's calendar.
				"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
			}
		}, properties = { floating = true }},

		-- Zoom
		{ rule_any = { class = { "zoom"},
		except = { name = "Zoom Meeting"}, }, 
		properties = {screen = screen:count(), tag = "im",  above = false, floating = true, focus = false}
	},
	{ rule = { name = "Zoom Meeting" }, properties = { screen = screen:count(), tag = "im", floating = false} },

	--{ rule = { class = "zoom", name = "Meeting Chat" }, properties = { screen = screen:count(), tag = "im"}}, 

	-- Add titlebars to normal clients and dialogs
	--{ rule_any = {type = { "normal", "dialog" }
	--}, properties = { titlebars_enabled = true }
	--},

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- WM_CLASS(STRING) = "messagingFF", "firefox" : instance, class
	-- set INSTANCE with xdotool selectwindow set_window --classname "messagingFF"
	--
	{ rule = { class = "firefox" }, except = { instance = "messagingFF" }, properties = { screen = 1, tag = "web" } },
	{ rule = { instance = "messagingFF" }, properties = { screen = screen:count(), tag = "im", focus = false} },

	{ rule = { instance = "Alacritty-slave" },
	callback = function(c)
		awful.client.setslave(c)
	end },
	{ rule = { instance = "slave" },  
	callback = function(c)
		awful.client.setslave(c)
	end },
	{ rule = { instance = "tzclock" },
	properties = { screen = screen:count(), tag = "media", switchtotag = false, focus = false, floating = false, border_width = 0 } },
	{ rule = { name = "drawin" },
	properties = { focus = false } },
	{ rule = { name = "Jerry" },
	properties = { screen = 1, tag = "term2" } },
	{ rule = { class = "Opera" },
	properties = { screen = 1, tag = "web" } },
	{ rule = { name = "screen" },
	properties = { screen = 1, tag = "work" } },
	{ rule = { name = "mutt" },
	properties = { screen = 1, tag = "mail", switchtotag = true } },
	{ rule = { instance = "microsoft teams" }, properties = { screen = screen:count(), tag = "im", focus = false} },
	{ rule = { instance = "teams-for-linux" }, properties = { screen = screen:count(), tag = "im", focus = false} },
	{ rule = { name = "Signal" },
	properties = { screen = screen:count(), tag = "im"} },
	{ rule = { instance = "biscuit" },
	properties = { screen = screen:count(), tag = "im"} },
	{ rule = { name = "Ferdi" },
	properties = { screen = screen:count(), tag = "im"} },
	{ rule = { name = "zihap" },
	properties = { screen = screen:count(), tag = "im"} },
	{ rule = { name = "Rambox" },
	properties = { screen = screen:count(), tag = "im"} },
	{ rule = { name = "Franz" },
	properties = { screen = screen:count(), tag = "im"} },
	{ rule = { name = "FreeCAD" },
	properties = { screen = 1, tag = "root", switchtotag = false  } },
	{ rule = { name = "Eclipse" },
	properties = { screen = 1, tag = "work", switchtotag = false  } },
	{ rule = { name = "Sonata" },
	properties = { screen = screen:count(), tag = "media", switchtotag = true  } },
	{ rule = { instance = "ncmpcpp" },
	properties = { screen = screen:count(), tag = "media", switchtotag = true  } },
	{ rule = { class = "Acroread" },
	properties = { tag = "pdf", switchtotag = true } },
	{ rule = { class = "Epdfview" },
	properties = { tag = "pdf", switchtotag = true } },
	{ rule = { class = "okular" },
	properties = { tag = "pdf", switchtotag = true } },
	{ rule = { class = "Evince" },
	properties = { tag = "pdf", switchtotag = true } },
	{ rule = { class = "Zathura" },
	properties = { tag = "pdf", switchtotag = true } },
	{ rule = { class = "Xephyr" },
	properties = { placement = awful.placement.centered }},
	{ rule = { instance = "floating" },
	properties = { floating = true, placement = awful.placement.centered }},
	{ rule = { instance = "tzclock" },
	properties = { floating = true, switchtotag = true, placement = awful.placement.centered }},
	{ rule = { class = "kmag" },
	properties = { floating = true, geometry = { height=360, width=600 }, placement = awful.placement.next_to_mouse }},
	{ rule = { class = "Xsane", name = "Information" },
	properties = { floating = true, geometry = { height=200, width=300 } }},
	{ rule = { class = "Zathura", name = "Imprimer" },
	properties = { floating = false }},
	{ rule = { class = "QtPass" }, properties = { 
		floating = true, screen = 1, tag = "web", geometry = { height=600, width=800 },
	} },
	--c.floating = not c.floating
	--c.width = c.screen.geometry.width*3/5
	--c.x = c.screen.geometry.x+(c.screen.geometry.width/5)
	--c.height = c.screen.geometry.height * 0.93
	--c.y = c.screen.geometry.height* 0.04
	{ rule = { class = "Alarm-clock" }, properties = { floating = true } },
	{ rule = { instance = "libreoffice" }, properties = { tag = "pdf", maximized = false, switchtotag = true } },
	{ rule = { name = "alsamixer" }, properties = { screen = 1, tag = "root", switchtotag = true } },
	{ rule = { class = "communications" }, properties = { screen = screen:count(),tag = "im"} },
	--{ rule = { class = "calendar" }, properties = { screen = screen:count(),tag = "todo",switchtotag=true, maximized = false} },
	{ rule = { class = "gnome-calendar" }, properties = { maximized = false} },
	{ rule = { class = "wordreference" }, properties = { screen = screen:count(),tag = "todo",switchtotag=true,maximized=false} },
	{ rule = { class = "todolist" }, properties = { screen = screen:count(),tag = "todo",switchtotag=true, maximized = false} },
	{ rule = { instance = "watson" }, properties = { screen = screen:count(),tag = "todo",switchtotag=true,maximized=false} },
	{ rule = { class = "code-oss" }, properties = { screen = 1, tag = "work", switchtotag = true } },
	{ rule = { instance = "rootterm" }, properties = { screen = 1, tag = "root", switchtotag = true } },
	{ rule = { class = "Deluge" },
	properties = { screen = screen:count(), tag = "media" } },
	--{ rule = { class = "Homebank" },
	--properties = { screen = screen:count(), tag = "media", switchtotag = true} },
	{ rule = { instance = "ticktick", }, -- ça marche avec l'extension tirée de Firefox
	properties = { screen = screen:count(), tag = "todo"} },
	{ rule = { name = "ticktick", }, -- ça marche avec l'extension tirée de Firefox
	properties = { screen = screen:count(), tag = "todo"} },
	{ rule = { class = "ticktick-" },
	properties = { screen = screen:count(), tag = "todo"} },
	{ rule = { class = "Slack" },
	properties = { screen = screen:count(), tag = "im"} },
	{ rule = { class = "Morgen" },
	properties = { screen = screen:count(), tag = "todo"} },
	{ rule = { class = "yakyak" },
	properties = { screen = screen:count(), tag = "im"} },
	{ rule = { class = "Chromium" },
	properties = { screen = 1, tag = "web", switchtotag = true} },
	{ rule = { class = "Surf" },
	properties = { screen = 1, tag = "term", floating = false, switchtotag = true } },
	{ rule = { class = "Pavucontrol" },
	properties = { screen =screen:count(), tag = "media", floating = false, switchtotag = true } },
	{ rule = { class = "Spotify" },
	properties = { screen =screen:count(), tag = "media" } },
	{ rule = { class = "Scribus" },
	properties = { screen = 1, tag = "graph" } },
	{ rule = { class = "Gorilla" },
	properties = { screen = 1, tag = "graph", switchtotag = true, floating = true } },
	{ rule = { class = "Inkscape" },
	properties = { screen = 1, tag = "graph", maximized = false } },
	{ rule = { class = "Pinentry" },
	properties = { floating = true } },
	{ rule = { class = "Openshot" },
	properties = { screen = 1, tag = "graph", floating = false } },
	{ rule = { class = "xpad" },
	properties = { floating = true, skip_taskbar = true } },
	{ rule = { class = "mpv" },
	properties = { floating = true, skip_taskbar = true } },
	{ rule = { class = "Gimp" },
	properties = { screen = 1, tag = "graph", floating = false, maximized = false } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	--if slave then awful.client.setslave(c) end

	-- Coins arrondis pour les fenêtres
	--if not c.fullscreen then
	--c.shape = function(cr,w,h)
	--gears.shape.rounded_rect(cr,w,h,20)
	--end
	--end


	if awesome.startup and
		not c.size_hints.user_position
		and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end

	c.original_tags = c:tags()
	c.original_screen = c.screen
end)

-- Notify me of applications started on other tags
client.connect_signal("manage", function(c)
	local currentTag = awful.tag.selected(1).name
	local clientTag = c.first_tag.name
	local clientScreen = tostring(c.first_tag.screen.index)
	if (clientTag ~= currentTag) and not awesome.startup then
		naughty.notification({title = (c.name or "Application") .. " started", text = "screen: " .. clientScreen .. "\ntag:    " .. clientTag, width=300, height=100})
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
	-- buttons for the titlebar
	local buttons = awful.util.table.join(
	awful.button({ }, 1, function()
		client.focus = c
		c:raise()
		awful.mouse.client.move(c)
	end),
	awful.button({ }, 3, function()
		client.focus = c
		c:raise()
		awful.mouse.client.resize(c)
	end)
	)

	awful.titlebar(c) : setup {
		{ -- Left
			awful.titlebar.widget.iconwidget(c),
			buttons = buttons,
			layout  = wibox.layout.fixed.horizontal
		},
		{ -- Middle
			{ -- Title
				align  = "center",
				widget = awful.titlebar.widget.titlewidget(c)
			},
			buttons = buttons,
			layout  = wibox.layout.flex.horizontal
		},
		{ -- Right
			awful.titlebar.widget.floatingbutton (c),
			awful.titlebar.widget.maximizedbutton(c),
			awful.titlebar.widget.stickybutton   (c),
			awful.titlebar.widget.ontopbutton    (c),
			awful.titlebar.widget.closebutton    (c),
			layout = wibox.layout.fixed.horizontal()
		},
		layout = wibox.layout.align.horizontal
	}
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
	if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
		and awful.client.focus.filter(c) then
		client.focus = c
	end
end)

client.connect_signal("focus", function(c) 
	c.border_color = beautiful.border_focus 
	c.opacity = 1
end)

client.connect_signal("unfocus", function(c) 
	c.border_color = beautiful.border_normal 
	c.opacity = 0.7
end)

--{{{ Spin up the startup functions
--awful.util.spawn_with_shell(setReminders())
awful.spawn.with_shell("~/.scripts/nitrogen-restore.sh")
--}}}
screen.connect_signal("list", awesome.restart)
-- }}}

-- vim: set fdm=marker fmr={{{,}}} fdl=0:fdc=2
