local awful= require("awful")
local beautiful = require("beautiful")
local naughty   = require("naughty")
local client=client
local pairs=pairs
local table=table
local print=print

local dmenuhelpers = {}

--dmenuopts = "-b -i -nf '"..beautiful.fg_normal.."' -nb '"..beautiful.bg_normal.."' -sf '"..beautiful.bg_urgent.."' -sb '"..beautiful.bg_focus.."' -fn '-*-dejavu sans mono-*-r-*-*-*-*-*-*-*-*-*-*'"
-- add -z to do fuzzy matching
--
--dmenuopts = "-b -i -fn 'Inconsolata, Medium-18' -nf '"..beautiful.fg_normal.."' -nb '"..beautiful.bg_normal.."' -sf '"..beautiful.border_focus.."' -sb '"..beautiful.bg_focus.."'"
dmenuopts = "-b -i -fn 'Inconsolata, Medium-18'"

function dmenuhelpers.switchapp()
  local allclients = client.get(mouse.screen)
  clientsline = ""
  for _,c in ipairs(allclients) do
    clientsline = clientsline .. c:tags()[1].name .. " - " .. c.name .. "\n"
  end
  selected = awful.util.pread("echo '".. clientsline .."' | yeganesh -f -- -l 10 " .. dmenuopts)
  for _,c in ipairs(allclients) do
    a = c:tags()[1].name .. " - " .. c.name 
    if a == selected:gsub("\n", "") then
      for i, v in ipairs(c:tags()) do
        awful.tag.viewonly(v)
        client.focus = c
        c:raise()
        c.minimized = false
        return
      end
    end
  end
end

function dmenuhelpers.run() 
  awful.util.spawn("yegonesh -- " .. dmenuopts) 
  --awful.util.spawn("yeganesh -p \"run\" -- " .. dmenuopts) 
end

function dmenuhelpers.network() 
  awful.util.spawn("nmcli_dmenu") 
end 

function dmenuhelpers.netcfg() 
  netcfgprofile = awful.util.pread("find /etc/network.d/ -type f | grep -v examples | cut -d \"/\" -f 4 | dmenu " .. dmenuopts)
  awful.util.spawn(netcfgprofile ~= "" and "sudo netcfg -r " .. netcfgprofile or nil) 
end 

function dmenuhelpers.mpd() 
  numsong = awful.util.pread("mpc playlist | nl -s ' ' | tr -s \" \" | dmenu -l 10 " .. dmenuopts .. "| cut -d \" \" -f2")
  awful.util.spawn(numsong ~= "" and "mpc play " .. numsong or nil) 
end 

function dmenuhelpers.system() 
  choice = awful.util.pread("echo -e ' \nlogout\nsuspend\nhalt\nreboot\nvgaoff\nvgaoffsuspend\ndepart-cnam\necran-cnam\necran-24-dell\nvideoproj' | dmenu -p 'System' -f " .. dmenuopts)
  if     choice == "logout\n"   then awesome.quit()
  elseif choice == "halt\n"     then awful.util.spawn("sudo halt")
  elseif choice == "reboot\n"   then awful.util.spawn("sudo reboot")
  elseif choice == "suspend\n"  then awful.util.spawn("sudo pm-suspend")
  elseif choice == "vgaoff\n"  then awful.util.spawn("xrandr --output VGA1 --off")
  elseif choice == "vgaoffsuspend\n"  then awful.util.spawn("xrandr --output VGA1 --off && sudo pm-suspend")
  elseif choice == "ecran-24-dell\n"  then awful.util.spawn("sh /home/raph/scripts/ecran-dell24.sh")
  elseif choice == "ecran-cnam\n"  then awful.util.spawn("sh /home/raph/scripts/ecran-cnam.sh")
  elseif choice == "depart-cnam\n"  then awful.util.spawn("sh /home/raph/scripts/depart-cnam.sh")
  elseif choice == "tele\n"  then awful.util.spawn("xrandr --output VGA1 --mode 1360x768 --right-of LVDS1")
  elseif choice == "videoproj\n"     then awful.util.spawn("--output LVDS1 --mode 1024x768 --output VGA1 --mode 1024x768 --same-as LVDS1")
  else   choice = ""
  end
end 

function dmenuhelpers.xrandr()
  choice = awful.util.pread("echo -e ' \nvgaoff\nvideoproj\necran-24-dell' | dmenu -p 'System' -f " .. dmenuopts)
  if     choice == "vgaoff\n"   then awful.util.spawn("xrandr --output VGA1--off --output LVDS1 --auto")
  elseif choice == "ecran-24-dell\n"  then awful.util.spawn("sh /home/raph/scripts/ecran-dell24.sh")
  else   choice = ""
  end
end

function dmenuhelpers.expandtext()
  textexpfile = "/home/raph/.textexp"
  service = awful.util.pread("cat "..textexpfile.." | grep -v ^# | cut -d: -f1 | yeganesh -p expand -f -- -l 10 " .. dmenuopts)
  naughty.notify({ text = "service : "..service, width = 400, screen = mouse.screen})
  linetextexp = awful.util.pread("cat "..textexpfile.." | grep -i -m1 "..service):gsub("\n", "")
  --textexp = awful.util.pread("echo " .. linetextexp .. " | cut -d: -f2-"):gsub("\n", "")
  textexp = awful.util.pread("echo " .. '"' .. linetextexp .. '"' .. " | cut -d: -f2-"):gsub("\n", "")
  if textexp ~= "\n" and textexp ~= "" then
    textexp = string.gsub(textexp, " bb ", "\n")
    naughty.notify({ text = "service : "..service, width = 400, screen = mouse.screen})
    selectcommand = "xdotool type --clearmodifiers -- ".. '"' .. textexp .. '"'
    --selectcommand = "echo '" .. textexp .. "' | xsel -i"
    --awful.util.spawn_with_shell(selectcommand,false)
  end
end

function dmenuhelpers.pass()
	--pwdpath = "/home/raph/.password-store"
  --service = awful.util.pread("find .password-store -name \"*gpg\"  | dmenu " .. dmenuopts):gsub(".gpg", ""):gsub(".password-store/", "")
  ----login = awful.util.pread(safepwd.." -u "..service):gsub("\n", "")
	--naughty.notify({ text = "service : ".. service, width = 400, screen = mouse.screen})
	awful.util.spawn("passmenu --type " .. dmenuopts)
end

function dmenuhelpers.pwsafe()
  pwdpath = "/home/raph/.awdp"
  pwsafepwd = awful.util.pread("cat "..pwdpath):gsub("\n", "")
  safepwd = "echo "..pwsafepwd.." | pwsafe-cli -f ~/.pwsafe.datv2"
  service = awful.util.pread(safepwd.." -l | cut -d- -f1 | dmenu " .. dmenuopts)
  login = awful.util.pread(safepwd.." -u "..service):gsub("\n", "")
  awful.util.spawn_with_shell(safepwd.." -p "..service,false)
  if login ~= "\n" and login ~= "" then
    naughty.notify({ text = "service : "..service.."login : "..login, width = 400, screen = mouse.screen})
  end
end

function dmenuhelpers.pwd()
  pwdpath = "/home/raph/.wdp"
  pwdfile = awful.util.pread("cat "..pwdpath):gsub("\n", "")
  service = awful.util.pread("cat "..pwdfile.." | grep -v ^# | cut -d: -f1 | dmenu " .. dmenuopts)
  linepwd = awful.util.pread("cat "..pwdfile.." | grep -i -m1 "..service):gsub("\n", "")
  login = awful.util.pread("echo " .. linepwd .. " | cut -d: -f2"):gsub("\n", "")
  pwd = awful.util.pread("echo " .. linepwd .. " | cut -d: -f3"):gsub("\n", "")
  if login ~= "\n" and login ~= "" then
    naughty.notify({ text = "service : "..service.."login : "..login, width = 400, screen = mouse.screen})
    selectcommand = "echo '" .. pwd .. "' | xsel -i"
    awful.util.spawn_with_shell(selectcommand,false)
  end
end

return dmenuhelpers
