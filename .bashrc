SYSTEM_TYPE=$(uname)
MAC="Darwin"

export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:~/bin
export DISPLAY=:0.0
export EDITOR=/usr/bin/emacs
alias ls='ls -G'
alias less='less -r'

alias TODAY='date +"%Y-%m-%d"'
alias YESTERDAY='date -v -1d +"%Y-%m-%d"'
alias TOMORROW='date -v +1d +"%Y-%m-%d"'

alias svntodaylog='svn log -r {$(TODAY)}:{$(TOMORROW)}'

if [ $SYSTEM_TYPE == $MAC ]
then
    alias mvx='sudo cp -r * /Applications/XAMPP/xamppfiles/htdocs'
fi

source $HOME/.git-completion.bash

#ssh keys
if type -P keychain >/dev/null ; then
    eval `keychain --eval --nogui -Q -q id_rsa`
fi

PS1='[\u@\h \W]\$ '