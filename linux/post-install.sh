#/bin/sh

# enable DHCP
ln -s /etc/sv/dhcpcd /var/service/
# check network interfaces
# ip link
# ip link set <interface_name> up

# allow wheel to run sudo commands:
visudo
# then uncomment "%wheel ALL=(ALL) ALL"

# Add main user
useradd taras
usermod -aG wheel taras
# and set password
passwd taras

# Grub
# achieve the fastest possible boot:
echo 'GRUB_FORCE_HIDDEN_MENU="true"' >> /etc/default/grub


# base setup
xbps-install -S tlp
ln -s /etc/sv/tlp /var/service/

# dev env
xbps-install -S git

# runit:
# sv up service_name
# sv down service_name
# sv restart service_name
# sv status service_name

# turn off
# sudo shutdown -h now
# resart
# sudo shutdown -r now
# hibernation
# ZZZ
# sleep
# zzz
