# NetworkManager

Connect to WiFi:

```
sudo nmcli r wifi on
sudo nmcli r wifi off
sudo nmcli d wifi list
sudo nmcli d wifi connect "point_name" password "password_val"
```

# Sound

TUI app: `alsamixer`

### Restart PulseAudio

```
pulseaudio --k
pulseaudio --start
```

Usually is used to apply/load new configuration (also, fixes problems with Bluetooth headset).

# `aurutils` usage

```
# install package
aur sync <package> && sudo pacman -S <package>

# add package to local repo manually
repo-add custom.db.tar ./<package>.pkg.tar

# remove package from local repo
repo-remove /home/custompkgs/custom.db.tar <package>
sudo pacman -Suy

# list not installed AUR packages
pacman -Sl custom | grep -v installed | cut -d " " -f 2

# list packages at local repo
aur repo -l

# trust unknown key
gpg --recv-key <key_id>
```

# Extract tar

```
tar -xvzf <file.name>
```

# Change default viewing program for xdg-open

```
mimeopen -d $file.pdf
```

# unrar usage

```
unrar x <archive.file.name>
```

# Bluetooth

Ensure device is not hard/soft blocked. Hard - enable via hardware button.
Soft unblock via:

```
rfkill list
sudo rfkill unblock bluetooth
```

Then pair device:

```
bluetoothctl
# scan on
# devices
# pair <mac>
# connect <mac>
# trust <mac>
# scan off
```

# Docker

Start docker daemon: `sudo dockerd`

# Inspect window class

```
xprop WM_CLASS
```

And then click on target window.

# Mirrorlist ranking

Save output of

```
curl -s "https://www.archlinux.org/mirrorlist/?country=PL&country=DE&country=CZ&country=UA&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 -
```

at `/etc/pacman.d/mirrorlist`. Better backup it before replacing

# Find PID that blocking device unmount

```
lsof +f -- /dev/sda2
```

