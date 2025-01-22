#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
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

# "As a general rule, 
# you should start long-running processes in the background by appending &,
# and start the last process in the xinitrc using exec"

xset r rate 200 40 # https://ejmastnak.com/tutorials/arch/typematic-rate/
# xbindkeys # i don't need this if i only use i3 config for keybinds

# - need audio service
# - need terminal and web browser ready to go
# - need window manager

/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
i3 &
ghostty -e htop & 
ghostty &

exec firefox
