#!/usr/bin/env zsh

# https://unix.stackexchange.com/a/71258/355495
# Just for my own notes / confirmation and to help anybody else, the ultimate order is:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# -- Initial shell level
export INIT_SHELL_LEVEL=$SHLVL

# -- Language settings
export LANG=en_US.UTF-8
export LC_ALL=$LANG

# Homebrew env
if [[ $(uname) == 'Darwin' ]]; then
  if [[ $(uname -m) == 'arm64' ]]; then
    export HOMEBREW_PREFIX=/opt/homebrew
  else
    export HOMEBREW_PREFIX=/usr/local
  fi
fi

# -- Preferred editors
export EDITOR='nvim'
export GIT_EDITOR='nvim'

export ZSH_TMUX_FIXTERM=false

## -- Remote/local sessions
if [[ -n $SSH_CONNECTION ]]; then
  ### tmux
  export ZSH_TMUX_AUTOSTART=true
else
  ### Editos
  export EDITOR='bbedit --wait'
  export HOMEBREW_EDITOR='bbedit'
fi
