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
# taras ALL=NOPASSWD:/usr/bin/zzz,/usr/bin/ZZZ,/usr/bin/shutdown,/bin/nmcli,/bin/tlp-stat

# better font
pacman -S noto-fonts-emoji ttf-dejavu

# dev env
pacman -S zsh git ripgrep tmux neovim chromium htop x11-ssh-askpass ctags python3 python-pip
pacman -S yarn nodejs-lts-carbon
pip install --user --upgrade pynvim

# At this point dotfiles can be cloned

# drivers
pacman -S xf86-video-intel alsa-utils tlp tpacpi-bat

# desktop env
pacman -S xorg-{server,xinit,xsetroot,xrandr,xbacklight} feh xsel

# todo:
# * install:
# > docker
# > jdk elasticsearch slack robo3t compass keybase
# > gimp "screenshot app: area + whole screen"
# * exfat filesystem support
# set close lid action: sleep

# misc notes

# nmcli:
# sudo nmcli r wifi on
# sudo nmcli r wifi off
# sudo nmcli d wifi list
# sudo nmcli d wifi connect "point_name" password "password_val"

# sound control:
# alsamixer - TUI
# amixer - CLI
# volume control:
# amixer sset Master 5%-
# amixer sset Master 5%+

# change monitor brightness
# xbacklight -set 50
