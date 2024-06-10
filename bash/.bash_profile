. $HOME/.bashrc

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

#eval $(keychain --eval --agents ssh,gpg --timeout 60 -Q --quiet $HOME/.ssh/id_rsa-p13 $HOME/.ssh/id_rsa F33F1D07 --timeout 10000) startx

function _fab_complete() {
    local cur
    if [ -f "fabfile.py" ]; then
        cur="${COMP_WORDS[COMP_CWORD]}"
        COMPREPLY=( $(compgen -W "$(fab -F short -l)" -- ${cur}) )
        return 0
    else
        # no fabfile.py found. Don't do anything.        
        echo "no fabfile found"
        return 1
    fi
}
if [ -f /usr/local/etc/bash_completion ] && ! shopt -oq posix; then
    . /usr/local/etc/bash_completion
    complete -o nospace -F _fab_complete fab
fi

source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
