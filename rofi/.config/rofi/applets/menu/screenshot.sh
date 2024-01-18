#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

style="$($HOME/.config/rofi/applets/menu/style.sh)"

dir="$HOME/.config/rofi/applets/menu/configs/$style"
rofi_command="rofi -theme $dir/screenshot.rasi"

# Error msg
msg() {
	rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "Please install 'scrot' first."
}

# Options
screen=""
area=""
window=""
flameshot="🔥"
screendelay="5"

# Variable passed to rofi
options="$screen\n$area\n$flameshot\n$window\n$screendelay"

chosen="$(echo -e "$options" | $rofi_command -p 'App : scrot' -dmenu -selected-row 1)"
case $chosen in
    $flameshot)
		if [[ -f /usr/bin/flameshot ]]; then
			flameshot gui;
		else
			msg
		fi
        ;;
    $screen)
		if [[ -f /usr/bin/scrot ]]; then
			sleep 1; scrot 'Screenshot_%Y-%m-%d-%S_$wx$h.png' -e 'mv $f $$(xdg-user-dir PICTURES)/Screenshots/ ; alacritty -e ranger $$(xdg-user-dir PICTURES)/Screenshots/'
		else
			msg
		fi
        ;;
    $screendelay)
		if [[ -f /usr/bin/scrot ]]; then
			sleep 1; scrot -d 5 'Screenshot_%Y-%m-%d-%S_$wx$h.png' -e 'mv $f $$(xdg-user-dir PICTURES)/Screenshots/ ; alacritty -e ranger $$(xdg-user-dir PICTURES)/Screenshots/'
		else
			msg
		fi
        ;;
    $area)
		if [[ -f /usr/bin/scrot ]]; then
			scrot -s -lwidth=6,color="#10e0d6" 'Screenshot_%Y-%m-%d-%S_$wx$h.png' -e 'mv $f $$(xdg-user-dir PICTURES)/Screenshots/ ; alacritty -e ranger $$(xdg-user-dir PICTURES)/Screenshots/'
		else
			msg
		fi
        ;;
    $window)
		if [[ -f /usr/bin/scrot ]]; then
			sleep 1; scrot -u 'Screenshot_%Y-%m-%d-%S_$wx$h.png' -e 'mv $f $$(xdg-user-dir PICTURES)/Screenshots/ ; alacritty -e ranger $$(xdg-user-dir PICTURES)/Screenshots/'
		else
			msg
		fi
        ;;
esac

