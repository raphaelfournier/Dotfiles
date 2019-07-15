. $HOME/.zshrc

eval $(keychain --eval --agents ssh,gpg --timeout 60 -Q --quiet $HOME/.ssh/id_rsa-p13 $HOME/.ssh/id_rsa F33F1D07 --timeout 10000) startx
