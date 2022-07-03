#!/usr/bin/env zsh

# List directories
if type exa &>/dev/null; then
  # https://the.exa.website
  export EXA_STRICT=true
  alias ll='exa --long --header --group --git --modified --color-scale --icons'
else
  alias ll='ls -lhG'
fi

# Trash
type trash &>/dev/null && alias rm='trash'

# NeoVim
alias vi='nvim'
alias gvi='vimr'

# Visual Studio Code
alias vs='code'
