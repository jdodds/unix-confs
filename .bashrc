SYSTEM_TYPE=$(uname -a)
MAC="Darwin"
LAPTOP="destructor"

export PATH=/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:~/bin:~/workspace/scala/bin:$PATH
export DISPLAY=:0.0
export EDITOR=emacsclient
export WORKSPACE="$HOME/workspace"
export GIT_EDITOR=emacsclient
export SVN_EDITOR=emacsclient

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

source "$HOME/.git-completion.bash"

set bell-style none
#ssh keys -- don't want to enter passphrases if we don't have to, ya know
if type -P keychain >/dev/null ; then
    eval `keychain --eval --nogui -Q -q id_dsa`
fi

if [ -f $HOME/.bash-machine ]; then
    source $HOME/.bash-machine
fi

PS1='[\u@\h \W]\$ '
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
