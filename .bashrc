SYSTEM_TYPE=$(uname -a)
MAC="Darwin"
LAPTOP="destructor"

export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:~/bin
export DISPLAY=:0.0
export EDITOR=/usr/bin/emacs
export WORKSPACE="$HOME/workspace"
export GIT_EDITOR=emacsclient

alias ls='ls -G'
alias less='less -r'

alias TODAY='date +"%Y-%m-%d"'
alias YESTERDAY='date -v -1d +"%Y-%m-%d"'
alias TOMORROW='date -v +1d +"%Y-%m-%d"'

alias svntodaylog='svn log -r {$(TODAY)}:{$(TOMORROW)}'
alias svndiff='svn diff | colordiff | less'

if [[ $SYSTEM_TYPE =~ $MAC ]] ; then
    alias mvx='sudo cp -r * /Applications/XAMPP/xamppfiles/htdocs'
    export MARQUEE="$WORKSPACE/marquee/trunk/www"
    export JAGGER="$WORKSPACE/jagger/trunk/"
    export PATH=$PATH:/usr/local/mysql-5.1.48-osx10.6-x86_64/bin/
elif [[ $SYSTEM_TYPE =~ $LAPTOP ]] ; then
    sudos=( pacman netcfg ifconfig iwlist iwconfig mount umount eject shutdown )
    for command in ${sudos[@]}; do
        alias $command="sudo $command"
    done;
    nohups=( firefox chromium pidgin skype qjackctl rosegarden lmms evince emacs
        audacity pyrana )
    for command in ${nohups[@]}; do
        logfile="$HOME/log/$command.log"
        [ -f $logfile ] || touch $logfile
        alias $command="nohup $command >> $logfile &"
    done;
    export WORKON_HOME=$HOME/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true
    export PATH=$PATH:/opt/java/jre/bin/:/usr/local/bin
fi

export DEV="jdodds@dev1.cgalvin.com"
export SHA="cgd@jagger.sanbornhead.com"
export DEV_SVN=$DEV/var/svn

source $HOME/.git-completion.bash

set bell-style none
#ssh keys -- don't want to enter passphrases if we don't have to, ya know
if type -P keychain >/dev/null ; then
    eval `keychain --eval --nogui -Q -q id_rsa`
fi


PS1='[\u@\h \W]\$ '
