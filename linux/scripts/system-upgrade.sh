#!/bin/sh

# Do system backup before upgrade
sudo system-backup.sh
backup_result=$?
if [ "${backup_result}" != "0" ]; then
  echo "Error: Backup failed. System upgrade cancelled"
  exit 1
fi

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
aur sync ffcast
# aur sync google-cloud-sdk
aur sync aic94xx-firmware
aur sync wd719x-firmware
aur sync mongodb-bin
aur sync mongodb-tools-bin
aur sync mongodb-compass
aur sync robo3t-bin
aur sync slack-desktop
aur sync ttf-symbola
aur sync tmux-mem-cpu-load-git
aur sync grive
aur sync tuijam
aur sync paper-icon-theme-git

echo "Checking for system errors:"
journalctl -p 3 -xb

echo "Checking for service errors:"
systemctl --failed

echo "Orphan packages:"
pacman -Qdt

echo "Potentially removed packages (or installed from AUR):"
pacman -Qm
