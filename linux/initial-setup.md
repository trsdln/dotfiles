## Arch Setup

#### Partitions

```
  512M /boot
   12G [SWAP]
 50.2G /
175.8G /home
```

#### fstab

```
UUID=??	/         	xfs       	rw,relatime,attr2,inode64,noquota,noatime 0 1

UUID=??	/boot     	vfat      	rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=iso8859-1,shortname=mixed,utf8,errors=remount-ro 0 2

UUID=??	/home     	xfs       	rw,relatime,attr2,inode64,noquota,noatime	0 2

UUID=??	none      	swap      	defaults,noatime  	0 0
```

#### Grub (/etc/default/grub)

Achieve the fastest possible boot (hide Grub menu):

`GRUB_TIMEOUT=0`

Hibernation support (ensure UUID of swap is correct - can be taken from `/etc/fstab`):

`GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=UUID=a33e750b-58c9-4cc4-a661-89e9cfeb45e4"`

Apply changes:

`sudo grub-mkconfig -o /boot/grub/grub.cfg`

#### Swapiness (/etc/sysctl.d/99-swappiness.conf)

`vm.swappiness=10`

#### Hibernation

At `/etc/mkinitcpio.conf` add "resume" here:

`HOOKS=(base udev autodetect keyboard modconf block filesystems resume fsck)`

To apply changes: `mkinitcpio -p linux`

Enable suspend when lid is closed at `/etc/systemd/logind.conf`:

```
HandleLidSwitch=hibernate
HandleLidSwitchDocked=hibernate
```

### Enable TRIM

```
sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer
```

### User Creation

```
useradd taras
usermod -aG wheel,users,audio,video,input,lp,cups taras
passwd taras
# allow make instal without sudo
chown -R taras:wheel /usr/local
```

Allow wheel to run sudo commands: `sudo visudo`

Then uncomment: `%wheel ALL=(ALL) ALL`

To enable to run basic commands for user append this:

`taras ALL=NOPASSWD:/usr/bin/zzz,/usr/bin/ZZZ,/usr/bin/shutdown,/bin/nmcli,/usr/bin/tlp-stat,/usr/bin/tlp,/usr/bin/mount,/usr/bin/umount,`

#### Install all packages

```
cat ./package-list.conf | sed -E '/(^$|^#)/d' | pacman -S -
```

#### Clone dotfiles

#### Fix tearing artifacts

Create `/etc/X11/xorg.conf.d/20-intel.conf`:

```
Section "Device"
  Identifier "Intel Graphics"
  Driver "intel"

  Option "TearFree" "true"
EndSection
```

#### Fix Fn+F11 unrecognized issue

Create `/etc/udev/hwdb.d/90-thinkpad-keyboard.hwdb`:

```
evdev:name:ThinkPad Extra Buttons:dmi:bvn*:bvr*:bd*:svnLENOVO*:pn*
 KEYBOARD_KEY_49=prog1
```

To make the changes take effect:

```
# udevadm hwdb --update
# udevadm trigger --sysname-match="event*"
```

#### Install python packages

```
# Python integration for Neovim
pip install --user --upgrade pynvim
# Live preview of markdown at browser
pip install --user --upgrade grip
# Google Play Music TUI client
pip install --user --upgrade tuijam
```

#### Dash as `/bin/sh`:

`cd /usr/bin && rm -f sh && ln -s dash sh`

### Enable services:

```
systemctl enable NetworkManager
systemctl enable tlp
systemctl enable tlp-sleep
systemctl enable bluetooth
systemctl enable ntpd.service
```

### Audio setup

At `/etc/pulse/client.conf` set: `autospawn = yes`

#### Pacman

* enable Color option at `/etc/pacman.conf`
* install `aurutils`
* setup local repo for AUR: based on `man aur` (with double CacheDir fix)
* speed up AUR updates by disabling compression at `/etc/makepkg.conf`:

```
PKGEXT='.pkg.tar'
SRCEXT='.src.tar'
```

#### Install AUR packages

Sync packages using part of `system-upgrade.sh`. Then install:

```
pacman -S mongodb-bin mongodb-tools-bin mongodb-compass robo3t-bin
pacman -S slack-desktop ttf-symbola tmux-mem-cpu-load-git grive
pacman -S ffcast google-cloud-sdk paper-icon-theme-git tuijam
pacman -S aic94xx-firmware wd719x-firmware
# For aic94xx & wd719x:
mkinitcpio -p linux
```

#### Firewall

[Basic Instructions](https://wiki.archlinux.org/index.php/Simple_stateful_firewall)

```
sudo systemctl enable iptables.service
sudo systemctl start iptables.service

sudo systemctl enable ip6tables.service
sudo systemctl start ip6tables.service
```

# DNS Caching

```
sudo systemctl enable systemd-resolved.service
sudo systemctl start systemd-resolved.service
sudo ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
resolvectl status
```

#### Printer setup

```
sudo pacman -S cups splix
sudo systemctl enable org.cups.cupsd.service
sudo systemctl start org.cups.cupsd.service
```

Create queue:

```
# list devices
lpinfo -v

# list models
lpinfo -m

# create queue
lpadmin -p "queue_name" -E -v uri -m "model"
# example:
lpadmin -p HP_DESKJET_940C -E -v "usb://HP/DESKJET%20940C?serial=CN16E6C364BH" -m drv:///HP/hp-deskjet_940c.ppd.gz
```

### Switch to LTS kernel

1. Install LTS kernel: `sudo pacman -S linux-lts acpi_call-lts`.
2. Switch GRUB timeout back to > 0 value and regenerate Grub config.
3. Reboot > at Grub menu select Advanced > Arch with linux-lts.
4. Verify if everything is OK after boot.
5. Remove linux latest kernel: `sudo pacman -Rs linux acpi_call`.
6. Regenerate inital ramdisk `sudo mkinitcpio -p linux-lts`.
6. Get `GRUB_TIMEOUT` back and regenerate config again.

### Remove obsolete startup entries

```
sudo rm -f /etc/xdg/autostart/geoclue-demo-agent.desktop
```

Plus inspect autostart directory manually.

### PostgreSQL

```
sudo -iu postgres
initdb -D /var/lib/postgres/data
```

Then from regular user: `sudo systemctl start postgresql`

```
sudo -iu postgres
createuser --interactive
createdb testdbname
```

Connect to DB: `psql -d testdbname`

#### Done!
