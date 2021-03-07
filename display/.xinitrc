#!/bin/sh

userresources=$XDG_CONFIG_DIR/.Xresources
usermodmap=$XDG_CONFIG_DIR/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#xclock -geometry 50x50-1+1 &
setxkbmap -option caps:escape
nm-applet &
# suggested by matthias
#xcompmgr -c -t-5 -l-5 -r4.2 -o.55 &
xbindkeys -f $XDG_CONFIG_DIR/xbindkeysrc
exec i3
