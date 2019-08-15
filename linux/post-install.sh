#/bin/sh

# Grub
# achieve the fastest possible boot:
# hide grub menu and fix kernel errors at /etc/default/grub
# GRUB_TIMEOUT=0
# GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4 slub_debug=P page_poison=1 intel_iommu=off"
# and then: sudo grub-mkconfig -o /boot/grub/grub.cfg

# set bigger font at /etc/rc.conf
#FONT="latarcyrheb-sun32"

# enable DHCP (do not enable if network manager is used!)
# ln -s /etc/sv/dhcpcd /var/service/
# check network interfaces
# ip link
# ip link set <interface_name> up

# Connection using NetworkManager
xbps-install -S dbus NetworkManager
ln -s /etc/sv/dbus /var/service/
ln -s /etc/sv/NetworkManager /var/service/

# allow wheel to run sudo commands:
visudo
# then uncomment "%wheel ALL=(ALL) ALL"

# enable to run basic commands for user
# sudo visudo
# append this
# taras ALL=NOPASSWD:/usr/bin/zzz,/usr/bin/ZZZ,/usr/bin/shutdown,/bin/nmcli,/bin/tlp-stat

# Add main user
useradd taras
usermod -aG wheel,users,audio,video,cdrom,input taras
# and set password
passwd taras
chown -R taras:wheel /usr/local

# base setup
xbps-install -S tlp
ln -s /etc/sv/tlp /var/service/

# date/time sync
xbps-install -S ntp
ln -s /etc/sv/ntpd /var/service/

# better font
xbps-install -S dejavu-fonts-ttf

# dev env
xbps-install -S git chromium xsel ripgrep tmux neovim htop

# drivers
xbps-install -S xf86-video-intel tpacpi-bat alsa-utils
sudo ln -s /etc/sv/alsa /var/service

# desktop env
xbps-install -S xorg-minimal xorg-fonts feh xsetroot
# for building dwm
xbps-install -S gcc make pkg-config libX11-devel libXft-devel libXinerama-devel


# misc notes

# runit usage:
# sv up service_name
# sv down service_name
# sv restart service_name
# sv status service_name

# Check battery level
# sudo tlp-stat -b

# xbps
# update all:
# xbps-install -Su
# remove with deps:
# xbps-remove -R <pack-name>
# xbps-query -Rs <search-exp>
# list manually instaled packages:
x xbps-query -lm

# set wallpaper
# feh --bg-scale image-name.jpg

# nmcli:
# sudo nmcli r wifi on
# sudo nmcli r wifi off
# sudo nmcli d wifi list
# sudo nmcli d wifi connect "point_name" password "password_val"

# turn off
# sudo shutdown -h now
# resart
# sudo shutdown -r now
# hibernation
# ZZZ
# sleep
# zzz
