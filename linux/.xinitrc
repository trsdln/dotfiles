#!/bin/sh

userresources=$HOME/.Xresources
sysresources=/etc/X11/xinit/.Xresources

# merge in defaults and keymaps
if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi

if [ -f "$userresources" ]; then
  # loads terminal color scheme
  xrdb -merge "$userresources"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# decrease delay for key autorepeat
xset r rate 300 50

# Lock autimatically before hibernate/suspend
xss-lock --transfer-sleep-lock -- lock-screen.sh &

# Provides window transparancy
picom -b

redshift -l 50.45:30.523333 &

# Set charge thresholds between 40%-80%
sudo tlp setcharge 40 80 BAT0

set-wallpaper.sh

if [ "$(ps -u $USER | grep 'dunst' | wc -l)" -lt "1" ]; then
  dunst &
fi

# load bindings
sxhkd &

# starting it here to ensure it will be stopped within bspwm
statusline-start.sh &
exec bspwm
# vim:ft=sh
