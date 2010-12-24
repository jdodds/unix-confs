#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
SYSTEM_TYPE=$(uname -a)
MAC="Darwin"
LAPTOP="destructor"
if [ -d /usr/local/bin ]; then
    PATH=$PATH:/usr/local/bin
fi

xsetroot -cursor_name left_ptr
xmodmap $HOME/.xmodmap
xset -b
feh --bg-scale $HOME/back.png

if [[ $SYSTEM_TYPE =~ $LATOP ]] ; then
    # Start Thinkpad OSD daemon
    if [ -x /usr/bin/tpb ] &&  [ -w /dev/nvram ] && [ -r /dev/nvram ]; then
        /usr/bin/tpb -d
    fi

    /usr/bin/urxvtd &
    /usr/bin/syndaemon -d &
    $HOME/.dropbox-dist/dropboxd &
    trayer --edge top --align right --SetDockType true --SetPartialStrut true --width 25 --height 18 --margin 690 &
    chromium &
    emacs &
    pyrana &
    pidgin &
    volwheel &
    skype &
    $(cat ~/.fehbg)
    exec ck-launch-session xmonad
fi


