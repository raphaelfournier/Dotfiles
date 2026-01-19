local awful = require("awful")
-- minimize all but the focused on
local currenttag = mouse.screen.selected_tag
for _, c in ipairs(mouse.screen.selected_tag:clients()) do
  if c ~= client.focus then
    c.minimized = true
  end
end
-- changer de layout
awful.layout.set(awful.layout.suit.tile.bottom)
awful.tag.setmwfact(0.6)
-- appeler le calendrier
local matcher = function (c) return awful.rules.match(c, {name = "Rambox"}) end
awful.client.run_or_raise('rambox', matcher)
client.focus:move_to_tag(currenttag)
