os.setlocale( os.getenv( 'LANG' ), 'time' )
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
require("collision")()
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty       = require("naughty")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local dmenuhelpers  = require("dmenu-helpers")
local vicious       = require("vicious")
local lain          = require("lain")
local notify          = require("notify.notify")
local xrandr = require("xrandr")
local treetile = require("treetile")
local poppin = require('poppin')

local batteryarc_widget = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local pomodoroarc_widget = require("awesome-wm-widgets.pomodoroarc-widget.pomodoroarc")
local watsonarc_widget = require("awesome-wm-widgets.watsonarc-widget.watsonarc")
local watson_shell = require("awesome-wm-widgets.watson-shell.watson-shell")
local demoMode_widget = require("awesome-wm-widgets.demoMode-widget.demomode")

local mpd_widget = require("awesome-wm-widgets.mpd-widget.mpd")
local mpdarc_widget = require("awesome-wm-widgets.mpdarc-widget.mpdarc")

require("naughtydefaults")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
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

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         --text = textwrap(tostring(err)) })
                         text = textwrap(tostring(err)) })
        in_error = false
    end)
end
-- }}}

-------------------------
--  Change config set  --
-------------------------
function change_config_set(name)
	update_cmd = "cat " .. config_file .. " | sed 's/.*/require(\""..name.."\")/g' | tee " .. config_file
	notify{ text = update_cmd }
	awful.spawn.easy_async_with_shell(update_cmd, function ()
		awesome.restart()
	end)
end

-- configset 
configsets = {
	{ "Basic", function () change_config_set("basic") end },
	{ "Guns girl", function () change_config_set("ggz") end },
	{ "Friendly", function () change_config_set("friendly") end },
	{ "Default", function () change_config_set("default") end }
} -- config set








-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(awful.util.getdir("config") .. "/themes/myxresources/theme.lua")
beautiful.init(awful.util.getdir("config") .. "/themes/myzenburn/theme.lua")
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
terminal = "kitty"
--terminal = "urxvtc"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

treetile.focusnew = true 
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

--local toto = awful.keygrabber {
    --keybindings = {
        --{{'Mod1'         }, 'Tab', awful.client.focus.history.select_previous},
        --{{'Mod1', 'Shift'}, 'Tab', awful.client.focus.history.select_next    },
    --},
    ---- Note that it is using the key name and not the modifier name.
    --stop_key           = 'Mod1',
    --stop_event         = 'release',
    --start_callback     = awful.client.focus.history.disable_tracking,
    --stop_callback      = awful.client.focus.history.enable_tracking,
    --export_keybindings = true,
--}

--toto:run()


-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.tile, 
    awful.layout.suit.tile.bottom, 
    awful.layout.suit.floating, 
    awful.layout.suit.max, 
    --awful.layout.suit.corner.nw,
    --awful.layout.suit.spiral,
    --lain.layout.termfair.center,

    --awful.layout.suit.tile.left, 
    --awful.layout.suit.tile.top, 
    --awful.layout.suit.fair, 
    --awful.layout.suit.max.fullscreen, 
    --awful.layout.suit.corner.nw,
    --treetile,
    --awful.layout.suit.floating,
    --awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
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

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
   { "set config", configsets },
                                    { "coffee break", function() awful.util.spawn("xscreensaver-command -lock") end },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
smallspace = wibox.widget.textbox()
smallspace:set_text(' ')
smallspace.font = "Play 10"

space = wibox.widget.textbox()
space:set_text(' ')
mytextclock = wibox.widget.textclock("%a %d %H:%M")

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
styles.normal  = { shape    = rounded_shape(5) }
styles.focus   = { fg_color = beautiful.fg_focus or '#000000',
                   bg_color = beautiful.border_focus or '#ff9800',
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
                   shape    = rounded_shape(5, true)
}
styles.header  = { fg_color = beautiful.fg_normal,
                   bg_color = beautiful.border_focus or '#ff9800',
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
  --opacity=50,
--font
--spacing
--margin
  week_numbers=true,
  start_sunday=false,
  long_weekdays=false,
  style_month=styles.month,
	style_header=styles.header,
	style_weekday=styles.weekday,
	style_weeknumber=styles.weeknumber,
	style_normal=styles.normal,
	style_focus=styles.focus,
})
month_calendar:attach( mytextclock, "tr", {on_hover=true} )


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
volumewidget = wibox.widget.textbox()
volumewidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q -c 1 sset Master toggle", false) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q -c 0 sset Master 2dB+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q -c 0 sset Master 2dB-", false) end),
    awful.button({ }, 3, function () awful.util.spawn("pavucontrol", false) end)
    --awful.button({ }, 2, function () awful.util.spawn("".. terminal.. " -e alsamixer", true) end)
))
vicious.register(volumewidget, vicious.widgets.volume, "$1%",1,"Master")
batwidget = wibox.widget.textbox()
vicious.register(batwidget, vicious.widgets.bat,
function(widget, args)
    if args[2]<=10 then
        return red .. args[1].. args[2] .."%" .. coldef 
    end
    if args[2]>10 and args[2]<24 then
        return orange .. args[1] .. args[2] .. "%" .. coldef 
    else
        return white .. args[1] .. args[2] .. "%" .. coldef
    end
end, 61, "BAT0")

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
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 2, function(t) naughty.notify{ title="tag debug", text = t.name } end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

testpopup = awful.popup {
  widget = awful.widget.tasklist {
    hide_on_right_click = true,
    screen   = screen[1],
    filter   = awful.widget.tasklist.filter.allscreen,
    buttons  = alttabpopup_buttons,
    style    = {
      shape = gears.shape.rounded_rect,
    },
    layout   = {
      spacing = 5,
      forced_num_rows = 1,
      layout = wibox.layout.grid.horizontal
    },
    widget_template = {
            {
                {
										id     = 'clienticon',
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
  ontop        = true,
  placement    = awful.placement.centered,
  shape        = gears.shape.rounded_rect,
  visible      = false,
}

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
                     awful.button({ }, 2, function (c) c:kill() end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))
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
                                              testpopup.visible = false
                                          end),
                     awful.button({ }, 2, function (c) c:kill() end),
                     --awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
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
        },
        widget_template = 
        {
          {
            {
              {
                {
                  id     = 'icon_role',
                  widget = wibox.widget.imagebox,
                },
                margins = 2,
                widget  = wibox.container.margin,
              },
              widget = wibox.container.background,
            },
            left  = 8,
            right = 8,
            widget = wibox.container.margin
          },
          id     = 'background_role',
          widget = wibox.container.background,
          create_callback = function(self, tag, index, objects)
            local tooltip = awful.tooltip({
                objects = { self },
                timer_function = function()
                  return tag.index .. ": " .. tag.name .. " | " .. tag.layout.name
                end,
                delay_show = 0.6
              })
            -- Then you can set tooltip props if required
            tooltip.margins_leftright = 8
            tooltip.margins_topbottom = 4
          end
          },
        buttons = taglist_buttons
      },
      shape        = gears.shape.rounded_bar,
      bg           = beautiful.tasklist_bg_normal,
      fg           = beautiful.tasklist_fg_normal,
      widget = wibox.container.background,
    },
    right =8,
    widget = wibox.container.margin
  }
end

----local myclock_t = awful.tooltip {margins = 14 }

----myclock_t:add_to_object(s.mytaglist)

----s.mytaglist:connect_signal('mouse::enter', function()
    ----myclock_t.text = os.date('Today is %A %B %d %Y\nThe time is %T')
----end)

--end


-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

local systray = wibox.widget.systray()
systray.opacity = 0.1
systray.visible = true
--systray.forced_width = 150

awful.screen.connect_for_each_screen(function(s)
    -- on enlève ce padding moche
    awful.screen.padding(s,0)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    --awful.tag(
      --{"work",
        --"web",
        --"mail",
        --"im",
        --"media",
        --"pdf",
        --"graph",
        --"root",
        --"term"
      --},
      --s,
      -- {awful.layout.layouts[9],
        --awful.layout.layouts[9],
        --awful.layout.layouts[9],
        --awful.layout.layouts[9],
        --awful.layout.layouts[9],
        --awful.layout.layouts[9],
        --awful.layout.layouts[3],
        --awful.layout.layouts[9],
        --awful.layout.layouts[9],
--})
--
   if s.index == 1 then
    awful.tag.add("work", {
				icon = beautiful.tag_icon_term,
        layout             = awful.layout.suit.max,
        --gap_single_client  = true,
        --gap                = 15,
        screen             = 1,
        selected           = true,
      })

    awful.tag.add("web", {
        icon = beautiful.tag_icon_web,
        --layout = awful.layout.suit.max,
        layout = awful.layout.suit.tile.bottom,
        --master_fill_policy = "master_width_factor",
        master_width_factor = 0.75,
        screen = 1,
      })

    awful.tag.add("mail", {
        icon = beautiful.tag_icon_mail,
        layout = awful.layout.suit.max,
        --master_fill_policy = "master_width_factor",
        screen = 1,
      })
  end
  if s.index == screen:count() then
    awful.tag.add("im", {
        icon = beautiful.tag_icon_im,
        layout = awful.layout.suit.max,
        screen = screen:count(),
        selected = true,
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
        master_fill_policy = "master_width_factor",
        master_width_factor = 0.66,
        screen = screen:count(),
      })
  end

    awful.tag.add("pdf", {
        icon = beautiful.tag_icon_pdf,
        layout = awful.layout.suit.max,
        master_fill_policy = "master_width_factor",
        screen = screen:count(),
      })
  end


  if s.index == 1 then
    awful.tag.add("graph", {
        icon = beautiful.tag_icon_graph,
        layout = awful.layout.suit.tile,
        master_fill_policy = "master_width_factor",
        screen = 1,
      })

    awful.tag.add("root", {
        icon = beautiful.tag_icon_root,
        layout = awful.layout.suit.max,
        master_fill_policy = "master_width_factor",
        screen = 1,
      })

    awful.tag.add("term2", {
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

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    s.screencount = wibox.widget.textbox()
    s.screencount:set_text(s.index .. "/" .. screen:count())

		--local coffeebreak_widget = wibox.widget {
			--image  = beautiful.coffee,
			--resize = true,
			--widget = wibox.widget.imagebox
		--}
    --coffeebreak_widget:buttons(awful.util.table.join(
                           --awful.button({ }, 1, function () awful.util.spawn("xscreensaver-command -lock")   end)
                           --))
		
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)

    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

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
                    margins = 2,
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
                  return client.name
                end,
								delay_show = 0.6
              })
            -- Then you can set tooltip props if required
            tooltip.margins_leftright = 8
            tooltip.margins_topbottom = 4
          end
    },
}
    -- Create the wibox
		s.mywibox = awful.wibar({ 
				position = "top", 
				screen = s,
				shape              = gears.shape.rounded_bar,
				bg = beautiful.wibar_bg,
				fg = beautiful.wibar_fg
			})

		-- Add widgets to the wibox
		s.mywibox:setup {
			layout = wibox.layout.align.horizontal,
      {   
        { -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          spacing       = 4,
          {
            wibox.widget {
              smallspace,
              mylauncher,
              s.mylayoutbox,
              demoMode_widget,
              s.mypromptbox,
          --coffeebreak_widget,
              layout  = wibox.layout.fixed.horizontal,
              spacing       = 4,
            },
            shape        = gears.shape.rounded_bar,
            bg           = beautiful.tasklist_bg_normal,
            fg           = beautiful.tasklist_fg_normal,
            widget       = wibox.container.background
          },
          s.mytaglist,
        },
        spacing       = 4,
        layout        = wibox.layout.fixed.horizontal
      },
			s.mytasklist, -- Middle widget
			{ -- Right widgets
        layout = wibox.layout.fixed.horizontal,
        spacing       = 4,
				--space,
				--volumewidget,
				--batwidget,
				--space,
				--space,
				--mpd_widget, 
				--space,
				--mpdarc_widget,      smallspace,
				--volumearc_widget,   smallspace,
				--pomodoroarc_widget, smallspace,
				--watsonarc_widget,   smallspace,
				--batteryarc_widget,  smallspace,
        {
          {
            wibox.widget {
              smallspace,
              mpdarc_widget,
              volumearc_widget,
              pomodoroarc_widget,
              watsonarc_widget,
              batteryarc_widget,
              smallspace,
              layout  = wibox.layout.fixed.horizontal,
              spacing       = 8,
            },
            shape        = gears.shape.rounded_bar,
            bg           = beautiful.tasklist_bg_normal,
            fg           = beautiful.tasklist_fg_normal,
            widget       = wibox.container.background
          },
          left = 4,
          widget       = wibox.container.margin
        },
        {
					{
						mytextclock,
						left   = 10,  -- space between border of shape and text
						right  = 10,
						top    = 3,
						bottom = 3,
						widget = wibox.container.margin
					},
					shape        = gears.shape.rounded_bar,
					bg           = beautiful.tasklist_bg_normal,
					fg           = beautiful.tasklist_fg_normal,
					widget       = wibox.container.background
				},
        {
					{
						{ 
							layout = awful.widget.only_on_screen,
							screen = 1, -- Only display on screen 1
							systray,
						},
						left   = 10,
						right  = 10,
						top    = 3,
						bottom = 3,
						widget = wibox.container.margin
					},
					shape        = gears.shape.rounded_bar,
					bg           = beautiful.tasklist_bg_normal,
					fg           = beautiful.tasklist_fg_normal,
					widget       = wibox.container.background
				},
				--mykeyboardlayout,
				--space,
				--s.screencount,
			},
		}
	end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

local function delete_tag()
  local t = awful.screen.focused().selected_tag
  if not t then return end
  t:delete()
end

local function add_tag()
  foo = #awful.screen.focused().tags + 1
  awful.tag.add(foo .. "_term",
    {
      screen= awful.screen.focused(),
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

--local muttcommand = "urxvt -e zsh -c \'echo -en \"\\e]1;mutt\\a\";echo -en \"\\e]2;mutt\\a\";echo -en \"\\e]0;mutt\\a\";sleep 0.05s; screen -S mutt mutt -F .muttrc\'"
local muttcommand = "kitty -e zsh -c \'echo -en \"\\e]1;mutt\\a\";echo -en \"\\e]2;mutt\\a\";echo -en \"\\e]0;mutt\\a\";sleep 0.05s; screen -S mutt mutt -F .muttrc\'"

-- {{{ Key bindings
			globalkeys = awful.util.table.join(
				awful.key({ modkey, "Control"   }, "s",      hotkeys_popup.show_help, {description="show help", group="awesome"}),
				--awful.key({ modkey, "Shift"   }, "w",       function() xrandr.xrandr() end, {description="show help", group="awesome"}),
        -- Non-empty tag browsing
				awful.key({ modkey,           }, "Prior",   awful.tag.viewprev, {description = "view previous", group = "tag"}),
				awful.key({ modkey,           }, "Next",  awful.tag.viewnext, {description = "view next", group = "tag"}),
				awful.key({ modkey,  }, "h", function () lain.util.tag_view_nonempty(-1) end, {description = "view previous nonempty", group = "tag"}),
				awful.key({ modkey,  }, "l", function () lain.util.tag_view_nonempty(1) end, {description = "view next nonempty", group = "tag"}),
        -- removed for collision
				--awful.key({ modkey,           }, "Left", function () lain.util.tag_view_nonempty(-1) end, {description = "view previous nonempty", group = "tag"}),
				--awful.key({ modkey,           }, "Right", function () lain.util.tag_view_nonempty(1) end, {description = "view next nonempty", group = "tag"}),
        awful.key({ modkey, "Control" }, "<", function () systray.visible = not systray.visible end, {description = "Toggle systray visibility", group = "custom"}),
        awful.key({ modkey,           }, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),

				awful.key({ modkey, "Mod1"   }, "a", add_tag, {description = "add a tag", group = "tag"}),
				--awful.key({ modkey, "Control" }, "a", move_to_new_tag, {description = "add a tag with the focused client", group = "tag"}),
				--awful.key({ modkey, "Mod1"    }, "a", copy_tag, {description = "create a copy of the current tag", group = "tag"}),
				awful.key({ modkey, "Mod1"   }, "d", delete_tag, {description = "delete the current tag", group = "tag"}),
				awful.key({ modkey, "Mod1"   }, "r", rename_tag, {description = "rename the current tag", group = "tag"}),

				awful.key({ modkey,           }, "=", function () awful.util.spawn("= --") end, {description = "Calc", group = "Calc"}),
				awful.key({ modkey, "Shift"   }, "=", function () awful.util.spawn("/home/raph/.scripts/rofi/rofi-notes/rofi_notes.sh") end, {description = "Notes", group = "Calc"}),
        awful.key({                   }, "XF86AudioPrev", function () awful.util.spawn("mpc prev") end, {description = "Previous track", group = "Audio"}),
        awful.key({                   }, "XF86AudioNext", function () awful.util.spawn("mpc next") end, {description = "Next track", group = "Audio"}),
        awful.key({                   }, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end, {description = "Toggle mpc", group = "Audio"}),
        awful.key({                   }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q -c 0 sset Master 2dB-") end, {description = "Lower volume", group = "Audio"}),
        awful.key({                   }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q -c 0 sset Master 2dB+") end, {description = "Raise volume", group = "Audio"}),
        awful.key({                   }, "XF86AudioMute", function () awful.util.spawn("amixer -q -c 0 sset Master toggle") end, {description = "Mute", group = "Audio"}),

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
    awful.key({ modkey, "Ctrl" }, "x", function () 
  --local grabber 
  --grabber = awful.keygrabber.run(function(mod, key, event)
		 --naughty.notify({title= event,text= key })
			--awful.keygrabber.stop(grabber)
  --end)
--end
      if testpopup.visible then 
        testpopup.visible = false 
      else testpopup.visible = true
      end
    end
    ),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "l", function () mouse.coords { x = 185, y = 10, silent=true } end,{description = "remove cursor", group = "mouse"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "x", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    --awful.key({ modkey, "Shift" }, "z", function () awful.spawn(terminal,false,
          --function(c) 
            --c.floating = not c.floating
            --c.width = c.screen.geometry.width*2/5
            --c.x = c.screen.geometry.x+c.screen.geometry.width - (c.width + (c.screen.geometry.width/12))
            --c.height = c.screen.geometry.height * 0.53
            --c.y = c.screen.geometry.height* 0.24
          --end) end,
              --{description = "open a terminal SLAVE", group = "launcher"}),
    awful.key({ modkey, "Shift" }, "x", function () awful.spawn(terminal,false,function(c) awful.client.setslave(c) end) end,
              {description = "open a terminal SLAVE", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"}, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),

    awful.key({ modkey, "Shift"}, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
            --
    --awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              --{description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey,           }, "n",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),

    --awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              --{description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey,           }, "p",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "<", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "<", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

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
    awful.key({ modkey,           }, "z", function () poppin.pop("terminal", "kitty ", "center", 600) end),
    --awful.key({ modkey,           }, "y", function () scratch.toggle("urxvt -name scratchpad-watson ", {instance = "scratch-watson"}) end),
    awful.key({ modkey, "Shift"   }, "z", function () poppin.pop("python", "kitty --name scratchpad -e python", "center", 600) end),
    -- Prompt
    awful.key({ modkey },            "Return",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey,        }, "v", function () watson_shell.launch() end),
    --awful.key({ modkey,           }, "d", function () awful.util.spawn("urxvt -e ncmpcpp") end, {description = "run ncmpcpp", group = "apps"}),
    --awful.key({ modkey,           }, "d", function () awful.util.spawn("urxvt -e ncmpcpp") end, {description = "run ncmpcpp", group = "apps"}),
    awful.key({ modkey, "Shift" }, "d", function ()
    local matcher = function (c)
        return awful.rules.match(c, {name = "Rambox"})
    end
    awful.client.run_or_raise('rambox', matcher)
end),
    awful.key({ modkey, }, "s", function ()
    local matcher = function (c)
        return awful.rules.match(c, {class = "calendar"})
    end
    awful.client.run_or_raise('vimb --class=calendar https://calendar.google.com/calendar/r/month', matcher)
end),
    awful.key({ modkey, "Shift" }, "s", function ()
    local matcher = function (c)
        return awful.rules.match(c, {class = "todolist"})
    end
    awful.client.run_or_raise('vimb --class=todolist https://www.ticktick.com/', matcher)
end),
    awful.key({ modkey, }, "d", function ()
    local matcher = function (c)
        return awful.rules.match(c, {name = "ncmpcpp"})
    end
    awful.client.run_or_raise(terminal .. ' -e ncmpcpp', matcher)
end),
    awful.key({ modkey, }, "e", function () awful.util.spawn(terminal .." -e ranger") end,
              {description = "run ranger", group = "apps"}),
    awful.key({ modkey, "Shift" }, "e", function () awful.util.spawn("nemo") end, {description = "run pcmanfm", group = "apps"}),
    --awful.key({ modkey,           }, "e", function () awful.util.spawn("thunar") end, {description = "run pcmanfm", group = "apps"}),
    --awful.key({ modkey,           }, "w", function () awful.util.spawn("firefox") end, {description = "run firefox", group = "apps"}),
    awful.key({ modkey, }, 'w', function ()
    local matcher = function (c)
        return awful.rules.match(c, {class = 'Firefox'})
    end
    awful.client.run_or_raise('firefox', matcher)
end),
            --
    --awful.key({ modkey,           }, "c", function () awful.util.spawn("urxvt -e neomutt -F .muttrc") end, {description = "run mutt", group = "apps"}),
    --awful.key({ modkey,           }, "c", function () awful.util.with_shell("urxvt -e zsh -c \"sleep 0.1s ; screen -S mutt mutt -F .muttrc\"", {tag = "mail"}) end, {description = "run mutt", group = "apps"}),
    awful.key({ modkey,           }, "c", function () 
      awful.screen.focus(1)
      awful.tag.viewonly(awful.tag.find_by_name(screen[1], "mail"))
      awful.util.spawn(muttcommand, {tag = "mail"}) 
    end, {description = "run mutt", group = "apps"}),

    --awful.key({ modkey,           }, "w", function () awful.util.spawn("surf https://calendar.google.com/calendar") end, --{description = "agenda", group = "apps"}),
    --awful.key({ modkey, "Shift" }, "w", function () awful.util.spawn("surf https://ticktick.com/") end, --{description = "ticktick", group = "apps"}),
    awful.key({ modkey, "Control" }, "a", function () awful.util.spawn("xscreensaver-command -lock")   end,
              {description = "lock screen", group = "apps"}),
-- 

    --awful.key({ modkey,           }, "<", function () dmenuhelpers.run()       end,{description = "run", group = "launcher"}), 
    awful.key({ modkey,           }, "q", function () awful.util.spawn("/home/raph/.scripts/fake-clerk.sh")       end,{description = "clerk mpd", group = "launcher"}), 
    awful.key({ modkey, "Shift"   }, "q", function () awful.util.spawn("/home/raph/.scripts/rofi/xrandr-config.sh")       end), 
    awful.key({ modkey,           }, "space", function () awful.util.spawn("rofi -show combi -combi-modi \"window,run,snippet\" -modi combi,calc,snippets:/home/raph/Code/langageBash/rofi-modi-snippets/snippets.sh,fileb_:/usr/share/doc/rofi/examples/rofi-file-browser.sh,top,json-dict,ssh")       end,{description = "run", group = "launcher"}), 
    --awful.key({ modkey,           }, "b", function () awful.util.spawn("rofi -modi \"file:./scripts/rofi/rofi-file-browser.sh\" -show file")       end,{description = "run", group = "launcher"}), 
    awful.key({ modkey, "Shift" }, "space",     function () awful.util.spawn("rofi-pass")             end),
    --awful.key({ modkey }, "a",     function () dmenuhelpers.expandtext()       end,{description = "text expansion", group = "launcher"}),
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
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end, {description = "close", group = "client"}),

    awful.key({ modkey, "Shift"}, "a", 
        function (c)   
          naughty.notify{ 
            title= "debug",
            --text = tostring(c.screen.geometry.height).."-"..tostring(c.screen.index),
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
    awful.key({ modkey }, "a", 
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
    --awful.key({ modkey, "Control" }, "<",  awful.client.floating.toggle                     , {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end, {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end, {description = "move to screen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "o",  
      function (c) 
        c:tags(c.original_tags)          
        c.screen = c.original_screen
      end, 
      {description = "restore tags", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end, {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,  "Shift"  }, "t",      awful.client.floating.toggle                     , {description = "toggle floating", group = "client"}),
    awful.key({ modkey,  "Shift"  }, "n",
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
                        --local tags = root.tags()
                        --tnames = {}
                        --for key,tag in ipairs(tags) do
                          --table.insert(tnames, key .. ":" .. tag.name .. " ")
                        --end
                        --naughty.notify{ title="tag debug", text = table.concat(tnames) }
                        --local tag = tags[i]
                        --naughty.notify{ title="tag debug", text = tag.name .. " " .. i }
                        --if tag then
                           --tag:view_only()
                           --if tag:clients() then 
                             --c = tag:clients()[1]
                             --client.focus = c
                             --if c then
                               --c:raise()
                             --end
                           --end
                        --end
                        --
                        -- old version
                        --local screen = awful.screen.focused()
                        --local tag = screen.tags[i]
                        --if tag then
                           --tag:view_only()
                        --end
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
    --{rule = {}, callback = function(c) naughty.notify{ title="new window", text = c.name } end },

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

    -- Add titlebars to normal clients and dialogs
    --{ rule_any = {type = { "normal", "dialog" }
      --}, properties = { titlebars_enabled = true }
    --},

    -- Set Firefox to always map on the tag named "2" on screen 1.
    { rule = { class = "Firefox" },
      properties = { screen = 1, tag = "web" } },
    { rule = { class = "Opera" },
      properties = { screen = 1, tag = "web🖧" } },
    { rule = { name = "screen" },
      properties = { screen = 1, tag = "work" } },
    { rule = { name = "mutt" },
      properties = { screen = 1, tag = "mail", switchtotag = true } },
    { rule = { name = "Rambox" },
      properties = { screen = screen:count(), tag = "im"} },
    { rule = { name = "Franz" },
      properties = { screen = screen:count(), tag = "im"} },
    { rule = { name = "Eclipse" },
      properties = { screen = 1, tag = "work", switchtotag = false  } },
    { rule = { name = "Sonata" },
      properties = { screen = screen:count(), tag = "media", switchtotag = true  } },
    { rule = { name = "ncmpcpp" },
      properties = { screen = screen:count(), tag = "media", switchtotag = true  } },
    { rule = { class = "Acroread" },
      properties = { screen = screen:count(), tag = "pdf", switchtotag = true } },
    { rule = { class = "Epdfview" },
      properties = { screen = screen:count(), tag = "pdf", switchtotag = true } },
    { rule = { class = "Zathura" },
      properties = { screen = screen:count(), tag = "pdf", switchtotag = true } },
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
    { rule = { class = "Alarm-clock" },
      properties = { floating = true } },
    { rule = { class = "LibreOffice" },
      properties = { screen = screen:count(), tag = "pdf", floating = false, switchtotag = true, maximized_vertical = true, maximized_horizontal = true } },
    { rule = { name = "alsamixer" },
      properties = { screen = 1, tag = "root", switchtotag = true } },
    { rule = { class = "communications" }, properties = { screen = screen:count(),tag = "im"} },
    { rule = { class = "calendar" }, properties = { screen = screen:count(),tag = "todo",switchtotag=true, maximized = false} },
    { rule = { class = "wordreference" }, properties = { screen = screen:count(),tag = "todo",switchtotag=true,maximized=false} },
    { rule = { class = "todolist" }, properties = { screen = screen:count(),tag = "todo",switchtotag=true, maximized = false} },
    { rule = { instance = "watson" }, properties = { screen = screen:count(),tag = "todo",switchtotag=true,maximized=false} },
    { rule = { instance = "rootterm" },
      properties = { screen = 1, tag = "root", switchtotag = true } },
    { rule = { class = "Deluge" },
      properties = { screen = screen:count(), tag = "media" } },
    { rule = { class = "Homebank" },
      properties = { screen = screen:count(), tag = "media", switchtotag = true} },
    { rule = { class = "yakyak" },
      properties = { screen = screen:count(), tag = "im"} },
    { rule = { class = "Chromium" },
      properties = { screen = 1, tag = "web", switchtotag = true} },
    { rule = { class = "Surf" },
      properties = { screen = 1, tag = "term", floating = false, switchtotag = true } },
    { rule = { class = "Pavucontrol" },
      properties = { screen =screen:count(), tag = "media", floating = true,  geometry = { height=600, width=1100, y=200, x=200 },} },
    { rule = { class = "Spotify" },
      properties = { screen =screen:count(), tag = "media" } },
    { rule = { class = "Scribus" },
      properties = { screen = 1, tag = "graph" } },
    { rule = { class = "Gorilla" },
      properties = { screen = 1, tag = "graph", switchtotag = true, floating = true } },
    { rule = { class = "Inkscape" },
      properties = { screen = 1, tag = "graph" } },
    { rule = { class = "Pinentry" },
      properties = { floating = true } },
    { rule = { class = "Openshot" },
      properties = { screen = 1, tag = "graph", floating = false } },
    { rule = { class = "xpad" },
      properties = { floating = true, skip_taskbar = true } },
    { rule = { class = "Gimp" },
      properties = { screen = 1, tag = "graph", floating = false } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    --if slave then awful.client.setslave(c) end
    
    -- Coins arrondis pour les fenêtres
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,20)
    end


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
  if (clientTag ~= currentTag) and not awesome.startup then
    naughty.notify({title = (c.name or "Application") .. " started", text = "on tag " .. clientTag  , width=300, height=100})
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

reminderTimers = timer({timeout = 20})
reminderTimers:connect_signal("timeout", notify.Check)
reminderTimers:start()

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
--}}}
screen.connect_signal("list", awesome.restart)
-- }}}
