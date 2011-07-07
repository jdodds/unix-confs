#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

SYSTEM_TYPE=$(uname -a)
MAC="Darwin"
LAPTOP="destructor"
if [ -d /usr/local/bin ]; then
    PATH=$PATH:/usr/local/bin
fi

xsetroot -cursor_name left_ptr
xmodmap $HOME/.xmodmap

if [[ $SYSTEM_TYPE =~ $LATOP ]] ; then
    trayer_cmd="/usr/bin/trayer --edge top --align right --SetDockType true --SetPartialStrut true --width 25 --height 18 --margin 690"
    eval `ssh-agent`
    [ -x /usr/bin/trayer ] && $trayer_cmd &
#    [ -x /usr/bin/ssh-add ] && /usr/bin/ssh-add $HOME/.ssh/id_dsa
    [ -x /usr/bin/feh ] && $(cat ~/.fehbg)
    [ -x /usr/bin/urxvtd ] && /usr/bin/urxvtd &
    [ -x /usr/local/bin/emacs ] && /usr/local/bin/emacs &
    [ -x /usr/bin/urxvtd ] && /usr/bin/urxvtd &

    if [[ -n $(netcfg current) ]] ; then
        to_run=(
            /usr/bin/dropboxd
            /usr/bin/chromium
            /usr/bin/pidgin
            /usr/bin/skype
        )

        for program in ${to_run[@]}; do
            [ -x $program ] && $program &
        done
    fi
xmonad
fi
