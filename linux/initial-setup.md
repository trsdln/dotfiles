## Artix Setup

LVM on LUKS based on this [article](https://www.rohlix.eu/post/artix-linux-full-disk-encryption-with-uefi/)

## Partitions

```
  512M /boot
   12G [SWAP]
 50.2G /
175.8G /home
```

## Initial setup

Boot into live usb and ensure that Internet connection is available.

```sh
# gain root access
sudo su

pacman -Sy
pacman -S parted

parted /dev/sdX
# and remove existing partitions

# make boot partition
parted -s /dev/sdX mklabel gpt
parted -s -a optimal /dev/sdX mkpart "primary" "fat16" "0%" "512MiB"
parted -s /dev/sdX set 1 esp on

# make root partition
parted -s -a optimal /dev/sdX mkpart "primary" "ext4" "512MiB" "100%"
parted -s /dev/sdX set 2 lvm on

# encrypt root
cryptsetup luksFormat -v /dev/sdX2
cryptsetup luksOpen /dev/sdX2 lvm-system

# configure LVM
pvcreate /dev/mapper/lvm-system
vgcreate lvmSystem /dev/mapper/lvm-system
lvcreate -L 16G lvmSystem -n volSwap
lvcreate -L 50G lvmSystem -n volRoot
lvcreate -l +100%FREE lvmSystem -n volHome

# format partitions
mkswap /dev/lvmSystem/volSwap
mkfs.fat -F32 -n ESP /dev/sdX1
mkfs.ext4 -L volRoot /dev/lvmSystem/volRoot
mkfs.ext4 -L volHome /dev/lvmSystem/volHome

# mount everything
swapon /dev/lvmSystem/volSwap
mount /dev/lvmSystem/volRoot /mnt
mkdir -p /mnt/boot /mnt/home
mount /dev/sdX1 /mnt/boot
mount /dev/lvmSystem/volHome /mnt/home

basestrap /mnt base base-devel runit

# generate fstab:
fstabgen -U /mnt >> /mnt/etc/fstab

# chroot:
artools-chroot /mnt /bin/bash

# timezone
ln -s /usr/share/zoneinfo/Continent/City /etc/localtime
hwclock --systohc

# install text editor
pacman -S neovim

# uncomment needed locales (e.g. en_US.UTF-8):
nvim /etc/locale.gen

# generate locales
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf

echo <myhostname> > /etc/hostname

# install kernel
pacman -S linux-lts linux-firmware

# adjust hooks like this:
# HOOKS=(base udev autodetect keyboard keymap modconf block encrypt lvm2 resume filesystems fsck)
# at
nvim /etc/mkinitcpio.conf

mkinitcpio -p linux-lts

# root password
passwd

# install grub package:
pacman -S grub efibootmgr

# adjust grub config /etc/default/grub:
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=UUID=`blkid -s UUID -o value /dev/lvmSystem/volSwap` msr.allow_writes=on"
# msr.allow_writes ensures that workaround from throttled/lenovo_fix.py works fine
GRUB_CMDLINE_LINUX="cryptdevice=UUID=`blkid -s UUID -o value /dev/sdX2`:lvm-system:allow-discards root=/dev/lvmSystem/volRoot"
GRUB_ENABLE_CRYPTODISK=y

# install grub
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=artix --recheck /dev/sdX
grub-mkconfig -o /boot/grub/grub.cfg

# install and enable some services
pacman -S elogin-runtit dbus-runit cryptsetup-runit lvm2-runit device-mapper-runit networkmanager-runit ntp-runit acpid-runit syslog-ng-runit

# enable every service:
acpid dmeventd NetworkManager syslog-ng elogind ntpd dbus lvmetad sulogin udevd
# using:
ln -s /etc/runit/sv/<servicename> /etc/runit/runsvdir/default
```

## Hosts

Put into /etc/hosts this:

```
127.0.0.1 localhost
::1       localhost
```

## User Creation

```
useradd taras
usermod -aG wheel,users,audio,video,input,lp taras
passwd taras
```

Allow wheel to run sudo commands: `EDITOR=nvim visudo`

Then uncomment: `%wheel ALL=(ALL) ALL`

To enable to run basic commands for user append this:

`taras ALL=NOPASSWD:/usr/bin/shutdown,/bin/nmcli,/usr/bin/tlp-stat,/usr/bin/tlp,/usr/bin/mount,/usr/bin/umount`

## Reboot

```
# exit chroot
exit

umount -R /mnt
swapoff -a

reboot
```

## Grub (/etc/default/grub)

Achieve the fastest possible boot (hide Grub menu):

`GRUB_TIMEOUT=0`

Hibernation support (ensure UUID of swap is correct - can be taken from `/etc/fstab`):

`GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet resume=UUID=a33e750b-58c9-4cc4-a661-89e9cfeb45e4"`

Apply changes:

`sudo grub-mkconfig -o /boot/grub/grub.cfg`

## Swapiness (/usr/lib/sysctl.d/99-swappiness.conf)

`vm.swappiness=10`

## Hibernation

Enable suspend when lid is closed at `/etc/elogind/logind.conf`:

```
HandlePowerKey=suspend
HandleLidSwitch=hibernate
HandleLidSwitchExternalPower=hibernate
HandleLidSwitchDocked=hibernate
```

## Enable TRIM

Enable cronie service:

```
sudo ln -s /etc/runit/sv/cronie /run/runit/service
```

Add weekly job at `/etc/cron.weekly/fstrim`

```
#!/bin/sh

/usr/sbin/fstrim --fstab --verbose
#vim:ft=sh
```

Make job executable: `chmod +x /etc/cron.weekly/fstrim`.

## Install all packages

```
cat ./package-list.conf | sed -E '/(^$|^#)/d' | pacman -S -
```

## Clone dotfiles

## Fix tearing artifacts

Create `/etc/X11/xorg.conf.d/20-intel.conf`:

```
Section "Device"
  Identifier "Intel Graphics"
  Driver "intel"
  Option  "TripleBuffer" "true"
  Option "TearFree" "true"
EndSection
```

## Fix Fn+F11 unrecognized issue

Create `/usr/lib/udev/hwdb.d/90-thinkpad-keyboard.hwdb`:

```
evdev:name:ThinkPad Extra Buttons:dmi:bvn*:bvr*:bd*:svnLENOVO*:pn*
 KEYBOARD_KEY_49=prog1
```

To make the changes take effect:

```
# udevadm hwdb --update
# udevadm trigger --sysname-match="event*"
```

## Install python packages

```
# Python integration for Neovim
pip install --user --upgrade pynvim
```

## Dash as `/bin/sh`:

`cd /usr/bin && rm -f sh && ln -s dash sh`

## Enable services:


Also, need to start custom services from dotfiles:

```
ln -s /home/<user>/.dotfiles/linux/runit/<servicename> /run/runit/service/
```

## Audio setup

At `/etc/pulse/client.conf` set: `autospawn = yes`
At `/etc/pulse/daemon.conf` set: `exit-idle-time = -1`

## Pacman

* enable Color option at `/etc/pacman.conf`
* install `aurutils`
* setup local repo for AUR: based on `man aur` (with double CacheDir fix)
* speed up AUR updates by disabling compression at `/etc/makepkg.conf`:

```
PKGEXT='.pkg.tar'
SRCEXT='.src.tar'
```

## Install AUR packages

Sync packages using part of `system-upgrade.sh`. Then install using pacman.
For aic94xx & wd719x:

```
mkinitcpio -p linux-lts
```

## Firewall

[Basic Instructions](https://wiki.archlinux.org/index.php/Simple_stateful_firewall)

Put appropriate rules into `/etc/iptables/iptables.rules` and
`/etc/iptables/ip6tables.rules`. Then start services:

```
sudo ln -s /etc/runit/sv/ip6tables /run/runit/service
sudo ln -s /etc/runit/sv/iptables /run/runit/service
sudo sv status iptables
sudo sv status ip6tables
```

## Custom DNS servers + caching

Adjust `server_names` at `/etc/dnscrypt-proxy/dnscrypt-proxy.toml`.

Create directory for logs: `mkdir -p /var/log/dnscrypt-proxy`.

Start caching service and adjust connections:

```
ln -s /etc/runit/sv/dnscrypt-proxy /run/runit/service/
```

To prevent NetworkManager from configuring
DNS edit `/etc/NetworkManager/conf.d/dns.conf`:

```
[main]
dns=none
```

Restart service to apply configuration: `sudo sv restart NetworkManager`.

Now put proper DNS into `/etc/resolv.conf`:

```
nameserver 127.0.0.1
```

Test result by running request 2 times (expected 0ms delay second time): `drill github.com`.

## Printer setup

```
sudo pacman -S cups-runit splix
# then start cups service using runit
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

## Switch to LTS kernel

1. Install LTS kernel: `sudo pacman -S linux-lts acpi_call-lts`.
2. Switch GRUB timeout back to > 0 value and regenerate Grub config.
3. Reboot > at Grub menu select Advanced > Arch with linux-lts.
4. Verify if everything is OK after boot.
5. Remove linux latest kernel: `sudo pacman -Rs linux acpi_call`.
6. Regenerate inital ramdisk `sudo mkinitcpio -p linux-lts`.
6. Get `GRUB_TIMEOUT` back and regenerate config again.

## Remove obsolete startup entries

```
sudo rm -f /etc/xdg/autostart/geoclue-demo-agent.desktop
```

Plus inspect autostart directory manually.

## Yarn

```
yarn config set prefix $HOME/.local/share/yarn
```

## PostgreSQL

Add next lines to `/etc/runit/sv/postgresql/run`:

```
mkdir -p /var/run/postgresql
chown -R postgres:postgres /var/run/postgresql
```

Then start service: `sudo ln -s /etc/runit/sv/postgresql /run/runit/service`

Next user and db can be created:

```
sudo -iu postgres
createuser --interactive
createdb testdbname
```

Connect to DB: `psql -d testdbname`

## Librewolf

Scroll speed (`about:config`):

```
mousewheel.min_line_scroll_amount: 20
```

Re-enable locale (`/usr/lib/librewolf/librewolf.cfg`):


```
lockPref("javascript.use_us_english_locale", false);
lockPref("intl.regional_prefs.use_os_locales", true);
# defaultPref("intl.locale.requested", "en-US");
```

## Done!
