#/bin/sh

# set bigger font at /etc/rc.conf
#FONT="latarcyrheb-sun32"

# enable DHCP
ln -s /etc/sv/dhcpcd /var/service/
# check network interfaces
# ip link
# ip link set <interface_name> up

# allow wheel to run sudo commands:
visudo
# then uncomment "%wheel ALL=(ALL) ALL"

# enable to run basic commands for user
# sudo visudo
# append this
# taras ALL=NOPASSWD:/usr/bin/zzz,/usr/bin/ZZZ,/usr/bin/shutdown

# Add main user
useradd taras
usermod -aG wheel,users,audio,video,cdrom,input taras
# and set password
passwd taras

# Grub
# achieve the fastest possible boot:
# hide grub menu at /etc/default/grub (grub timeout to 0)

# base setup
xbps-install -S tlp
ln -s /etc/sv/tlp /var/service/

# date/time sync
xbps-install -S ntp
ln -s /etc/sv/ntpd /var/service/

xbps-install -S NetworkManager iwd htop

# dev env
xbps-install -S git

# desktop env
xbps-install -S xorg-minimal xorg-fonts xf86-video-intel
# for building dwm
xbps-install -S gcc make libX11-devel libXft-devel libXinerama-devel


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

# turn off
# sudo shutdown -h now
# resart
# sudo shutdown -r now
# hibernation
# ZZZ
# sleep
# zzz
