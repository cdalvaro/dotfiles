#!/usr/bin/env zsh

# https://unix.stackexchange.com/a/71258/355495
# Just for my own notes / confirmation and to help anybody else, the ultimate order is:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
ZSH_THEME=powerlevel10k/powerlevel10k
test -f ~/.p10k.zsh && source ~/.p10k.zsh

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT=true

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION=false

# Disable completion insecurities handler
ZSH_DISABLE_COMPFIX=true

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
    brew colored-man-pages
    docker docker-compose
    fasd fd fzf git
    forgit osx python ripgrep
    salt sudo tmux xcode extract
)

source $ZSH/oh-my-zsh.sh

# 256-terminal color
export TERM="xterm-256color"

# iTerm 2 integration
test -f ~/.iterm2_shell_integration.zsh && source ~/.iterm2_shell_integration.zsh

# ZSH syntax highlighting
fpath=(/usr/local/share/zsh-completions $fpath)

export ZSH_AUTOSUGGEST_USE_ASYNC=true
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

autoload -U +X compinit && compinit

# Show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2
