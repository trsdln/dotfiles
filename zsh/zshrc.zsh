export DOTFILES_PATH="${HOME}/.dotfiles"

# ZSH specific configuration
source "${DOTFILES_PATH}/zsh/config.zsh"

source "${DOTFILES_PATH}/zsh/common.zsh"

if [ "$OSTYPE" = "linux-gnu" ]; then
  source "${DOTFILES_PATH}/zsh/linux.zsh"
fi
