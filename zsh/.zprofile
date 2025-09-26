. $HOME/.zshrc
export GPG_TTY=$(tty)
export GPG_AGENT_INFO=""

eval $(keychain --eval --quiet $HOME/.ssh/id_rsa-p13 $HOME/.ssh/id_rsa F33F1D07 --timeout 10000) startx
