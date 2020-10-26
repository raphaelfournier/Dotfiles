#if [[ "$TERM" == *rxvt* ]]; then
   #exec zsh
 #fi

#if [ -f /etc/bash_completion ]; then
# . /etc/bash_completion
#fi

#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. /usr/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh
source /home/raph/.bash_aliases
source /home/raph/.bash_functions
source /usr/share/cdargs/cdargs-bash.sh
source /usr/share/fzf/key-bindings.bash
source $HOME/scripts/fzf/completion.bash
#source /usr/share/doc/ranger/examples/bash_automatic_cd.sh
#bind '"\e[A":history-search-backward'
#bind '"\e[B":history-search-forward'
bind Space:magic-space
export JAVA_HOME="/usr/lib/jvm/java-13-openjdk/"
export QUOTING_STYLE=literal
#export TERM=xterm-256color
#export QT_QPA_PLATFORMTHEME="qt5ct"
source $HOME/.shell_path

declare -x TEXINPUTS=.:$HOME/LIP6/These/Manuscript/preamble:
export HISTSIZE=10000
export EDITOR="vim"
export MANPAGER=most
export XDG_CONFIG_HOME="/home/raph/.config"
export XDG_DATA_HOME="/home/raph/.local/share"
export MUTTJUMP_INDEXER=mu
export GPG_TTY=`tty`
shopt -s histappend
shopt -s checkwinsize
# do not type cd
shopt -s autocd
# find with **
shopt -s extglob
# important : completion avec sudo !!
complete -cf sudo
complete -cf man
source /home/raph/.bash_fabriccompletion
source $HOME/.dynamic-colors/completions/dynamic-colors.bash
#dynamic-colors init
if [ -f /etc/bash_completion ]; then
  . /etc/bash_completion
fi

get_dir() {
    printf "%s" $(pwd | sed "s:$HOME:~:")
}

get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
# Explicitly unset color (default anyhow). Use 1 to set it.
GIT_PS1_SHOWCOLORHINTS=
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto git"
source /usr/share/git/git-prompt.sh

black=`tput sgr0; tput setaf 0`
red=`tput sgr0; tput setaf 1`
green=`tput sgr0; tput setaf 2`
yellow=`tput sgr0; tput setaf 3`
blue=`tput sgr0; tput setaf 4`
magenta=`tput sgr0; tput setaf 5`
cyan=`tput sgr0; tput setaf 6`
white=`tput sgr0; tput setaf 7`

BLACK=`tput setaf 0; tput bold`
RED=`tput setaf 1; tput bold`
GREEN=`tput setaf 2; tput bold`
YELLOW=`tput setaf 3; tput bold`
BLUE=`tput setaf 4; tput bold`
MAGENTA=`tput setaf 5; tput bold`
CYAN=`tput setaf 6; tput bold`
WHITE=`tput setaf 7; tput bold`
reset=`tput sgr0`

#export BROWSER="/home/raph/scripts/browser-choice.sh"
export BROWSER="firefox"

#todo --filter +high  # works with devtodo
#t listpri | grep -v "^-"
#cat ~/.tasks | grep -v "^✓\|^#"
#python2 scripts/parse-tasks.py | sort -k1,1n -k2,2n | cut -d " " -f3- | head -n7
export MAIL='~/Mail'

eval `dircolors ~/.ls_colors` 
#eval `dircolors ~/.ls_colors.solarized-light` 
#eval `dircolors ~/.ls_colors.xoria` 

#set -o vi
#set editing-mode vi
# SSH agent settings
#SSHAGENT=/usr/bin/ssh-agent
#SSHAGENTARGS="-s"
#if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
  #eval `$SSHAGENT $SSHAGENTARGS`
  #trap "kill $SSH_AGENT_PID" 0
#fi

#rem -g 

function mkcd() {
mkdir -p $1 && cd $1;
}

PERL5LIB="/home/raph/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/raph/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/raph/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/raph/perl5"; export PERL_MM_OPT;

#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#export WORKON_HOME=~/.virtualenvs
#mkdir -p $WORKON_HOME
#source ~/.local/bin/virtualenvwrapper.sh
alias config='/usr/bin/git --git-dir=/home/raph/.dotcfg --work-tree=/home/raph'

PS1='\D{%d} \[${RED}\]\t \[$yellow\]$(__git_ps1 "[%s $(get_sha)] ")\[${green}\]\u\[${reset}\]@\[${BLUE}\]\h\[${reset}\]: \[${MAGENTA}\]\w \n\[${BLUE}\]\$ \[${reset}\]'

#PS1='\D{%d} \[${RED}\]\t \[${green}\]\u\[${reset}\]@\[${BLUE}\]\h\[${reset}\]: \[${MAGENTA}\]\w \n\[${BLUE}\]\$ \[${reset}\]'

# coloriser les pages de Man
#export MANROFFOPT='-c'
#export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
#export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
#export LESS_TERMCAP_me=$(tput sgr0)
#export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
#export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
#export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
#export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
#export LESS_TERMCAP_mr=$(tput rev)
#export LESS_TERMCAP_mh=$(tput dim)

#. ~/scripts/git_svn_bash_prompt.sh

# à modifier pour changer le nom de la fenêtre urxvt
#PROMPT_COMMAND='DEFTITLE="${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}"; echo -ne "\033]0;${TITLE:-$DEFTITLE}\007"'
source ~/.kb_alias
