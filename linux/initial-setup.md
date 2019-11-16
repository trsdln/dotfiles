## Arch Setup

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

### User Creation

```
useradd taras
usermod -aG wheel,users,audio,video,input,lp taras
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
pacman -S ffcast google-cloud-sdk paper-icon-theme-git
pacman -S aic94xx-firmware wd719x-firmware
# For aic94xx & wd719x:
mkinitcpio -p linux
```

#### Done!
