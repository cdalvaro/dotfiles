#!/usr/bin/env zsh

# List directories
if type eza &>/dev/null; then
  # https://eza.rocks
  export EZA_STRICT=true
  alias ll='eza --long --header --group --git --modified --color-scale=size --icons=automatic'
else
  alias ll='ls -lhG'
fi

# Cat -> Bat
if type bat &>/dev/null; then
  alias cat='bat --paging=never'
  alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
fi

# Trash
type trash &>/dev/null && alias rm='trash'

# NeoVim
alias vi='nvim'
