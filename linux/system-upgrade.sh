#!/bin/dash

sudo pacman -Suy

aur sync ffcast
aur sync google-cloud-sdk
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

echo "Orphan packages:"
pacman -Qdt

echo "Potentially removed packages (or installed from AUR):"
pacman -Qm
