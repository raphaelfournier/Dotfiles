----------------------------------------------
--
-- Control PulseAudio sink with slider
-- Hover over slider for tooltip listing the sinks
-- Hover over textbox for menu to switch default sink
--
-- Author: Seth Barberee <seth.barberee@gmail.com>
----------------------------------------------

local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")

local muted = false -- Keep track of mute
local sink = ""
local shown = false

local volume_menu = {}
local table_len = 0 -- keep track of table length
local vol_menu

-- TODO add volume icon
local volume = wibox.widget {
    {
        {
            {
                id      = 'textbox',
                text    = "V: 50",
                halign  = 'center',
                valign  = 'center',
                widget  = wibox.widget.textbox
            },
            --id = 'margin',
            right = 2,
            left = 2,
            widget = wibox.container.margin,
        },
        {
            id                  = 'bar',
            maximum             = 100,
            value               = 50,
            forced_height       = 20,
            forced_width        = 100,
            bar_height          = 3,
            bar_active_color    = beautiful.bg_focus,
            bar_color           = beautiful.bg_normal,
            handle_color        = beautiful.bg_focus,
            widget              = wibox.widget.slider,
        },
        layout = wibox.layout.align.horizontal,
    },
    right = 5,
    widget = wibox.container.margin,
}

local volume_t = awful.tooltip {
    objects = {volume:get_children_by_id("bar")[1]}, -- Attach tooltip to slider
    timer_function = function()
        -- TODO filter better instead of running commands twice.. but hey, it works
        awful.spawn.easy_async_with_shell("pamixer --list-sinks | cut -f 1,3- -d ' '", function(out)
            awful.spawn.easy_async_with_shell("pamixer --list-sinks | cut -f 1,3- -d ' ' | grep -E '[0-9]' | cut -f 1 -d ' '", function(stdout)
                volume_menu = {} -- reset the table
                for s in stdout:gmatch("[^\r\n]+") do
                    -- Lua hates tables at 0 yet pamixer starts at 0... add 1 to each index
                    if not volume_menu[tonumber(s) + 1] then
                        volume_menu[tonumber(s) + 1] = 0
                        table_len = table_len + 1
                    else
                        volume_menu[tonumber(s) + 1] = volume_menu[tonumber(s) + 1] + 1
                    end
                end
            end)
            sink = out
        end)
        return sink
    end,
}
local function update_volume()
    awful.spawn.easy_async_with_shell("pamixer --get-volume-human", function(stdout)
        if not string.match(stdout, 'muted') then
            local volume_out = stdout:gsub('%%', '') -- remove percentage
            volume:get_children_by_id("textbox")[1].text = "V: " .. volume_out
            volume:get_children_by_id("bar")[1].value    = tonumber(volume_out)
            muted = false
        else
            muted               = true
            volume:get_children_by_id("textbox")[1].text = "V: Muted"
        end
    end)
end

function volume.raise_volume()
    awful.spawn.with_shell("pamixer --increase 10")
    update_volume()
end

function volume.lower_volume()
    awful.spawn.with_shell("pamixer --decrease 10")
    update_volume()
end

function volume.mute()
    muted = not muted -- toggle mute status
    awful.spawn.with_shell("pamixer -t")
    update_volume()
end

volume:get_children_by_id("bar")[1]:connect_signal('property::value', function()
    awful.spawn.easy_async_with_shell("pamixer --set-volume " .. volume:get_children_by_id("bar")[1].value, function()
        update_volume()
    end)
end)

volume:get_children_by_id("textbox")[1]:connect_signal('mouse::enter', function()
    -- Create the sink menu from the length - 1 (to get rid of "Sinks: " part)
    local volume_items = {}
    -- Create sink menu based off the indexes we gathered earlier
    if table_len ~= 0 then -- check if we have enumerated the devices yet
        for k,v in pairs(volume_menu) do
            local index = tonumber(k) - 1 -- counteract our padding earlier of the index
            local string = "Sink " .. index
            local cmd = "pactl set-default-sink " .. index
            table.insert(volume_items,  {string, function() awful.spawn(cmd) update_volume() end} )
        end
        if shown == false then
            vol_menu = awful.menu(volume_items)
            shown = true
            -- Start a timer to autoclose the menu
            gears.timer {
                timeout = 2,
                autostart = true,
                single_shot = true,
                callback = function()
                    vol_menu:hide()
                    shown = false
                end
            }
            vol_menu:show()
        end
    end
end)

return setmetatable(volume, { __call = function(_, ...) update_volume() return volume end})
