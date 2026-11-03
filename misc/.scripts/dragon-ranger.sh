#!/usr/bin/env bash
# dragon-ranger: minimize the terminal running ranger, open dragon-drop
# with the given files, then restore the terminal when dragon exits.
#
# Usage: dragon-ranger FILE...

set -u

if [[ $# -eq 0 ]]; then
    echo "usage: ${0##*/} FILE..." >&2
    exit 1
fi

# dragon-drop is called "dragon" on some distros
DRAGON=$(command -v dragon-drop || command -v dragon) || {
    echo "dragon-drop not found" >&2
    exit 1
}

command -v xdotool >/dev/null || {
    echo "xdotool not found" >&2
    exit 1
}

# Terminal window: $WINDOWID is exported by most terminals and is the most
# reliable; fall back to whatever window currently has focus.
win="${WINDOWID:-}"
if [[ -z $win ]]; then
    win=$(xdotool getactivewindow 2>/dev/null)
fi

restore() {
    [[ -z $win ]] && return
    if command -v awesome-client >/dev/null; then
        # Ask Awesome directly: un-minimize, raise and focus the terminal
        awesome-client "
            for _, c in ipairs(client.get()) do
                if c.window == $win then
                    c.minimized = false
                    c:emit_signal('request::activate', 'dragon-ranger', {raise = true})
                end
            end" >/dev/null 2>&1
    else
        xdotool windowactivate "$win" 2>/dev/null
    fi
}

# Restore the terminal however the script ends (drop, close, Ctrl-C)
trap restore EXIT

if [[ -n $win ]]; then
    xdotool windowminimize "$win"
fi

# -a: drag all files at once, -x: exit after a successful drop
"$DRAGON" -a -x "$@"
