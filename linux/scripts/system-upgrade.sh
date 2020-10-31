#!/bin/sh

upgrade_aur_packages() {
  echo "Updating all AUR packages..."
  # updates too often so usually just skip:
  aur sync google-cloud-sdk
  aur sync spotify-tui-bin
  aur sync aic94xx-firmware
  aur sync wd719x-firmware
  aur sync mongodb-tools-bin
  aur sync mongodb-compass
  aur sync robo3t-bin
  aur sync slack-desktop
  # outdated at aur:
  # aur sync grive
  aur sync paper-icon-theme-git
  aur sync mpv-mpris
  aur sync aurutils
  # bspwm related:
  aur sync xtitle
  aur sync libxft-bgra
  aur sync lf-bin
}

pull_and_notify() {
  local path=$1
  local old_path=$(pwd)
  cd "${path}"
  git fetch --prune
  printf "Checking ${path}: "
  if [ "$(git status | grep 'Your branch is behind')" != "" ]; then
    echo "new commits. Stashing and pulling..."
    git stash > /dev/null; git pull > /dev/null; git stash pop > /dev/null
  else
    echo "up-to-date"
  fi
  cd "${old_path}"
}

check_manual_aur_upgrades() {
  # instead of aur sync mongodb-bin:
  pull_and_notify ~/projects/mongodb-bin

  # instead of aur sync spotifyd:
  # requires manual reconfiguration before build (pulseaudio + mpris)
  pull_and_notify ~/projects/spotifyd
}

upgrade_pip_packages() {
  echo "Update pip packages:"
  pip install --user --upgrade pynvim
}

fix_bin_sh_link() {
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
}

clean_custompkgs_obsolete_files() {
  local repo_path="/home/custompkgs"

  echo "\nChecking ${repo_path} for obsolete files..."

  local existing_files="$(ls "${repo_path}" | grep -v 'custom.db' | grep -v 'custom.files')"

  for installed_pack in $(pacman -Sl custom | cut -d " " -f 2)
  do
    # remove registered package from the list
    existing_files=$(printf "%s\n" "${existing_files}" | grep -v "${installed_pack}")
  done

  printf "Obsolete package files:\n%s\n" "${existing_files}"

  if [ "${existing_files}" != "" ]; then
    printf "Remove obsolete files? [y/n] (y) "
    read -r ans
    if [ "$ans" = "y" ] || [ "$ans" = "" ]; then
      for file_name in $(printf "%s" "${existing_files}"); do
        file_path="${repo_path}/${file_name}"
        echo "Removing ${file_path}"
        rm -f ${file_path}
      done
      echo "Obsolete files cleaned."
    else
      echo "Cleaning skipped."
    fi
  else
    echo "Nothing to clean."
  fi
}

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

# todo: find artix analog
# echo "Cleaning logs older than 7 days..."
# sudo journalctl --vacuum-time=7d

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

upgrade_aur_packages

upgrade_pip_packages

# todo: find artix analogs
# echo "Checking for system errors:"
# journalctl -p 3 -xb

# echo "Checking for service errors:"
# systemctl --failed

echo "Orphan packages:"
pacman -Qdt

echo "Potentially removed packages (or installed from AUR):"
pacman -Qm

echo "Unused packages at 'custom' repo:"
pacman -Sl custom | grep -v installed | cut -d " " -f 2

fix_bin_sh_link

clean_custompkgs_obsolete_files

echo "Checking locally managed AUR packages:"
check_manual_aur_upgrades

# Restore screen saver and auto suspend
xset +dpms
xset s on
