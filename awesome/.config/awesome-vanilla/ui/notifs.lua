local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")
local ruled = require("ruled")

-- notifications --

naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
    message = message,
    icon = beautiful.notification_icon_error,
  }
end)

ruled.notification.connect_signal('request::rules', function()

  ruled.notification.append_rule {
    rule = { urgency = "normal" },
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
      --position = "top_middle",
      position = "bottom_right",
      spacing = 10,
      bg = beautiful.background,
      fg = beautiful.foreground,
      border_width = beautiful.border_width,
      border_color = beautiful.border_color_normal,
    }
  }

  ruled.notification.append_rule {
    rule = { urgency = "critical" },
    properties = {
      screen = awful.screen.preferred,
      implicit_timeout = 5,
      --position = "top_middle",
      position = "bottom_right",
      spacing = 10,
      bg = beautiful.background,
      fg = beautiful.foreground,
      border_width = beautiful.border_width,
      border_color = beautiful.border_color_normal,
      icon = beautiful.notification_error,
    }
  }

end)

naughty.connect_signal("request::display", function(n)
  if not n.app_icon then
    n.app_icon = beautiful.notification_icon
  end

  naughty.layout.box {
    notification = n,
    maximum_width = 800,
    widget_template = {
      widget = wibox.container.constraint,
      strategy = "max",
      {
        widget = naughty.container.background,
        id = "background_role",
        {
          widget = wibox.container.margin,
          margins = 16, -- around the whole bubble
          {
            layout = wibox.layout.fixed.horizontal,
            spacing = 0,
            fill_space = true,
            {
              widget = wibox.container.margin,
              margins = { right = 16 },
              {
                widget               = wibox.container.background,
                resize               = true,
                forced_width         = 120,
                forced_height        = 120,
                naughty.widget.icon,
              },
            },
            {
              widget = wibox.container.place,
              {
                layout = wibox.layout.fixed.vertical,
                spacing = 10,
                naughty.widget.title,
                naughty.widget.message,
              },
              valign = "center",
              margins = 30,
              forced_height = 100,
            }
          }
        }
      }
    }
  }
end)
