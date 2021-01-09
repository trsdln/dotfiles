export DOTFILES_PATH="${HOME}/.dotfiles"

# Add linux specific scripts and apps
# Add scripts from .dotfiles and .local
export PATH="${DOTFILES_PATH}/scripts:${DOTFILES_PATH}/linux/scripts:${HOME}/.local/bin:${HOME}/.local/share/yarn/bin:${PATH}"
export PATH="${HOME}/apps/elasticsearch-7.8.0/bin:$PATH"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XAUTHORITY="${XDG_DATA_HOME}/.Xauthority"
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/password-store"
export PSQL_HISTORY="${HOME}/.cache/.psql_history"

. "${DOTFILES_PATH}/zsh/envs.sh"

export STATUSLINE_LOG="${HOME}/.cache/statusline.log"

# Automatic startx on login at TTY1
if [ "${DISPLAY}" = "" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx $XDG_CONFIG_HOME/X11/xinitrc
fi
