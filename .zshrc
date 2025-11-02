#!/usr/bin/env zsh

# Uncomment this line for profiling
# After having load .zshrc execute: zprof
# More info at: https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load.html
# zmodload zsh/zprof

# https://unix.stackexchange.com/a/71258/355495
# Just for my own notes / confirmation and to help anybody else, the ultimate order is:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# Sources
## Dreams of Autonomy
## https://github.com/dreamsofautonomy/zensh
## https://github.com/dreamsofautonomy/dotfiles
## https://youtu.be/ud7YxC33Z3w?si=luI5zDr-GxfdVuqG

# -- zinit
## Set the directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

## Download Zinit, if it's not there yet
if [[ ! -d "${ZINIT_HOME}" ]]; then
  mkdir -p "$(dirname "${ZINIT_HOME}")"
  git clone https://github.com/zdharma-continuum/zinit.git "${ZINIT_HOME}"
fi

## Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# -- Plugins and compinit
## NOTE: order matters

## Before compinit
zi light zsh-users/zsh-completions

## compinit - Load completions
autoload -U compinit && compinit
zi cdreplay -q

## After compinit
zi light Aloxaf/fzf-tab
zi light zsh-users/zsh-autosuggestions # NOTE: After fzf-tab
zi light olets/zsh-abbr

### ohmyzsh
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 7
zstyle ':omz:update' verbose silent
zi light ohmyzsh/ohmyzsh

# -- Snippets
zi snippet OMZP::command-not-found
zi snippet OMZP::extract

zi ice as"completion"
zi snippet OMZP::docker/completions/_docker

zi snippet OMZP::git
zi snippet OMZP::git-auto-fetch
zi light wfxr/forgit

zi snippet OMZP::sudo
zi snippet OMZP::tmux

# -- History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# -- Colors
autoload -U colors
colors

# -- fzf-tab settings
## https://github.com/Aloxaf/fzf-tab
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --icons --color=always $realpath'
# zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2

# -- OS specific
case "$(uname)" in
Darwin) source ~/.macOS.zsh ;;
Linux) source ~/.linux.zsh ;;
*) ;;
esac

# -- bat settings
## https://github.com/sharkdp/bat
if type bat &>/dev/null; then
  alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'
  export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
fi

# -- eza
## https://github.com/eza-community/eza
if type eza &>/dev/null; then
  export EZA_STRICT=true
  alias ll='eza --long --header --group --git --modified --color-scale=size --icons=automatic'
else
  alias ll='ls -lh --color'
fi
# -- fzf settings
## https://github.com/junegunn/fzf

## Options to fzf command
export FZF_COMPLETION_OPTS="--border --info=inline --style full --preview 'fzf-preview.sh {}' --bind 'focus:transform-header:file --brief {}'"

## Use fd (https://github.com/sharkdp/fd) for listing path candidates.
## - The first argument to the function ($1) is the base path to start traversal
## - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

## Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

## Advanced customization of fzf options via _fzf_comprun function
## - The first argument to the function is the name of the command.
## - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
  cd) fzf --preview 'tree -C {} | head -200' "$@" ;;
  export | unset) fzf --preview "eval 'echo \$'{}" "$@" ;;
  ssh) fzf --preview 'dig {}' "$@" ;;
  *) fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# -- gpg
## Set the GPG_TTY to be the same as the TTY,
## either via the env var or via the tty command.
if [[ -n "${TTY}" ]]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="${TTY}"
fi

# -- ripgrep settings
## https://github.com/BurntSushi/ripgrep
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

# -- trash
type trash &>/dev/null && alias rm='trash'

# -- Aliases
alias c='clear'
alias ls='ls --color'
alias glow='glow --config ~/.config/glow/glow.yml'
alias vi='nvim'

# -- Starship prompt
# https://starship.rs/config/
eval "$(starship init zsh)"

# -- Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

# zsh-syntax-highlighting
## https://github.com/zsh-users/zsh-syntax-highlighting
## NOTE: Last plugin to be loaded
zi light zsh-users/zsh-syntax-highlighting

# zsh-syntax-highlighting styles from monokai.pro
ZSH_HIGHLIGHT_STYLES[path]=
ZSH_HIGHLIGHT_STYLES[path_pathseparator]=fg=blue,bold
ZSH_HIGHLIGHT_STYLES[path_prefix]=

# Uncomment this line for showing the generated profiling
# zprof
