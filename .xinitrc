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
xsetroot -cursor_name left_ptr
xmodmap $HOME/.xmodmap

if [[ $SYSTEM_TYPE =~ $LATOP ]] ; then
    # Start Thinkpad OSD daemon
    if [ -x /usr/bin/tpb ] &&  [ -w /dev/nvram ] && [ -r /dev/nvram ]; then
        /usr/bin/tpb -d
    fi

    /usr/bin/urxvtd &
    exec ck-launch-session xmonad
fi


