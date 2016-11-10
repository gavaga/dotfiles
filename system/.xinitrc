#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile   ] && source ~/.xprofile

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

exec touchegg &

export PATH=$PATH:/home/gavaga/.matlab/MATLAB/R2014b/bin:/home/.opt/Aptana_Studio_3
setxkbmap -option caps:swapescape
exec i3
