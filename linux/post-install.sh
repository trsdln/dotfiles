#/bin/sh

# enable DHCP
ln -s /etc/sv/dhcpcd /var/service/

# check network interfaces
ip link

# allow wheel to run sudo commands:
visudo
# then uncomment "%wheel ALL=(ALL) ALL"

# Add main user
useradd taras
usermod -aG wheel taras
# and set password
passwd taras

xbps-install -S git
