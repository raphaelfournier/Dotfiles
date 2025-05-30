VIMEXEC='vim'
MULTIPLEX='screen'
# typo
alias gti='git'
alias gv='g ci -m"vim"'
alias sl='ls'
alias mls='ls'
alias ms='ls --color=auto'
alias ks='ls --color=auto'
alias kls='ls --color=auto'

alias vmore="$VIMEXEC -u ~/.vimrc.more -"
#alias a='alsamixer -D hw:0'
alias b='bc -lq'
alias birthdays="$VIMEXEC ~/.remind/birthdays.rem"
alias c='chromium'
alias clock='tzclock  -s1000 -q -m31'
alias ttyclock='tty-clock -c -C6'
alias cdd='cd && ls -tr'
alias cde='cd ..'
alias chmoad="chmod"
alias deeptask='bla=`od -vAn -N1 -tu1 < /dev/urandom | tr -d " "`; cp Templates/template-deepwork.mdwn /tmp/deeptask$bla; mpc load korn; mpc play; vim /tmp/deeptask$bla +Goyo +'
alias ds='cd ~/downloads && ls --color -tr'
alias dsd='cd ~/downloads && ls -d */ -tr'
#alias dpsa='docker ps -a --format "table {{.ID}} {{.Names}}\t{{printf \"%.25s\" .Image}}\t{{.Status}}\t{{.Ports}}" | (read -r; printf "%s\n" "$REPLY"; sort -rk 4 )'
alias dpsa='~/.scripts/docker-sort-exitStatus.sh'
alias dsr='docker stop '
function dsr() { docker stop $@ && docker rm $@; }
alias cdc='cd ~/Current'
alias cleanOfflineimap='echo rm .offlineimap/*lock; rm .offlineimap/*lock'
#alias g='sudo netcfg labo'
alias h='sudo netcfg -r home'
alias twitter="/home/raph/.scripts/makeImageForTwitter.sh"
#alias f='feh'
alias f='firefox'
alias fz='feh -FZ'
alias g='git'
alias prets='cd /home/raph/Code/langagePython/mediathequeVillejuif-prets; source venv/bin/activate; python mediatheque-villejuif.py'
alias createVenv='python -m venv venv && source venv/bin/activate && pip install --upgrade pip && pip install -r requirements.txt'
alias gp='git pull'
alias hosts="echo sudo vim /etc/hosts && sudo vim /etc/hosts"
alias hostsAvecPub="sudo mv /etc/hosts.d/20-adaway-20180305.local /etc/hosts.d/adaway-20180305.local && sudo hosts-gen"
alias hostsSansPub="sudo mv /etc/hosts.d/adaway-20180305.local /etc/hosts.d/20-adaway-20180305.local && sudo hosts-gen"
alias hostsAvecTracking="sudo mv /etc/hosts.d/21-stevenBlack-20191017.local /etc/hosts.d/stevenBlack-20191017.local && sudo hosts-gen"
alias hostsSansTracking="sudo mv /etc/hosts.d/stevenBlack-20191017.local /etc/hosts.d/21-stevenBlack-20191017.local && sudo hosts-gen"
#alias hostsAvecFacebook="sudo mv /etc/hosts.d/11-stayfocused.local /etc/hosts.d/allow-11-stayfocused.local && sudo hosts-gen"
alias hostsAvecFacebook='echo "Get out of social networks, you slacker!"'
alias hostsSansFacebook="sudo mv /etc/hosts.d/allow-11-stayfocused.local /etc/hosts.d/11-stayfocused.local && sudo hosts-gen"
#alias l='ls --color=auto -trsh'
alias imp="impressive -T0"
alias k9='kill -9'
alias kx='kill -9 `xprop | grep PID | sed "s:^.*= ::"`'
## Show hidden files ##
alias l.='ls -d .* --color=auto'
alias l='ls -1'
alias la='ls -lha --color=auto'
alias lds='ls -trd ~/downloads/* | tail'
alias ldsc='ls -trd ~/downloads/* | tail -n1 | xclip -r && echo "In clipboard: `ls -trd ~/downloads/* | tail -n1`"'
alias lg='lazygit'
alias lh='ls --color=auto -altrh'
#alias ll='ls -lh --color=auto'
alias lla='ls -lha --color=auto'
alias lltr='ls -ltrh --color=auto'
alias lm='latexmk'
alias lmc='latexmk -c'
#alias ls='ls --g --color=auto'
alias lsc='ls --color=never'
alias lspp='ls++'
alias ltr='ls -tr --color=auto'
alias lu='lualatex -shell-escape'

#alias ls='eza'
alias ld='eza -lD'
alias lf='eza -lf --color=always | grep -v /'
alias lh='eza -dl .* --group-directories-first'
alias ll='eza -al --group-directories-first'
alias lS='eza -alf --color=always --sort=size | grep -v /'
alias lt='eza -al --sort=modified'

alias lastmeeting='vim `find  Notes/meetings/_posts -type f -printf "%T@ %p\n" | sort -n | cut -d " " -f2 | tail -n1`'
alias meetings='ranger Notes/meetings/_posts/`date +%y`/'
alias m='neomutt -F ~/.muttrc'
alias mkz='mutt -F ~/.mutt/muttrc.kz'
alias marksedit="$VIMEXEC ~/.fzf-marks +"
alias metro='feh -FZ ~/Images/plan-de-metro-bonne-definition.gif'
#alias metro='feh -FZ Images/metro/plan-metro-rer-paris-resized.png'
alias mp='mplayer'
alias mvd="find ~/downloads -type f -printf '%C@ %p\0' | sort -rz | sed -Ezn '1s/[^ ]* //p' | xargs -0 mv -i -v -t ."
alias n='ncmpcpp'
alias ping='prettyping --nolegend'
alias tt='tig status'
alias wdcopy="pwd | tr -d '\n' | xclip"
alias pwdc="pwd | tr -d '\n' | xclip"
alias clip="xclip -selection clipboard"
alias wdcd='cd `xclip -o`'
#alias preview="fzf --preview 'bat --color \"always\" {}'"
alias r='ranger'
alias rr='ranger ~/downloads .'
alias rapport='cp -rv ~/Templates/RapportCA/* .'
alias restartNginx='sudo systemctl restart nginx.service'
alias recupAttachments='ranger ~/Mail/Attachments/ ~'
alias s='tmux'
alias sfs='screen -list | grep "^\s" | sed -E "s/^\s*//" | fzf --reverse | sed -E "s/\s*\(.*$//" | xargs -o screen  -D -R'
alias sf='tmux a -t $(tmux ls | grep -oP "^.*?:" | tr -d ":" | fzf --reverse | xargs)'
alias stow='stow -v'
alias snippets="$VIMEXEC ~/.vim/mysnippets/_.snippets +"
alias ssh-add='ssh-add -t 3h'
alias tasks='sh /home/raph/scripts/task-evolution.sh'
alias t='tig'
#alias t='tree -L 1'
#alias t='todo.sh'
alias tail-cours-log="tail ~/Enseignement/Logs/cours-`date +%Y`.log.md"
alias ur='unrar'
alias u='unzip'
alias v='vim -O'
alias zds="find ~/downloads -type f -printf '%C@ %p\0' | sort -rz | sed -Ezn '1s/[^ ]* //p' | xargs -0 zathura "
alias lv='lvim'
alias vw='vim -c VimwikiIndex'
alias vifmrc='vim .config/vifm/vimfmrc'
alias vpncnam='nmcli con up id "VPN CNAM"'
alias wifimaison='nmcli connection up Livebox-E5C0'
#v() {
  #vim "$(fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
                 #echo {} is a binary file ||
                 #(highlight -O ansi -l {} ||
                  #coderay {} ||
                  #rougify {} ||
                  #cat {}) 2> /dev/null | head -500')"
#}
alias vt='vim ~/Dropbox/todo/todo.txt'
alias y='paru'
alias yt='yt-dlp'
#alias ys='paru -Syu'
#alias y='yay --nodiffmenu'
alias z='devour zathura'
alias si='sioyek'
alias mencal='mencal -3 -m --config s=20120726'
alias activateAnaconda='source /opt/anaconda/bin/activate root'
alias zlibrary='tor-browser http://bookszlibb74ugqojhzhg2a63w5i2atv5bqarulgczawnbmsb6s6qead.onion'

alias todo-devmessage="vim /home/raph/Code/langagePython/devmessage/templates/todo.html"
alias todo-geekversary="vim /home/raph/Code/langagePython/Geekversary/geekversary-django/templates/todo.html"

# screen
alias sls='screen -ls'
alias sli='screen -list'
alias s.tex='mux tex'
alias s.django='mux django'
alias s.jekyll='mux jekyll'
#alias s.tex='screen -c /home/raph/.screen/tex.screenrc'
#alias s.django='screen -c /home/raph/.screen/django.screenrc'
#alias s.jekyll='screen -c /home/raph/.screen/jekyll.screenrc'
alias screen.tex='screen -c /home/raph/.screen/tex.screenrc'
alias screen.django='screen -c /home/raph/.screen/django.screenrc'
alias screen.jekyll='screen -c /home/raph/.screen/jekyll.screenrc'

alias mysql="mariadb"

# watson
alias wt='watson'
alias today='echo "watson log --day" && watson log --day'
alias todayheures='echo "watson log --day" && unbuffer watson log --day | cut -d " " -f -7 '
alias wtweek='/usr/bin/watson log --week'
alias wtgrep='unbuffer /usr/bin/watson log --all | sed "s:^\s*::" | tr -s " " | cut -d " " -f 1,8- | sort -k2 -u | grep -i'
alias wtstopedit='/usr/bin/watson stop && /usr/bin/watson edit'
function hier() { 
  /usr/bin/watson log --week | /usr/bin/awk 'BEGIN { RS = ""; FS = OFS = "\n" }FNR == 2 { sub( /[[:space:]]+$/, "" ); print }' 
}

alias pptview='wine ~/.wine/drive_c/Program\ Files/Microsoft\ Office/Office12/PPTVIEW.EXE'
alias killnewsbeuter='kill -9 `pgrep newsb`'
#alias cgrep="grep --color=always"
alias alsamixer='alsamixer -D hw:0'
alias synchroBT='sudo /etc/rc.d/bluetooth restart && sync-ui'
alias skype='LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so skype'
alias awc="$VIMEXEC ~/.config/awesome/rc.lua"
alias awt="$VIMEXEC ~/.config/awesome/themes/myzenburn/theme.lua"
alias delhi='ssh -Y -l fournier woolthorpe.lip6.fr'
alias riazan='ssh -Y -l fournier riazan'
alias ovh='ssh -l fournier 91.121.183.150'
alias webcam-laptop='mplayer tv:// -tv driver=v4l2:device=/dev/video0:brightness=40 -fps 30'
#alias webcam='mplayer tv:// -tv driver=v4l2:device=/dev/video2:brightness=40 -vf mirror -fps 30'
alias webcam='mpv av://v4l2:/dev/video4 -vf=hflip'
alias grepc='grep --color=auto'
alias dfh="df -h | grep -v tmpfs | sed '/sdb5/i ================================================' | sed '/sdb5/a ================================================'"
alias cpuondemand='sudo cpufreq-set -g ondemand'
alias battery='ibam -a'
alias temperature='cat /proc/acpi/thermal_zone/THRM/temperature'
#alias rm='rm -i'
alias rm='rmtrash'
alias rmdir='rmdirtrash'
#alias labo='sudo iwconfig wlan0 essid "LIP6-guest" key "s:guest" && sudo dhcpcd wlan0 && sudo /etc/rc.d/cups start'
alias labo='sudo killall dhcpcd;sudo ifconfig eth0 down;sudo ifconfig eth0 hw ether 00:08:74:4B:FA:00;sudo ifconfig eth0 up; sudo dhcpcd eth0;sudo /etc/rc.d/cups start'
alias imprimante='sudo /etc/rc.d/cups start'
alias lamp='sudo /etc/rc.d/httpd start && sudo /etc/rc.d/mysqld start'
alias lsc='ls --color=never'
alias notes='vim ~/.rofi_notes'
alias tor-chromium='chromium --proxy-server="socks5://myproxy:8080" --host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE myproxy"'
alias cleantorrents='mv ~/downloads/*.torrent ~/downloads/oldtorrents/'
alias cleansub='mv ~/downloads/*.sub ~/downloads/*.ass ~/downloads/*.srt ~/downloads/Two\ and\ a\ Half\ Men* ~/downloads/The\ Mentalist* ~/downloads/The\ Big\ Bang\ Theory* ~/downloads/How\ I\ Met\ Your\ Mother* ~/downloads/NCIS* ~/downloads/Dexter* ~/downloads/Chuck* ~/downloads/Gossip\ Girl* ~/downloads/oldsrt/'
alias sendtorrents='scp ~/downloads/*.torrent 192.168.1.20:/data/watch/'
alias server='ssh rfournier.homelinux.org'
alias zhome='sudo netcfg home'
alias volume='alsamixer'
alias xrlab='xrandr --output VGA1 --auto --left-of LVDS1'
alias uploadTibre='rsync -av -l --delete /home/raph/public_html/pageperso/ fournier@tibre.lip6.fr:/home/tibre3/complexnetworks/fournier/public_html/'
alias uploadHomelinux='rsync -av -l /home/raph/public_html/pageperso/ raph@rfournier.homelinux.org:/srv/http/'
alias uploadAntipaedo='rsync -av -l ~/public_html/WebAntipaedo/antipedo/ fournier@tibre.lip6.fr:/home/tibre2/www/rp/antipedo/'
alias vgaoff='xrandr --output VGA1 --off'
alias projecteur1024x768='xrandr --output LVDS1 --mode 1024x768 --output VGA1  --mode 1024x768 --same-as LVDS1'
alias igrep='grep -i'
alias buildwiki="rsync -avz /home/raph/Meetings/ /home/raph/wiki/RaphWiki/meetings --exclude \"*pdf\"; ikiwiki --setup ~/wiki/RaphWiki.setup --verbose"
alias buildblogRFnet="cp -r /home/raph/Blogging/fusion/* /home/raph/Blogging/raphaelfournier.github.com;cd /home/raph/Blogging/raphaelfournier.github.com;git add .;git commit -am 'Latest build.';git push; cd -"
alias sshstartKeychain='keychain --eval --nogui --agents ssh -Q --quiet id_rsa'
alias alert='tput bel'
alias musique='urxvt -e ncmpcpp'
alias rmofflineImapLocks='rm ~/.offlineimap/*lock'
alias tmpdir='bar=$((1 + $RANDOM % 10)); mkdir /tmp/foobar-${bar} && cd /tmp/foobar-${bar}'

alias tasks='sh scripts/task-evolution.sh'
alias syncnokia='sudo /etc/rc.d/bluetooth restart && blueman-applet && sync-ui'
alias remspaces='ls -1 | while read file; do new_file=$(echo $file | sed s/\ //g); mv "$file" "$new_file"; done'
#awesome related aliases
alias nexttag='echo -e "local awful = require(\"awful\");awful.tag.viewnext()" | awesome-client'
alias prevtag='echo -e "local awful = require(\"awful\");awful.tag.viewprev()" | awesome-client'
alias tag1='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][1])" | awesome-client'
alias tag2='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][2])" | awesome-client'
alias tag3='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][3])" | awesome-client'
alias tag4='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][4])" | awesome-client'
alias tag5='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][5])" | awesome-client'
alias tag6='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][6])" | awesome-client'
alias tag7='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][7])" | awesome-client'
alias tag8='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][8])" | awesome-client'
alias tag9='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][9])" | awesome-client'
alias changescreen='echo -e "local awful = require(\"awful\");awful.screen.focus_relative( 1)" | awesome-client'
alias tagsNotes='for file in `find ~/Notes/meetings/_posts/ -name "*mdwn"`; do grep categories -A4 $file | tail -n+2 | grep "^- " | grep . | sed "s:- ::"; done | sort -u'
alias internetExplorer7='/usr/share/playonlinux/playonlinux --run "Internet Explorer 7"'


alias rib='zathura /home/raph/Finances/HSBC/rib_hsbc_fournier.pdf'
#
# smart SSH agent: http://beyond-syntax.com/blog/2012/01/on-demand-ssh-add/
# (see also: https://gist.github.com/1998129)
alias ssh='( ssh-add -l > /dev/null || ssh-add ) && ssh'
#alias git-push='( ssh-add -l > /dev/null || ssh-add ) && git push'
#alias git-pull='( ssh-add -l > /dev/null || ssh-add ) && git pull'
#alias git-fetch='( ssh-add -l > /dev/null || ssh-add ) && git fetch'
alias vimrc="$VIMEXEC ~/.vimrc"
alias screenrc="$VIMEXEC ~/.screenrc"
alias tmuxrc="$VIMEXEC ~/.tmux.conf"
alias tmuxconf="$VIMEXEC ~/.tmux.conf"
alias rangerconf="$VIMEXEC ~/.config/ranger/rc.conf"
alias rifleconf="$VIMEXEC ~/.config/ranger/rifle.conf"
alias zihapconf="$VIMEXEC .config/zihap/*toml -O"
alias muttrc="$VIMEXEC ~/.mutt/muttrc"
alias muttBackup="mutt -f /data/backupMails/LIP6/INBOX -F ~/.muttrc"
alias alacrittyconf="$VIMEXEC ~/.config/alacritty/alacritty.toml"
alias xdefaults="$VIMEXEC /home/raph/.config/Xresources/Xdefaults"
alias cfp="$VIMEXEC .remind/cfp.rem"
alias magi='ssh cluster-magi'
alias soffice='soffice --norestore'
alias phone-connect="mtpfs -o allow_other /media/WinPhone8"
alias phone-disconnect="fusermount -u /media/WinPhone8"

alias tried-next-meetingnotes='vim ~/Notes/pro/tried/prochaine-reunion.mdwn'
#alias tmusic='tmux new-session -s $$ "tmux source-file ~/.ncmpcpp/tsession"'
#_trap_exit() { tmux kill-session -t $$; }

# git protipz - from https://github.com/notwaldorf/.not-quite-dotfiles/blob/master/aliases
alias gst="git status -sb"
alias ga="git add"
alias gaa="git add -A"
alias gcm="git commit -m"
alias gpl="git pull"
alias gps="git push"
alias glg="g lg"
alias gll="git log --graph --date=short --pretty=format:'%Cgreen%h %Cblue%cd (%cr) %Cred%an%C(yellow)%d%Creset: %s'"
alias glll="git log --graph --stat --date=short --pretty=format:'%Cgreen%h %Cblue%cd (%cr) %Cred%an%C(yellow)%d%Creset: %s'"
alias gundo="git checkout"
alias gdiff="git diff"
alias greset="git reset HEAD"
alias goops="git reset --hard HEAD"
alias gsh="git stash"
alias gnuke="git branch -D"
alias gbr="git checkout -b"
alias gba="git branch -a"
alias squish="git commit -a --amend -C HEAD"
alias usblabo="mount /mnt/usblabo/ && cd /mnt/usblabo/ && ls"

alias basex="/usr/share/java/basex/bin/basexgui"
alias pmac="xmodmap ~/.Xmodmapmac"
alias pcnam="xmodmap ~/.Xmodmapcnam"
alias swapescape="xmodmap ~/.Xmodmap-swapCapsEscape"
alias ncmpcppmaxblack="ncmpcpp -h maxblack"

alias lsFiles="find . -maxdepth 1 -type f -a ! -iname '\.*' -print0 | sed \"s:\.\/::g\" | xargs -0r ls --color=auto"
alias lsFilesAll="find . -maxdepth 1 -type f -a ! -iname '\.*' -print0 | sed \"s:\.\/::g\" | xargs -0r ls --color=auto"
alias lsDirectories="find . -maxdepth 1 -type d -a ! -iname '\.*' -print0 | sed \"s:\.\/::g\" | xargs -0r ls --color=auto -d"
alias lsdd="ls -d */"
#alias listeFenetres="wmctrl -lpG | sort -k2,2n"
alias updateArch="yaourt -S --sysupgrade --aur --noconfirm"

alias awesomeElenapan="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/Elenapan awesome; cd ; echo \"awesome.restart()\" | awesome-client"
alias awesomeZenburn="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/zenburnClassic awesome; cd ; echo \"awesome.restart()\" | awesome-client"
alias awesomeWorronBlue="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/Worron awesome; cd ; echo \"awesome.restart()\" | awesome-client"
alias awesomeRFSWorpan="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/rfsWorpan awesome; cd ; echo \"awesome.restart()\" | awesome-client"

export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(vim {})+abort'"

alias youtube-mp3='youtube-dl -x --audio-format mp3'
alias tailleCorbeille='du -sh ~/.local/share/Trash/'
alias muttaliases='vim ~/.mutt/aliases +'
alias aliases='vim ~/.bash_aliases'
alias marks-check='for line in `cut -d":" -f2 /home/raph/.fzf-marks`; do [[ ! -d $line ]] && echo "pas de : $line"; done'
alias meteoVillejuif='links http://wttr.in/villejuif'
alias garminStats='garmindb_cli.py --download --import --latest --analyze && python /home/raph/Code/langagePython/GarminPerso/lastStats.py'

alias doc2pdf='lowriter --headless --convert-to pdf'
alias oldLaptop='cd /data/daria-2022-10-09/'
alias mux='tmuxinator'
alias muxconf='cd ~/.config/tmuxinator/'
#alias trains='zathura /home/raph/Perso/Rennes/HorairesTrainsRennesParis.pdf'
alias codir='vim /home/raph/Recherche/LIP6/DirectionEquipeCN/JournalComnet.mdwn +'
alias permanents="cat /home/raph/Recherche/LIP6/DirectionEquipeCN/Machines/Site_Web/sauvegardes_mailing_lists/2025_janvier/export_permanents-2025-01-29_10_09_40.csv"
