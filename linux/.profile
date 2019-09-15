# Add linux specific scripts and apps
export PATH="${HOME}/.dotfiles/linux/scripts:$PATH"

# Automatic startx on login at TTY1
if systemctl -q is-active graphical.target && [ "${DISPLAY}" = "" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
