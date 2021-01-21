#!/usr/bin/env zsh

# https://unix.stackexchange.com/a/71258/355495
# Just for my own notes / confirmation and to help anybody else, the ultimate order is:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# Language settings
export LANG=en_US.UTF-8
export LC_ALL=$LANG

# Homebrew env
if [[ "$(uname -m)" == 'arm64' ]]; then
  HOMEBREW_PREFIX=/opt/homebrew
else
  HOMEBREW_PREFIX=/usr/local
fi

eval $(${HOMEBREW_PREFIX}/bin/brew shellenv)
