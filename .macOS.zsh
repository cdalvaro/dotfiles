#!/usr/bin/env zsh

# macOS specific settings

# -- iTerm2
zi snippet OMZP::iterm2
zstyle :omz:plugins:iterm2 shell-integration yes

# -- kitty
if command -v kitten &>/dev/null; then
  alias s="kitten ssh"
fi
