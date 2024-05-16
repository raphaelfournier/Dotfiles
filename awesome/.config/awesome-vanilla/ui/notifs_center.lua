local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local naughty = require("naughty")
local helpers = require("helpers")
local beautiful = require("beautiful")
local calendar = require("ui.calendar")
local playerctl = require("ui.playerctl")
playerctl_widget = playerctl.new()
local playerctl_daemon = require("ui.playerctl-daemon")
local batteryarc_widget = require("rfs-widgets.batteryarc-widget.batteryarc")
local pomodoroarc_widget = require("rfs-widgets.pomodoroarc-widget.pomodoroarc")
local demoMode_widget = require("rfs-widgets.demoMode-widget.demomode") -- teaching mode
local mpdarc_widget = require("rfs-widgets.mpdarc-widget.mpdarc")

local time = wibox.widget {
  widget  = wibox.container.margin,
  margins = {top = 12, bottom = 12, left=6,right=6},
  {
    widget = wibox.container.background,
    id = "clock",
    bg = beautiful.background_alt,
    {
      widget = wibox.container.place,
      halign = "center",
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = 8,
        {
          widget  = wibox.widget.textclock,
          font    = "Inconsolata 72",
          format  = "<span foreground='#dcdccc'>%H:%M</span>",
          refresh = 1,
          halign  = "center"
        },
      }
    }
  }
}

-- notification list --
local notifs_count = 0
awesome.emit_signal("notifs::count", notifs_count)

local label = wibox.widget {
  markup = "<span foreground = '#dcdccc'>Notifications</span>",
  align  = "center",
  widget = wibox.widget.textbox,
  font   = beautiful.font or "Inconsolata Medium 18",
}


local notifs_clear = wibox.widget {
  markup = "❌",
  align  = "center",
  valign = "center",
  widget = wibox.widget.textbox,
  font   = "Inconsolata Medium 12",
}

local notifscenterhide = wibox.widget {
  markup = "<span foreground = '#dcdccc'>≡</span>",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
  font = "Inconsolata Medium 20",
}

notifscenterhide:buttons(gears.table.join(awful.button({}, 1, function()
  awesome.emit_signal("summon::notif_center", notifs_count)
end)))

notifs_clear:buttons(gears.table.join(awful.button({}, 1, function()
  _G.notif_center_reset_notifs_container()
  notifs_count = 0
  awesome.emit_signal("notifs::count", notifs_count)
end)))

local notifs_empty = wibox.widget {
  forced_height = 300,
  widget = wibox.container.background,
  {
    layout = wibox.layout.flex.vertical,
    {
      markup = "<span foreground = '#dcdccc'>Aucune notification</span>",
      font   = beautiful.font or "Inconsolata Medium 18",
      align  = "center",
      valign = "center",
      widget = wibox.widget.textbox,
    },
  },
}

local myscreen = awful.screen.focused()

local notifs_container = wibox.widget {
  forced_width = 240,
  layout = wibox.layout.fixed.vertical,
  spacing = 8,
  spacing_widget = {
    margins = 20,
    --top    = 2,
    --bottom = 2,
    --left   = 16,
    --right  = 16,
    widget = wibox.container.margin,
    {
      widget = wibox.container.background,
    },
  },
}

local remove_notifs_empty = true

notif_center_reset_notifs_container = function()
  notifs_container:reset(notifs_container)
  notifs_container:insert(1, notifs_empty)
  remove_notifs_empty = true
end

notif_center_remove_notif = function(box)
  notifs_container:remove_widgets(box)

  if #notifs_container.children == 0 then

    notifs_container:insert(1, notifs_empty)
    remove_notifs_empty = true
  end
end

local create_notif = function(icon, n, width)
  local time = os.date "%H:%M:%S"

  local icon_widget = wibox.widget {
    widget = wibox.container.constraint,
    {
      widget = wibox.container.margin,
      margins = 20,
      forced_height = 80,
      {
        widget = wibox.widget.imagebox,
        image = icon,
        --clip_shape = gears.shape.circle,
        halign = "center",
        valign = "center",
      },
    },
  }

  local title_widget = wibox.widget {
    widget = wibox.container.scroll.horizontal,
    step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
    speed = 50,
    forced_width = 200,
    {
      widget = wibox.widget.textbox,
      text = n.title,
      align = "left",
      forced_width = 200,
    },
  }

  local time_widget = wibox.widget {
    widget = wibox.container.margin,
    margins = { right = 4 },
    {
      widget = wibox.widget.textbox,
      text = time,
      align = "right",
      valign = "bottom",
    },
  }

  local text_notif = wibox.widget {
    markup = n.message,
    align = "left",
    --forced_width = 165,
    widget = wibox.widget.textbox,
  }


  local box = wibox.widget {
    widget         = wibox.container.background,
    shape          = gears.shape.rounded_rect,
    margins        = {left = 4, right = 4},
    border_width   = 2,
    border_color   = "FF0000",
    maximum_height = 300,
    bg             = "#1E2320",
    fg             = "#dcdccc",
    {
      layout = wibox.layout.align.horizontal,
      icon_widget,
      {
        widget = wibox.container.margin,
        margins = 10,
        {
          layout = wibox.layout.align.vertical,
          {
            layout = wibox.layout.fixed.vertical,
            spacing = 10,
            {
              layout = wibox.layout.align.horizontal,
              title_widget,
              nil,
              time_widget,
            },
            text_notif,
          }
        }
      }
    }
  }


  box:buttons(gears.table.join(awful.button({}, 1, function()
    _G.notif_center_remove_notif(box)
    notifs_count = notifs_count - 1
    awesome.emit_signal("notifs::count", notifs_count)
  end)))

  return box
end

notifs_container:buttons(gears.table.join(
awful.button({}, 4, nil, function()
  if #notifs_container.children == 1 then
    return
  end
  notifs_container:insert(1, notifs_container.children[#notifs_container.children])
  notifs_container:remove(#notifs_container.children)
end),

awful.button({}, 5, nil, function()
  if #notifs_container.children == 1 then
    return
  end
  notifs_container:insert(#notifs_container.children + 1, notifs_container.children[1])
  notifs_container:remove(1)
end)
))

notifs_container:insert(1, notifs_empty)

naughty.connect_signal("request::display", function(n)
  if #notifs_container.children == 1 and remove_notifs_empty then
    notifs_container:reset(notifs_container)
    remove_notifs_empty = false
  end

  local appicon = n.icon or n.app_icon
  if not appicon then
    appicon = beautiful.notification_icon
  end

  notifs_container:insert(1, create_notif(appicon, n, width))
  notifs_count = notifs_count + 1
  awesome.emit_signal("notifs::count", notifs_count)
end)

local notifs_count_widget = wibox.widget.textbox()

awesome.connect_signal("notifs::count", function(count)
  notifs_count_widget.font = beautiful.font or "Inconsolata Medium 18"
  notifs_count_widget.fg = "#dcdccc"
  if count == 0 then
    notifs_count_widget.markup = "<span foreground = '#dcdccc'></span>"
  else
    notifs_count_widget.markup = "<span foreground = '#dcdccc'>("..count..")</span>"
  end
end)

local notifs = wibox.widget {
  spacing = 16,
  layout = wibox.layout.fixed.vertical,
  {
    widget = wibox.container.margin,
    margins = {left = 20, right = 20, top = 20, bottom = 0},
    {
      layout = wibox.layout.align.horizontal,
      nil,
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = 10,
        label,
        notifs_count_widget
      },
      {
        layout = wibox.layout.fixed.horizontal,
        spacing = 8,
        notifs_clear,
        notifscenterhide,
      },
    },
  },
  notifs_container,
}

local indicators = wibox.widget {
  {
    batteryarc_widget,
    pomodoroarc_widget,
    demoMode_widget,
    mpdarc_widget,
    layout = wibox.layout.fixed.horizontal,
    spacing = 16,
  },
  widget = wibox.container.place,
  halign = "center",
}

local notif_center = awful.popup {
  widget = wibox.widget {
    wibox.widget {
    --{
        --col_span = 2,
        --row_span = 1,
        --row_index = 1,
        --col_index = 1,
  --forced_height = 36,
        --widget    = wibox.widget.background
    --},
    {
        row_index = 1,
        col_index = 1,
        col_span = 2,
        row_span = 1,
        widget    = time,
    },
    {
        row_index = 2,
        col_index = 1,
        col_span  = 2,
        forced_height = 36,
        widget    = indicators
    },
    {
        row_index = 1,
        col_index = 3,
        row_span  = 2,
        col_span  = 2,
        widget    = calendar.widget
    },
    {
        row_index = 3,
        col_index = 1,
        col_span  = 4,
        widget    = playerctl_widget
    },
    {
        row_index = 4,
        col_index = 1,
        col_span  = 4,
        row_span  = 9,
        widget    = notifs
    },
    --border_width         = 1,
    --minimum_column_width = 10,
    --minimum_row_height   = 10,
    row_count            = 10,
    column_count         = 4,
    layout               = wibox.layout.grid,
},
  widget = wibox.container.place,
  halign = "center",
},
  bg             = "#3f3f3f50",
  border_color   = "#DCDCCC",
  border_width   = 2,
  --fill_space     = true,
  --layout         = wibox.layout.fixed.vertical,
  --margins        = {right = 40},
  maximum_width  = myscreen.geometry.width/3+4,
  minimum_height = myscreen.geometry.height-8,
  maximum_height = myscreen.geometry.height-8,
  minimum_width  = myscreen.geometry.width/3,
  ontop          = true,
  opacity        = 0.5,
  shape          = gears.shape.rounded_rect,
  visible        = false,
  --spacing        = 0,
  placement = function(d)
    awful.placement.bottom_right(d, { honor_workarea = false, honor_padding = true })
  end,
}

awesome.connect_signal("summon::notif_center", function()
  notif_center.visible = not notif_center.visible
end)

-- hide on click --

--client.connect_signal("button::press", function()
--if notif_center.visible == true then
--awesome.emit_signal("summon::notif_center")
--end
--end)

--awful.mouse.append_global_mousebinding(
--awful.button({ }, 1, function()
--if notif_center.visible == true then
--awesome.emit_signal("notif_center::open")
--end
--end)
--)
