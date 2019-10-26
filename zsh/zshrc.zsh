export DOTFILES_PATH="${HOME}/.dotfiles"

# Point Zprezto to configs directory
ZDOTDIR="${DOTFILES_PATH}/zsh/zdotdir"

# Source zprofile, because by default zprezto does it
source "${DOTFILES_PATH}/zsh/zprezto/runcoms/zprofile"

# Source Prezto
source "${DOTFILES_PATH}/zsh/zprezto/init.zsh"

source "${DOTFILES_PATH}/zsh/common.zsh"

if [ "$OSTYPE" = "linux-gnu" ]; then
  source "${DOTFILES_PATH}/zsh/linux.zsh"
fi
