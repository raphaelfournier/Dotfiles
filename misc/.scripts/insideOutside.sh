#! /bin/bash

file="/home/raph/.insideOutside"

if [ $# -eq 0 ]
then
  inOut=`cat $file`
  if [ $inOut = 'in' ]; then
    echo "we're in; moving outside !"
    notify-send "Inside-Outside" "we're in; moving outside !"
    echo "out" > $file # read by vim
    sed -i --follow-symlinks "2 s:^:#:" ~/.config/bat/config
    sed -i --follow-symlinks "3 s:^#::" ~/.config/bat/config
    #sed -i --follow-symlinks "185,187 s:^#::" ~/.zshrc # toggle in zshrc
    sed -i --follow-symlinks "/ayu_light/ s:^#::" ~/.config/alacritty/alacritty.toml # toggle in alacritty
    sed -i --follow-symlinks "/zenburn/ s:^:#:" ~/.config/alacritty/alacritty.toml # toggle in alacritty
    sed -i --follow-symlinks "/zenburn.in/ s:^:#:" ~/.muttrc # toggle in muttrc
    sed -i --follow-symlinks "/zenburn.out/ s:^#::" ~/.muttrc # toggle in muttrc
    sed -i --follow-symlinks "/raph.outside/ s:^#::" ~/.muttrc
    sed -i --follow-symlinks "/colors.zenburn/ s:^:!:" ~/.Xresources
    sed -i --follow-symlinks "/colors.papercolor/ s:^!::" ~/.Xresources
    sed -i --follow-symlinks "/outside/ s:^#::" ~/.screen/colors.status.screenrc
    sed -i --follow-symlinks "/inside/ s:^:#:" ~/.screen/colors.status.screenrc
    #sed -i --follow-symlinks "/light/ s:^#::" ~/.config/rofi/config
    #sed -i --follow-symlinks "/dark/ s:^:#:" ~/.config/rofi/config
    sed -i --follow-symlinks "/outside/ s:^#::" ~/.oh-my-zsh/themes/rfs.zsh-theme
    sed -i --follow-symlinks "/inside/ s:^:#:" ~/.oh-my-zsh/themes/rfs.zsh-theme
    sed -i --follow-symlinks "/rprompt-outside/ s:^#::" ~/.zshrc
    sed -i --follow-symlinks "/rprompt-inside/ s:^:#:" ~/.zshrc
    xrdb -load ~/.Xresources
    rm ~/.ncmpcpp/config; ln -s ~/.ncmpcpp/config-light ~/.ncmpcpp/config
  else
    echo "we're out; moving inside"
    notify-send "Inside-Outside" "we're out; moving inside"
    echo "in" > $file
    sed -i --follow-symlinks "2 s:^#::" ~/.config/bat/config
    sed -i --follow-symlinks "3 s:^:#:" ~/.config/bat/config
    #sed -i --follow-symlinks "185,187 s:^:#:" ~/.zshrc
    sed -i --follow-symlinks "/ayu_light/ s:^:#:" ~/.config/alacritty/alacritty.toml # toggle in alacritty
    sed -i --follow-symlinks "/zenburn/ s:^#::" ~/.config/alacritty/alacritty.toml # toggle in alacritty
    sed -i --follow-symlinks "/raph.wal/ s:^#::" ~/.muttrc
    sed -i --follow-symlinks "/zenburn.out/ s:^:#:" ~/.muttrc # toggle in muttrc
    sed -i --follow-symlinks "/zenburn.in/ s:^#::" ~/.muttrc # toggle in muttrc
    sed -i --follow-symlinks "/raph.outside/ s:^:#:" ~/.muttrc
    sed -i --follow-symlinks "/colors.zenburn/ s:^!::" ~/.Xresources
    sed -i --follow-symlinks "/colors.papercolor/ s:^:!:" ~/.Xresources
    sed -i --follow-symlinks "/outside/ s:^:#:" ~/.screen/colors.status.screenrc
    sed -i --follow-symlinks "/inside/ s:^#::" ~/.screen/colors.status.screenrc
    #sed -i --follow-symlinks "/light/ s:^:#:" ~/.config/rofi/config
    #sed -i --follow-symlinks "/dark/ s:^#::" ~/.config/rofi/config
    sed -i --follow-symlinks "/outside/ s:^:#:" ~/.oh-my-zsh/themes/rfs.zsh-theme
    sed -i --follow-symlinks "/inside/ s:^#::" ~/.oh-my-zsh/themes/rfs.zsh-theme
    sed -i --follow-symlinks "/rprompt-outside/ s:^:#:" ~/.zshrc
    sed -i --follow-symlinks "/rprompt-inside/ s:^#::" ~/.zshrc
    #dynamic-colors switch zenburn
    xrdb -load ~/.Xresources
    rm ~/.ncmpcpp/config; ln -s ~/.ncmpcpp/config-dark ~/.ncmpcpp/config
  fi
else
  cat $file
fi


# wal -f ~/Configurations/PywalThemes/dark/zenburn.json
# wal -l -f Configurations/PywalThemes/light/base16-solarized.json

