SYSTEM_TYPE=$(uname -a)
MAC="Darwin"
LAPTOP="destructor"

export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:~/bin
export DISPLAY=:0.0
export EDITOR=/usr/bin/emacs
alias ls='ls -G'
alias less='less -r'

alias TODAY='date +"%Y-%m-%d"'
alias YESTERDAY='date -v -1d +"%Y-%m-%d"'
alias TOMORROW='date -v +1d +"%Y-%m-%d"'

alias svntodaylog='svn log -r {$(TODAY)}:{$(TOMORROW)}'

if [[ $SYSTEM_TYPE =~ $MAC ]] ; then
    alias mvx='sudo cp -r * /Applications/XAMPP/xamppfiles/htdocs'
elif [[ $SYSTEM_TYPE =~ $LAPTOP ]] ; then
    alias pacman='sudo pacman'
    alias netcfg='sudo netcfg'
    export PATH=$PATH:/opt/java/jre/bin/
fi

export DEV="jdodds@dev1.cgalvin.com"
export SHA="cgd@jagger.sanbornhead.com"
export DEV_SVN=$DEV/var/svn

source $HOME/.git-completion.bash

#ssh keys -- don't want to enter passphrases if we don't have to, ya know
if type -P keychain >/dev/null ; then
    eval `keychain --eval --nogui -Q -q id_rsa`
fi


PS1='[\u@\h \W]\$ '
