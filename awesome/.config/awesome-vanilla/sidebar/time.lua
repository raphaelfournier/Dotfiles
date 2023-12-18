local wibox     = require("wibox")
local beautiful = require("beautiful") 
local dpi       = require("beautiful.xresources").apply_dpi

local time = wibox.widget {
	widget = wibox.container.place,
	halign = "center",
	{
		layout = wibox.layout.fixed.horizontal,
		spacing = 20,
		{
			widget = wibox.widget.textclock,
			font = beautiful.font.. " 30",
			format = "%H:%M",
		}
	}
}

