#!/usr/bin/env zsh

# https://unix.stackexchange.com/a/71258/355495
# Just for my own notes / confirmation and to help anybody else, the ultimate order is:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# Homebrew
[[ -n "${HOMEBREW_PREFIX}" ]] && eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

# User path
export PATH="${HOME}/.local/bin:${PATH}"

# Added by Obsidian
if [[ -d /Applications/Obsidian.app ]]; then
  export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"
fi
