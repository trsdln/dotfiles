#/bin/sh

# Grub
# # achieve the fastest possible boot:
# # hide grub menu  at /etc/default/grub
# GRUB_TIMEOUT=0
# # hibernation support (ensure UUID is correct - can be taken from /etc/fstab):
# GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=UUID=a33e750b-58c9-4cc4-a661-89e9cfeb45e4"
# # probably not relevant (fix kernel errors): GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4 slub_debug=P page_poison=1 intel_iommu=off"
# # finally:
# sudo grub-mkconfig -o /boot/grub/grub.cfg

# enable Color option at /etc/pacman.conf

# reduce swappiness
# /etc/sysctl.d/99-swappiness.conf
# vm.swappiness=10

# hibernation setup
# at /etc/mkinitcpio.conf add "resume" here:
# HOOKS=(base udev autodetect keyboard modconf block filesystems resume fsck)
# and then: mkinitcpio -p linux

# # enable suspend when lid is closed at /etc/systemd/logind.conf:
# HandleLidSwitch=hibernate
# HandleLidSwitchDocked=hibernate

# set bigger font at /etc/rc.conf
#FONT="latarcyrheb-sun32"

# Connection using NetworkManager
pacman -S base-devel networkmanager openssh
systemctl enable NetworkManager
systemctl start NetworkManager

# Add main user
useradd taras
usermod -aG wheel,users,audio,video,input taras
# and set password
passwd taras
# allow make instal without sudo
chown -R taras:wheel /usr/local

# allow wheel to run sudo commands:
sudo visudo
# then uncomment:
# %wheel ALL=(ALL) ALL
# to enable to run basic commands for user append this:
# taras ALL=NOPASSWD:/usr/bin/zzz,/usr/bin/ZZZ,/usr/bin/shutdown,/bin/nmcli,/bin/tlp-stat,/usr/bin/mount,/usr/bin/umount

# better fonts
pacman -S noto-fonts-emoji ttf-dejavu

# dev env
pacman -S zsh git ripgrep tmux neovim htop ctags python3 python-pip
pacman -S yarn nodejs-lts-carbon docker keybase kbsf
pacman -S jdk11-openjdk
pip install --user --upgrade pynvim

pacman -S dash

# At this point dotfiles can be cloned

# drivers
pacman -S xf86-video-intel alsa-utils tlp tpacpi-bat exfat-utils
pacman -S pulseaudio pulseaudio-alsa
# At /etc/pulse/client.conf set
# autospawn = yes

# desktop env
pacman -S xorg-{server,xinit,xsetroot,xrandr,xbacklight,xclipboard} x11-ssh-askpass xsel xbindkeys xclip
pacman -S dunst feh xss-lock slock redshift
pacman -S xdotools moka-icon-theme

# desktop apps
pacman -S mpv transmission-qt chromium gimp thunderbird telegram-desktop
pacman -S zathura zathura-djvu zathura-pdf-mupdf perl-file-mimeinfo android-file-transfer

# required by Hubstaff
pacman -S libcurl-gnutls libnotify
# download and install Hubstaff and then:
ln -s /home/taras/apps/Hubstaff/HubstaffClient.bin.x86_64 /usr/local/bin/hubstaff

pacman -S repose # don't use this one for now
# then install "aurutils"
# then configure local repo based on `man aur` (with double CacheDir fix)
aur sync ffcast && sudo pacman -S ffcast
aur sync google-cloud-sdk && sudo pacman -S google-cloud-sdk
pacman -S kubectl

aur sync mongodb-bin && pacman -S mongodb-bin
aur sync mongodb-tools-bin && pacman -S mongodb-tools-bin
aur sync mongodb-compass && pacman -S mongodb-compass
aur sync robo3t-bin && pacman -S robo3t-bin
aur sync slack-desktop && pacman -S slack-desktop
aur sync ttf-symbola && pacman -S ttf-symbola
aur sync tmux-mem-cpu-load-git && pacman -S tmux-mem-cpu-load-git
aur sync rover && pacman -S rover
