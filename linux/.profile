export DOTFILES_PATH="${HOME}/.dotfiles"

# Add linux specific scripts and apps
export PATH="${DOTFILES_PATH}/linux/scripts:$PATH"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XAUTHORITY="${XDG_DATA_HOME}/.Xauthority"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"

. "${DOTFILES_PATH}/zsh/envs.sh"

export STATUSLINE_LOG="${HOME}/.cache/statusline.log"

# Automatic startx on login at TTY1
if systemctl -q is-active graphical.target && [ "${DISPLAY}" = "" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
