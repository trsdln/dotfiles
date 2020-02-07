## Setup

1. Clone this repo into `~/.dotfiles`
2. Clone zprezto into `~/.dotfiles/zsh/zprezto`:
   `git clone --recursive git@github.com:trsdln/prezto.git "${HOME}/.dotfiles/zprezto"`
3. Link configs
4. [macos] Change default shell to zsh: `chsh -s /bin/zsh`
5. [macos] Specify iTerm2 configuration path manually in preferences

### Linking

Links all dot files to home directory

```
./configs-link
```

### Unlinking

Removes all dot files links

```
./configs-link unlink
```

## VIM/TMUX setup

1. Install Universal Ctags, Ripgrep and Vim with python3 support

```
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
brew install vim ripgrep fzf
brew install tmux reattach-to-user-namespace tmux-mem-cpu-load osx-cpu-temp
brew install gpg pass pinentry-mac
```

2. Start vim and install plugins itself

```
:PackUpdate
```

## Neovim

1. Python3 support:

```
pip3 install --user --upgrade pynvim
```
