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

# `aurutils` usage

```
# install package
aur sync <package> && sudo pacman -S <package>

# remove package from local repo
repo-remove /home/custompkgs/custom.db.tar <package>
sudo pacman -Suy

# list packages at local repo
aur repo -l
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
# scan off
```

# Docker

Start docker daemon: `sudo dockerd`
