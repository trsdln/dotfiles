export DOTFILES_PATH="${HOME}/.dotfiles"

# Point Zprezto to configs directory
ZDOTDIR="${DOTFILES_PATH}/zsh/zdotdir"

# Source zprofile, because by default zprezto does it
source "${DOTFILES_PATH}/zsh/zprezto/runcoms/zprofile"

# Source Prezto
source "${DOTFILES_PATH}/zsh/zprezto/init.zsh"

[ -f "${DOTFILES_PATH}/zsh/commonrc.zsh" ] && source "${DOTFILES_PATH}/zsh/commonrc.zsh"

# C-<Space> to accept suggestion
bindkey '^ ' autosuggest-accept

# Change cursor shape for different VI modes
# (is a bit buggy, but usable enough)
_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)
