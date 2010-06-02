export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/git/bin:~/bin
export DISPLAY=:0.0
export EDITOR=/usr/bin/emacs
alias ls='ls -G'
alias less='less -r'

alias TODAY='date +"%Y-%m-%d"'
alias YESTERDAY='date -v -1d +"%Y-%m-%d"'
alias TOMORROW='date -v +1d +"%Y-%m-%d"'

alias svntodaylog='svn log -r {$(TODAY)}:{$(TOMORROW)}'


source $HOME/.git-completion.bash

PS1='[\u@\h \W]\$ '