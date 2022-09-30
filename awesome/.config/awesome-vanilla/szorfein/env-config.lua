local naughty = require("naughty")
local env = {}

env.term = os.getenv("TERMINAL") or "xst"
env.editor = os.getenv("EDITOR") or "vim"

-- Bellow are arguments to call a <class> and <exec> a program by terminal
-- post an issue if your terminal is not listed or to add new

if env.term:match('xst') == 'xst' then
  env.term_call = { " -c ", " -e " }
elseif env.term:match('rxvt') == 'rxvt' then
  env.term_call = { " -T ", " -e " }
elseif env.term:match('kitty') == 'kitty' then
  env.term_call = { " --class=" , " -e " }
else
  naughty.notify({ title = 'Warning!', text = 'Your terminal is not recognized!' })
end

env.editor_cmd = env.term .. env.term_call[2] .. env.editor

return env
