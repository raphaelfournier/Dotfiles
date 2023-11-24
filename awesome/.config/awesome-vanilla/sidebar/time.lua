local wibox     = require("wibox")
local beautiful = require("beautiful") 
local dpi       = require("beautiful.xresources").apply_dpi

local create_point = function(color)
	return wibox.widget {
		widget = wibox.container.background,
		bg = color,
		forced_width = 8,
		forced_height = 8,
	}
end

local time = wibox.widget {
	widget = wibox.container.place,
	halign = "center",
	{
		layout = wibox.layout.fixed.horizontal,
		spacing = 20,
		{
			widget = wibox.widget.textclock,
			font = beautiful.font.. " 30",
			format = "%H",
		},
		{
			widget = wibox.container.margin,
			top = 15,
			{
				layout = wibox.layout.fixed.vertical,
				spacing = 8,
				create_point(beautiful.green),
				create_point(beautiful.yellow),
				create_point(beautiful.red),
			},
		},
		{
			widget = wibox.widget.textclock,
			font = beautiful.font.. " 30",
			format = "%M",
		}
	}
}

