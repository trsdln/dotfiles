#!/bin/bash

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
  # loads terminal color scheme
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

# Set keyboard layouts
setxkbmap -model thinkpad -layout us,ua -variant ,legacy -option grp:win_space_toggle
# "legacy" variant fixes problem with ? vs . at UA keyboard
xkbcomp $HOME/.dotfiles/linux/xkbmap.xkb $DISPLAY

# Lock autimatically before hibernate/suspend
xss-lock -- slock &

# load bindings
xbindkeys

# Set wallpaper
feh --bg-scale Pictures/wallpaper.jpg

BAT_DISCH_STATUS="Discharging"

while true
do
  $HOME/.dotfiles/linux/scripts/statusline-update.sh
	sleep 20s
done &

if [ "$(ps -u $USER | grep 'dunst' | wc -l)" -lt "1" ]; then
  dunst &
fi

exec dwm
