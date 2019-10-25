#/bin/sh

# # Grub
# # achieve the fastest possible boot:
# # hide grub menu  at /etc/default/grub
# GRUB_TIMEOUT=0
# # hibernation support (ensure UUID of swap is correct - can be taken from /etc/fstab):
# GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=UUID=a33e750b-58c9-4cc4-a661-89e9cfeb45e4"
# # probably not relevant (fix kernel errors): GRUB_CMDLINE_LINUX_DEFAULT="loglevel=4 slub_debug=P page_poison=1 intel_iommu=off"
# # finally:
# sudo grub-mkconfig -o /boot/grub/grub.cfg

# # enable Color option at /etc/pacman.conf

# # reduce swappiness at /etc/sysctl.d/99-swappiness.conf
# vm.swappiness=10

# # hibernation setup
# # at /etc/mkinitcpio.conf add "resume" here:
# HOOKS=(base udev autodetect keyboard modconf block filesystems resume fsck)
# # and then: mkinitcpio -p linux

# # enable suspend when lid is closed at /etc/systemd/logind.conf:
# HandleLidSwitch=hibernate
# HandleLidSwitchDocked=hibernate

# # Speed up AUR updates by disabling compression at /etc/makepkg.conf:
# PKGEXT='.pkg.tar'
# SRCEXT='.src.tar'

# Connection using NetworkManager
systemctl enable NetworkManager
systemctl start NetworkManager

# Add main user
useradd taras
usermod -aG wheel,users,audio,video,input,lp taras
# and set password
passwd taras
# allow make instal without sudo
chown -R taras:wheel /usr/local

# allow wheel to run sudo commands:
sudo visudo
# then uncomment:
# %wheel ALL=(ALL) ALL
# to enable to run basic commands for user append this:
# taras ALL=NOPASSWD:/usr/bin/zzz,/usr/bin/ZZZ,/usr/bin/shutdown,/bin/nmcli,/usr/bin/tlp-stat,/usr/bin/tlp,/usr/bin/mount,/usr/bin/umount,

pip install --user --upgrade pynvim

cd /usr/bin && rm -f sh && ln -s dash sh

# At this point dotfiles can be cloned

systemctl enable tlp
systemctl enable tlp-sleep
systemctl enable bluetooth

# Audio setup
# At /etc/pulse/client.conf set
# autospawn = yes

# install all packages
cat ./package-list.conf | sed -E '/(^$|^#)/d' | pacman -S -

# download and install Hubstaff and then:
ln -s /home/taras/apps/Hubstaff/HubstaffClient.bin.x86_64 /usr/local/bin/hubstaff

# Install "aurutils" and configure local
# repo based on `man aur` (with double CacheDir fix)

# Packages from AUR:
# sync AUR packages
dash system-upgrade.sh
# install
pacman -S mongodb-bin mongodb-tools-bin mongodb-compass robo3t-bin
pacman -S slack-desktop ttf-symbola tmux-mem-cpu-load-git grive
pacman -S ffcast google-cloud-sdk tuijam paper-icon-theme-git
pacman -S aic94xx-firmware wd719x-firmware
# For aic94xx & wd719x:
mkinitcpio -p linux
