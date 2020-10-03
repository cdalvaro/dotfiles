#!/usr/bin/env zsh

# https://unix.stackexchange.com/a/71258/355495
# Just for my own notes / confirmation and to help anybody else, the ultimate order is:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# Language settings
export LANG=en_US.UTF-8
export LC_ALL=$LANG

# Path
export PATH=$HOME/.local/sbin:/usr/local/bin:/usr/local/sbin:$PATH
export MANPATH="/usr/local/man:$MANPATH"

# Python
export PATH=/usr/local/opt/python/libexec/bin:$PATH

# Avoid loading Oh-my-zsh magic functions, bracketed-paste-magic among other
export DISABLE_MAGIC_FUNCTIONS=true
