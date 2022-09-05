local awful = require("awful")
local beautiful = require("beautiful")

local the_theme = "myzenburn"
beautiful.init(awful.util.getdir("config") .. "/themes/".. the_theme .. "/theme.lua")
