#!/bin/sh

# Prevent auto suspend and disable screensaver
xset -dpms
xset s off

if [ "$1" = "--backup" ]; then
  # Do system backup before upgrade
  sudo system-backup.sh
  backup_result=$?
  if [ "${backup_result}" != "0" ]; then
    echo "Error: Backup failed. System upgrade cancelled"
    exit 1
  fi
fi

echo "Cleaning logs older than 7 days..."
sudo journalctl --vacuum-time=7d

echo "Clean pacman cache..."
sudo paccache --remove
# remove uninstalled cached packages
sudo paccache -ruk0

# Update all official packages
sudo pacman -Suy

# from https://gitlab.com/mgdobachesky/ArchSystemMaintenance/blob/master/src/maint/logic.sh
echo "Checking for upgrade warnings..."
last_upgrade="$(sed -n '/pacman -Syu/h; ${x;s/.\([0-9-]*\).*/\1/p;}' /var/log/pacman.log)"
if [ -n "$last_upgrade" ]; then
  echo "================================"
  paclog --after="$last_upgrade" | paclog --warnings
  echo "================================"
fi

echo "Updating all AUR packages..."
aur sync tuijam
aur sync ffcast
# aur sync google-cloud-sdk
aur sync aic94xx-firmware
aur sync wd719x-firmware
aur sync mongodb-bin
aur sync mongodb-tools-bin
aur sync mongodb-compass
aur sync robo3t-bin
aur sync slack-desktop
aur sync tmux-mem-cpu-load-git
aur sync grive
aur sync paper-icon-theme-git
aur sync mpv-mpris
aur sync aurutils
# bspwm related:
aur sync xtitle
aur sync libxft-bgra

echo "Update pip packages:"
pip install --user --upgrade pynvim

echo "Checking for system errors:"
journalctl -p 3 -xb

echo "Checking for service errors:"
systemctl --failed

echo "Orphan packages:"
pacman -Qdt

echo "Potentially removed packages (or installed from AUR):"
pacman -Qm

# Bash updates will override symlink "dash -> /bin/sh"
# instead of messing around with Pacman's hooks it can be fixed here
if [ "$(file $(which sh))" = "/usr/bin/sh: symbolic link to dash" ]; then
  SH_STATUS="OK"
else
  sudo ln -sfT dash /bin/sh
  if [ "$(file $(which sh))" = "/usr/bin/sh: symbolic link to dash" ]; then
    SH_STATUS="FIXED"
  else
    SH_STATUS="FAILED"
  fi
fi
echo "dash -> /bin/sh symlink: $SH_STATUS"

# Restore screen saver and auto suspend
xset +dpms
xset s on
