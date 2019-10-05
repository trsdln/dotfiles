#!/bin/dash

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

# Lock autimatically before hibernate/suspend
xss-lock --transfer-sleep-lock -- lock-screen.sh &

redshift -l 50.45:30.523333 &

# Provides window transparancy
compton -b

# load bindings
xbindkeys

# Set charge thresholds between 40%-80%
sudo tlp setcharge 40 80 BAT0

# Set wallpaper
if [ -f $HOME/.fehbg ]; then
  . $HOME/.fehbg
fi

while true
do
  $HOME/.dotfiles/linux/scripts/statusline-update.sh
	sleep 50s
done &

if [ "$(ps -u $USER | grep 'dunst' | wc -l)" -lt "1" ]; then
  dunst &
fi

# automatically restart dwm
# while true; do
#   dwm
# done
exec dwm
# vim:ft=sh
