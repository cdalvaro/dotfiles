#!/usr/bin/env zsh

# List directories
if type eza &>/dev/null; then
  # https://eza.rocks
  export EZA_STRICT=true
  alias ll='eza --long --header --group --git --modified --color-scale=size --icons=automatic'
else
  alias ll='ls -lhG'
fi

# Trash
type trash &>/dev/null && alias rm='trash'

# The fuck
alias copon=fuck
alias ea=fuck

# NeoVim
alias vi='nvim'
alias gvi='vimr'

# Visual Studio Code
alias vs='code'
