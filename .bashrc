SYSTEM_TYPE=$(uname -a)
MAC="Darwin"
LAPTOP="destructor"

export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:~/bin
export DISPLAY=:0.0
export EDITOR=/usr/bin/emacs
export WORKSPACE="$HOME/workspace"
export GIT_EDITOR=emacsclient
export SVN_EDITOR=nano

alias ls='ls -G'
alias less='less -r'

alias TODAY='date +"%Y-%m-%d"'
alias YESTERDAY='date -v -1d +"%Y-%m-%d"'
alias TOMORROW='date -v +1d +"%Y-%m-%d"'

alias svntodaylog='svn log -r {$(TODAY)}:{$(TOMORROW)}'
alias svndiff='svn diff | colordiff | less'

sudos=( pacman netcfg ifconfig iwlist iwconfig mount umount eject shutdown
    apachectl )
for command in ${sudos[@]}; do
    alias $command="sudo $command"
done;
nohups=( firefox chromium pidgin skype qjackctl rosegarden lmms emacs
    audacity pyrana )
for command in ${nohups[@]}; do
    logfile="$HOME/log/$command.log"
    [ -f $logfile ] || touch $logfile
    alias $command="nohup $command >> $logfile &"
done;
export PATH=$PATH:/opt/java/jre/bin/:/usr/local/bin


export DEV="jdodds@dev1.cgalvin.com"
export SHA="cgd@jagger.sanbornhead.com"
export DEV_SVN=svn+ssh://$DEV/var/svn

source $HOME/.git-completion.bash

set bell-style none
#ssh keys -- don't want to enter passphrases if we don't have to, ya know
if type -P keychain >/dev/null ; then
    eval `keychain --eval --nogui -Q -q id_rsa`
fi


PS1='[\u@\h \W]\$ '
