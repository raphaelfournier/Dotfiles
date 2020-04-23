# typo
alias gti='git'
alias sl='ls'
alias mls='ls'
alias ms='ls --color=auto'
alias ks='ls --color=auto'
alias kls='ls --color=auto'

alias a='alsamixer -D hw:0'
alias b='bc -lq'
alias c='chromium'
alias cat='bat'
alias clock='tty-clock -c -C6'
alias cdd='cd && ls -tr'
alias chmoad="chmod"
alias ds='cd ~/downloads && ls -tr'
alias cdc='cd ~/Current'
alias cleanOfflineimap='echo rm .offlineimap/*lock; rm .offlineimap/*lock'
#alias g='sudo netcfg labo'
alias h='sudo netcfg -r home'
alias f='feh'
alias g='git'
alias gp='git pull'
alias hosts="echo sudo vim /etc/hosts && sudo vim /etc/hosts"
alias hostsAvecPub="sudo mv /etc/hosts.d/20-adaway-20180305.local /etc/hosts.d/adaway-20180305.local && sudo hosts-gen"
alias hostsSansPub="sudo mv /etc/hosts.d/adaway-20180305.local /etc/hosts.d/20-adaway-20180305.local && sudo hosts-gen"
#alias hostsAvecFacebook="sudo mv /etc/hosts.d/11-stayfocused.local /etc/hosts.d/allow-11-stayfocused.local && sudo hosts-gen"
alias hostsAvecFacebook='echo "Get out of social networks, you slacker!"'
alias hostsSansFacebook="sudo mv /etc/hosts.d/allow-11-stayfocused.local /etc/hosts.d/11-stayfocused.local && sudo hosts-gen"
#alias l='ls --color=auto -trsh'
alias l='ls -1'
alias lh='ls --color=auto -altrh'
alias la='ls -lha --color=auto'
alias ll='ls -lh --color=auto'
alias lla='ls -lha --color=auto'
alias lltr='ls -ltrh --color=auto'
alias lsc='ls --color=never'
alias lu='lualatex -shell-escape'
## Show hidden files ##
alias l.='ls -d .* --color=auto'
alias lm='latexmk'
alias lmc='latexmk -c'
alias ltr='ls -tr --color=auto'
alias ls='ls --g --color=auto'
alias lspp='ls++'
alias m='neomutt -F ~/.muttrc'
alias mkz='mutt -F ~/.mutt/muttrc.kz'
alias metro='feh -FZ ~/Images/plan-de-metro-bonne-definition.gif'
#alias metro='feh -FZ Images/metro/plan-metro-rer-paris-resized.png'
alias mp='mplayer'
alias n='ncmpcpp'
alias ping='prettyping --nolegend'
#alias preview="fzf --preview 'bat --color \"always\" {}'"
alias r='ranger'
alias restartNginx='sudo systemctl restart nginx.service'
alias recupAttachments='ranger ~/Mail/Attachments/ ~'
alias s='screen'
alias stow='stow -v'
alias snippets='vim ~/.vim/mysnippets/_.snippets'
alias ssh-add='ssh-add -t 3h'
alias tasks='sh /home/raph/scripts/task-evolution.sh'
alias t='tree -L 1'
#alias t='todo.sh'
alias ur='unrar'
alias u='unzip'
alias v='vim'
#v() {
  #vim "$(fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
                 #echo {} is a binary file ||
                 #(highlight -O ansi -l {} ||
                  #coderay {} ||
                  #rougify {} ||
                  #cat {}) 2> /dev/null | head -500')"
#}
alias vt='vim ~/Dropbox/todo/todo.txt'
#alias y='yaourt'
alias y='yay --nodiffmenu'
alias z='zathura'
alias mencal='mencal -3 -m --config s=20120726'
alias screen.tex='screen -c /home/raph/.screen/tex.screenrc'
alias screen.django='screen -c /home/raph/.screen/django.screenrc'
alias screen.jekyll='screen -c /home/raph/.screen/jekyll.screenrc'
alias activateAnaconda='source /opt/anaconda/bin/activate root'

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
alias cgrep="grep --color=always"
alias alsamixer='alsamixer -D hw:0'
alias synchroBT='sudo /etc/rc.d/bluetooth restart && sync-ui'
alias skype='LD_PRELOAD=/usr/lib/libv4l/v4l1compat.so skype'
alias awc='vim ~/.config/awesome/rc.lua'
alias awt='vim ~/.config/awesome/themes/zenburn/theme.lua'
alias delhi='ssh -Y -l fournier woolthorpe.lip6.fr'
alias riazan='ssh -Y -l fournier riazan'
alias ovh='ssh -l fournier 91.121.183.150'
alias webcam='mplayer tv:// -tv driver=v4l2:device=/dev/video0:brightness=40 -fps 30'
alias grepc='grep --color=auto'
alias dfh='df -h'
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
alias vimrc='vim ~/.vimrc'
alias rangerconf='vim ~/.config/ranger/rc.conf'
alias muttrc='vim ~/.mutt/muttrc'
alias xdefaults='vim /home/raph/.config/Xresources/Xdefaults'
alias cfp='vim .remind/cfp.rem'
alias cleanzautres='mv feh* tumblr* totw_* bonus_b* ~/Images/.zautres/'
alias magi='ssh cluster-magi'
alias soffice='soffice --norestore'
alias phone-connect="mtpfs -o allow_other /media/WinPhone8"
alias phone-disconnect="fusermount -u /media/WinPhone8"

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

alias awesomeElenapan="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/Elenapan awesome; cd ; echo \"awesome.restart()\" | awesome-client"
alias awesomeZenburn="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/zenburnClassic awesome; cd ; echo \"awesome.restart()\" | awesome-client"
alias awesomeWorronBlue="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/Worron awesome; cd ; echo \"awesome.restart()\" | awesome-client"
alias awesomeRFSWorpan="cd ~/.config/; rm awesome -f; ln -s awesomeConfigs/rfsWorpan awesome; cd ; echo \"awesome.restart()\" | awesome-client"

export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(vim {})+abort'"