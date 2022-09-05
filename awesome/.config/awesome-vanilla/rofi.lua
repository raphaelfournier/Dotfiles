--[[
    rofi.lua - rofi-powered menus for awesome wm
    Usage:
    rofi = require("rofi")
    change width (optional, default 500px):
    rofi.width=300
    bind to key:
        awful.key({ modkey }, "f", function (c) rofi.client_flags(c) end)
--]]

local spawn      = require("awful.spawn")
local naughty       = require("naughty")

rofi = {
    width =200,
    height = 100
}

function rofi.client_flags(c)
    local opts = (c.maximized  and "✓" or " ") .. " maximize\n"
              .. (c.floating   and "✓" or " ") .. " floating\n"
              .. (c.fullscreen and "✓" or " ") .. " fullscreen\n"
              .. (c.sticky     and "✓" or " ") .. " sticky\n"
              .. (c.ontop      and "✓" or " ") .. " ontop\n"
              .. "  minimize\n"

    local w = math.min(rofi.width, c.width)
    local h = rofi.height
    local x = c.x
    local y = c.y

    local cmd = "echo -e \""..opts.."\" | "
             .. " rofi -config ~/.config/rofi/config.flags.rasi -dmenu -matching fuzzy -auto-select"
             .. " -p flags: -location 1 -width " .. w
             .. " -height " .. h
             .. " -xoffset " .. x
             .. " -yoffset " .. y
    spawn.easy_async_with_shell(cmd, function(output)
        for k in string.gmatch(output, ". (%S+)") do
            if k == "sticky" then
                c.sticky = not c.sticky
            elseif k == "ontop" then
                c.ontop = not c.ontop
            elseif k == "floating" then
                c.floating = not c.floating
            elseif k == "maximize" then
                c.maximized = not c.maximized
                c:raise()
            elseif k == "fullscreen" then
                c.fullscreen = not c.fullscreen
                c:raise()
            elseif k == "minimize" then
                c.minimized = true
            end
        end
    end)
end

return rofi
