#!/usr/bin/env zsh

# macOS specific settings

# -- iTerm2
if [[ "${TERM_PROGRAM}" == "iTerm.app" ]]; then
  zi snippet OMZP::iterm2
  zstyle :omz:plugins:iterm2 shell-integration yes
fi

# -- kitty
if command -v kitten &>/dev/null; then
  alias s="kitten ssh"
fi
