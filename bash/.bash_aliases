VIMEXEC='vim'
MULTIPLEX='screen'

alias activateAnaconda='source /opt/anaconda/bin/activate root'
alias alacrittyconf="$VIMEXEC ~/.config/alacritty/alacritty.toml"
alias alert='tput bel'
alias aliases='vim ~/.bash_aliases'
alias alsamixer='alsamixer -D hw:0'
alias audio-restart-server="systemctl --user restart pipewire pipewire-pulse wireplumber"
alias awc="$VIMEXEC ~/.config/awesome/rc.lua"
alias awesomeElenapan="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/Elenapan awesome; cd ; echo \"awesome.restart()\" | awesome-client"
alias awesomeRFSWorpan="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/rfsWorpan awesome; cd ; echo \"awesome.restart()\" | awesome-client"
alias awesomeWorronBlue="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/Worron awesome; cd ; echo \"awesome.restart()\" | awesome-client"
alias awesomeZenburn="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/zenburnClassic awesome; cd ; echo \"awesome.restart()\" | awesome-client"
alias awt="$VIMEXEC ~/.config/awesome/themes/myzenburn/theme.lua"
alias b='bc -lq'
alias basex="/usr/share/java/basex/bin/basexgui"
alias bashaliases='vim ~/.bash_aliases'
alias battery='ibam -a'
alias birthdays="$VIMEXEC ~/.remind/birthdays.rem"
alias buildblogRFnet="cp -r /home/raph/Blogging/fusion/* /home/raph/Blogging/raphaelfournier.github.com;cd /home/raph/Blogging/raphaelfournier.github.com;git add .;git commit -am 'Latest build.';git push; cd -"
alias buildwiki="rsync -avz /home/raph/Meetings/ /home/raph/wiki/RaphWiki/meetings --exclude \"*pdf\"; ikiwiki --setup ~/wiki/RaphWiki.setup --verbose"
alias c='chromium'
alias cdc='cd ~/Current'
alias cdd='cd && ls -tr'
alias cde='cd ..'
alias cfp="$VIMEXEC .remind/cfp.rem"
alias changescreen='echo -e "local awful = require(\"awful\");awful.screen.focus_relative( 1)" | awesome-client'
alias chmoad="chmod"
alias chmox='chmod +x'
alias cleanOfflineimap='echo rm .offlineimap/*lock; rm .offlineimap/*lock'
alias cleansub='mv ~/downloads/*.sub ~/downloads/*.ass ~/downloads/*.srt ~/downloads/Two\ and\ a\ Half\ Men* ~/downloads/The\ Mentalist* ~/downloads/The\ Big\ Bang\ Theory* ~/downloads/How\ I\ Met\ Your\ Mother* ~/downloads/NCIS* ~/downloads/Dexter* ~/downloads/Chuck* ~/downloads/Gossip\ Girl* ~/downloads/oldsrt/'
alias cleantorrents='mv ~/downloads/*.torrent ~/downloads/oldtorrents/'
alias clip="xclip -selection clipboard"
alias clock='tzclock  -s1000 -q -m31'
alias codir='vim /home/raph/Recherche/LIP6/DirectionEquipeCN/JournalComnet.mdwn +'
alias cpuondemand='sudo cpufreq-set -g ondemand'
alias createVenv='uv venv && source .venv/bin/activate && uv pip install -r requirements.txt'
alias deeptask='bla=`od -vAn -N1 -tu1 < /dev/urandom | tr -d " "`; cp Templates/template-deepwork.mdwn /tmp/deeptask$bla; mpc load korn; mpc play; vim /tmp/deeptask$bla +Goyo +'
alias delhi='ssh -Y -l fournier woolthorpe.lip6.fr'
alias dfh="df -h | grep -v tmpfs | sed '/sdb5/i ================================================' | sed '/sdb5/a ================================================'"
alias doc2pdf='lowriter --headless --convert-to pdf'
alias dpsa='~/.scripts/docker-sort-exitStatus.sh'
alias ds='cd ~/downloads && ls --color -tr'
alias dsd='cd ~/downloads && ls -d */ -tr'
alias dsr='docker stop '
alias ecrans="xrandr | grep ' connected'"
alias f='firefox'
alias fz='feh -FZ'
alias g='git'
alias ga="git add"
alias gaa="git add -A"
alias garminStats='garmindb_cli.py --download --import --latest --analyze && python /home/raph/Code/langagePython/GarminPerso/lastStats.py'
alias gba="git branch -a"
alias gbr="git checkout -b"
alias gcm="git commit -m"
alias gdiff="git diff"
alias glg="g lg"
alias gll="git log --graph --date=short --pretty=format:'%Cgreen%h %Cblue%cd (%cr) %Cred%an%C(yellow)%d%Creset: %s'"
alias glll="git log --graph --stat --date=short --pretty=format:'%Cgreen%h %Cblue%cd (%cr) %Cred%an%C(yellow)%d%Creset: %s'"
alias gnuke="git branch -D"
alias goops="git reset --hard HEAD"
alias gp='git pull'
alias gpl="git pull"
alias gps="git push"
alias grepc='grep --color=auto'
alias greset="git reset HEAD"
alias gsh="git stash"
alias gst="git status -sb"
alias gti='git'
alias gundo="git checkout"
alias gv='g ci -m"vim"'
alias h='sudo netcfg -r home'
alias hosts="echo sudo vim /etc/hosts && sudo vim /etc/hosts"
alias hostsAvecFacebook='echo "Get out of social networks, you slacker!"'
alias hostsAvecPub="sudo mv /etc/hosts.d/20-adaway-20180305.local /etc/hosts.d/adaway-20180305.local && sudo hosts-gen"
alias hostsAvecTracking="sudo mv /etc/hosts.d/21-stevenBlack-20191017.local /etc/hosts.d/stevenBlack-20191017.local && sudo hosts-gen"
alias hostsSansFacebook="sudo mv /etc/hosts.d/allow-11-stayfocused.local /etc/hosts.d/11-stayfocused.local && sudo hosts-gen"
alias hostsSansPub="sudo mv /etc/hosts.d/adaway-20180305.local /etc/hosts.d/20-adaway-20180305.local && sudo hosts-gen"
alias hostsSansTracking="sudo mv /etc/hosts.d/stevenBlack-20191017.local /etc/hosts.d/21-stevenBlack-20191017.local && sudo hosts-gen"
alias igrep='grep -i'
alias imp="impressive -T0"
alias imprimante='sudo /etc/rc.d/cups start'
alias internetExplorer7='/usr/share/playonlinux/playonlinux --run "Internet Explorer 7"'
alias k9='kill -9'
alias killnewsbeuter='kill -9 `pgrep newsb`'
alias kls='ls --color=auto'
alias ks='ls --color=auto'
alias kx='kill -9 `xprop | grep PID | sed "s:^.*= ::"`'
alias l.='ls -d .* --color=auto'
alias l='ls -1'
alias lS='eza -alf --color=always --sort=size | grep -v /'
alias la='ls -lha --color=auto'
alias labo='sudo killall dhcpcd;sudo ifconfig eth0 down;sudo ifconfig eth0 hw ether 00:08:74:4B:FA:00;sudo ifconfig eth0 up; sudo dhcpcd eth0;sudo /etc/rc.d/cups start'
alias lamp='sudo /etc/rc.d/httpd start && sudo /etc/rc.d/mysqld start'
alias lastmeeting='vim `find  Notes/meetings/_posts -type f -printf "%T@ %p\n" | sort -n | cut -d " " -f2 | tail -n1`'
alias ld='eza -lD'
alias lds='ls -trd ~/downloads/* | tail'
alias ldsc='ls -trd ~/downloads/* | tail -n1 | xclip -r && echo "In clipboard: `ls -trd ~/downloads/* | tail -n1`"'
alias lf='eza -lf --color=always | grep -v /'
alias lg='lazygit'
alias lh='eza -dl .* --group-directories-first'
alias lh='ls --color=auto -altrh'
alias ll='eza -al --group-directories-first'
alias lla='ls -lha --color=auto'
alias lltr='ls -ltrh --color=auto'
alias lm='latexmk'
alias lmc='latexmk -c'
alias lms='ls'
alias lr='ls -R'
alias lrt='ls -tr --color=auto'
alias lsDirectories="find . -maxdepth 1 -type d -a ! -iname '\.*' -print0 | sed \"s:\.\/::g\" | xargs -0r ls --color=auto -d"
alias lsFiles="find . -maxdepth 1 -type f -a ! -iname '\.*' -print0 | sed \"s:\.\/::g\" | xargs -0r ls --color=auto"
alias lsFilesAll="find . -maxdepth 1 -type f -a ! -iname '\.*' -print0 | sed \"s:\.\/::g\" | xargs -0r ls --color=auto"
alias lsc='ls --color=never'
alias lsc='ls --color=never'
alias lsdd="ls -d */"
alias lspp='ls++'
alias lt='eza -al --sort=modified'
alias ltr='ls -tr --color=auto'
alias lu='lualatex -shell-escape'
alias lv='lvim'
alias m='neomutt -F ~/.muttrc'
alias magi='ssh cluster-magi'
alias marks-check='for line in `cut -d":" -f2 /home/raph/.fzf-marks`; do [[ ! -d $line ]] && echo "pas de : $line"; done'
alias marksedit="$VIMEXEC ~/.fzf-marks +"
alias meetings='ranger Notes/meetings/_posts/`date +%y`/'
alias mencal='mencal -3 -m --config s=20120726'
alias meteoVillejuif='links http://wttr.in/villejuif'
alias metro='feh -FZ ~/Images/plan-de-metro-bonne-definition.gif'
alias mkz='mutt -F ~/.mutt/muttrc.kz'
alias mls='ls'
alias mp='mplayer'
alias ms='ls --color=auto'
alias musique='urxvt -e ncmpcpp'
alias muttBackup="mutt -f /data/backupMails/LIP6/INBOX -F ~/.muttrc"
alias muttaliases='vim ~/.mutt/aliases +'
alias muttrc="$VIMEXEC ~/.mutt/muttrc"
alias mux='tmuxinator'
alias muxconf='cd ~/.config/tmuxinator/'
alias mvd="find ~/downloads -type f -printf '%C@ %p\0' | sort -rz | sed -Ezn '1s/[^ ]* //p' | xargs -0 mv -i -v -t ."
alias mysql="mariadb"
alias n2='ncmpcpp -c ~/.config/ncmpcpp/config-macmini'
alias n='ncmpcpp'
alias ncmpcppmaxblack="ncmpcpp -h maxblack"
alias nexttag='echo -e "local awful = require(\"awful\");awful.tag.viewnext()" | awesome-client'
alias notes='vim ~/.rofi_notes'
alias nv='nvim'
alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim'
alias oldLaptop='cd /data/daria-2022-10-09/'
alias ovh='ssh -l fournier 91.121.183.150'
alias pandoc.1column='pandoc --defaults=simpledoc.yaml '
alias pandoc.2columns='pandoc --defaults simpledoc-doublecolumn.yaml '
alias pcnam="xmodmap ~/.Xmodmapcnam"
alias permanents="cat /home/raph/Recherche/LIP6/DirectionEquipeCN/Machines/Site_Web/sauvegardes_mailing_lists/2025_janvier/export_permanents-2025-01-29_10_09_40.csv"
alias phone-connect="mtpfs -o allow_other /media/WinPhone8"
alias phone-disconnect="fusermount -u /media/WinPhone8"
alias ping='prettyping --nolegend'
alias pmac="xmodmap ~/.Xmodmapmac"
alias pptview='wine ~/.wine/drive_c/Program\ Files/Microsoft\ Office/Office12/PPTVIEW.EXE'
alias prets='cd /home/raph/Code/langagePython/mediathequeVillejuif-prets; source venv/bin/activate; python mediatheque-villejuif.py'
alias prevtag='echo -e "local awful = require(\"awful\");awful.tag.viewprev()" | awesome-client'
alias projecteur1024x768='xrandr --output LVDS1 --mode 1024x768 --output VGA1  --mode 1024x768 --same-as LVDS1'
alias pwdc="pwd | tr -d '\n' | xclip"
alias r='ranger'
alias rangerconf="$VIMEXEC ~/.config/ranger/rc.conf"
alias rapport='cp -rv ~/Templates/RapportCA/* .'
alias recupAttachments='ranger ~/Mail/Attachments/ ~'
alias remspaces='ls -1 | while read file; do new_file=$(echo $file | sed s/\ //g); mv "$file" "$new_file"; done'
alias restartNginx='sudo systemctl restart nginx.service'
alias riazan='ssh -Y -l fournier riazan'
alias rib='zathura /home/raph/Finances/HSBC/rib_hsbc_fournier.pdf'
alias rifleconf="$VIMEXEC ~/.config/ranger/rifle.conf"
alias rm='rmtrash'
alias rmdir='rmdirtrash'
alias rmofflineImapLocks='rm ~/.offlineimap/*lock'
alias rr='ranger ~/downloads .'
alias s.django='mux django'
alias s.jekyll='mux jekyll'
alias s.tex='mux tex'
alias s='tmux'
alias screen.django='screen -c /home/raph/.screen/django.screenrc'
alias screen.jekyll='screen -c /home/raph/.screen/jekyll.screenrc'
alias screen.tex='screen -c /home/raph/.screen/tex.screenrc'
alias screenrc="$VIMEXEC ~/.screenrc"
alias sendtorrents='scp ~/downloads/*.torrent 192.168.1.20:/data/watch/'
alias server='ssh rfournier.homelinux.org'
alias sf='tmux a -t $(tmux ls | grep -oP "^.*?:" | tr -d ":" | fzf --reverse | xargs)'
alias sfs='screen -list | grep "^\s" | sed -E "s/^\s*//" | fzf --reverse | sed -E "s/\s*\(.*$//" | xargs -o screen  -D -R'
alias si='sioyek'
alias skype='LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so skype'
alias sl='ls'
alias sli='screen -list'
alias sls='screen -ls'
alias snippets="$VIMEXEC ~/.vim/mysnippets/_.snippets +"
alias soffice='soffice --norestore'
alias squish="git commit -a --amend -C HEAD"
alias ssh-add='ssh-add -t 3h'
alias ssh='( ssh-add -l > /dev/null || ssh-add ) && ssh'
alias sshstartKeychain='keychain --eval --nogui --agents ssh -Q --quiet id_rsa'
alias stow='stow -v'
alias swapescape="xmodmap ~/.Xmodmap-swapCapsEscape"
alias synchroBT='sudo /etc/rc.d/bluetooth restart && sync-ui'
alias syncnokia='sudo /etc/rc.d/bluetooth restart && blueman-applet && sync-ui'
alias t='tig'
alias tag1='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][1])" | awesome-client'
alias tag2='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][2])" | awesome-client'
alias tag3='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][3])" | awesome-client'
alias tag4='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][4])" | awesome-client'
alias tag5='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][5])" | awesome-client'
alias tag6='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][6])" | awesome-client'
alias tag7='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][7])" | awesome-client'
alias tag8='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][8])" | awesome-client'
alias tag9='echo -e "local awful = require(\"awful\");awful.tag.viewonly(tags[1][9])" | awesome-client'
alias tagsNotes='for file in `find ~/Notes/meetings/_posts/ -name "*mdwn"`; do grep categories -A4 $file | tail -n+2 | grep "^- " | grep . | sed "s:- ::"; done | sort -u'
alias tail-cours-log="tail ~/Enseignement/Logs/cours-`date +%Y`.log.md"
alias tailleCorbeille='du -sh ~/.local/share/Trash/'
alias tasks='sh /home/raph/scripts/task-evolution.sh'
alias tasks='sh scripts/task-evolution.sh'
alias temperature='cat /proc/acpi/thermal_zone/THRM/temperature'
alias tmpdir='bar=$((1 + $RANDOM % 10)); mkdir /tmp/foobar-${bar} && cd /tmp/foobar-${bar}'
alias tmuxconf="$VIMEXEC ~/.tmux.conf"
alias tmuxrc="$VIMEXEC ~/.tmux.conf"
alias today='echo "watson log --day" && watson log --day'
alias todayheures='echo "watson log --day" && unbuffer watson log --day | cut -d " " -f -7 '
alias todo-devmessage="vim /home/raph/Code/langagePython/devmessage/templates/todo.html"
alias todo-geekversary="vim /home/raph/Code/langagePython/Geekversary/geekversary-django/templates/todo.html"
alias tor-chromium='chromium --proxy-server="socks5://myproxy:8080" --host-resolver-rules="MAP * ~NOTFOUND , EXCLUDE myproxy"'
alias tried-next-meetingnotes='vim ~/Notes/pro/tried/prochaine-reunion.mdwn'
alias tt='tig status'
alias ttyclock='tty-clock -c -C6'
alias tue='kill -9 '
alias twitter="/home/raph/.scripts/makeImageForTwitter.sh"
alias u='unzip'
alias updateArch="yaourt -S --sysupgrade --aur --noconfirm"
alias uploadAntipaedo='rsync -av -l ~/public_html/WebAntipaedo/antipedo/ fournier@tibre.lip6.fr:/home/tibre2/www/rp/antipedo/'
alias uploadHomelinux='rsync -av -l /home/raph/public_html/pageperso/ raph@rfournier.homelinux.org:/srv/http/'
alias uploadTibre='rsync -av -l --delete /home/raph/public_html/pageperso/ fournier@tibre.lip6.fr:/home/tibre3/complexnetworks/fournier/public_html/'
alias ur='unrar'
alias usblabo="mount /mnt/usblabo/ && cd /mnt/usblabo/ && ls"
alias v='vim -O'
alias vgaoff='xrandr --output VGA1 --off'
alias vifmrc='vim .config/vifm/vimfmrc'
alias vimMD='F=$(fd "(.md*)$" | fzf ) && vim $F'
alias vimrc="$VIMEXEC ~/.vimrc"
alias vmore="$VIMEXEC -u ~/.vimrc.more -"
alias volume='alsamixer'
alias vom='vim'
alias vpncnam='nmcli con up id "VPN CNAM"'
alias vt='vim ~/Dropbox/todo/todo.txt'
alias vv='nvim'
alias vvv='nvim ~/.config/nvim/init.lua'
alias vw='vim -c VimwikiIndex'
alias wdcd='cd `xclip -o`'
alias wdcopy="pwd | tr -d '\n' | xclip"
alias webcam-laptop='mplayer tv:// -tv driver=v4l2:device=/dev/video0:brightness=40 -fps 30'
alias webcam='mpv av://v4l2:/dev/video4 -vf=hflip'
alias wifimaison='nmcli connection up Livebox-E5C0'
alias wt='watson'
alias wtgrep='unbuffer /usr/bin/watson log --all | sed "s:^\s*::" | tr -s " " | cut -d " " -f 1,8- | sort -k2 -u | grep -i'
alias wtstopedit='/usr/bin/watson stop && /usr/bin/watson edit'
alias wtweek='/usr/bin/watson log --week'
alias xdefaults="$VIMEXEC /home/raph/.config/Xresources/Xdefaults"
alias xrlab='xrandr --output VGA1 --auto --left-of LVDS1'
alias y='paru'
alias yt-mp3='yt-dlp -x --audio-format mp3 -o "/home/raph/Musique/Youtube/%(title)s_%(id)s.%(ext)s" '
alias yt='yt-dlp'
alias z='devour zathura'
alias zatPDF='F=$(fd "(epub|pdf)$" ~/Pdf /home/raph/Cloud/NextcloudFS/A-INBOX | sort | rofi -dmenu -i -fullscreen -p "PDF :") && zathura $'
alias zds="find ~/downloads -type f -printf '%C@ %p\0' | sort -rz | sed -Ezn '1s/[^ ]* //p' | xargs -0 zathura "
alias zhome='sudo netcfg home'
alias zihapconf="$VIMEXEC .config/zihap/*toml -O"
alias zlibrary='tor-browser http://bookszlibb74ugqojhzhg2a63w5i2atv5bqarulgczawnbmsb6s6qead.onion'
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(vim {})+abort'"
function dsr() { docker stop $@ && docker rm $@; }
function hier() { 
}
alias copyMyBiblioHere="cp /home/raph/Publications/Blogging/sbadmin2/bibliography/mybiblio.bib ."
