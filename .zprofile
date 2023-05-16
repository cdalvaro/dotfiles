#!/usr/bin/env zsh

# https://unix.stackexchange.com/a/71258/355495
# Just for my own notes / confirmation and to help anybody else, the ultimate order is:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# Homebrew env
if [[ "$(uname -m)" == 'arm64' ]]; then
  HOMEBREW_PREFIX=/opt/homebrew
else
  HOMEBREW_PREFIX=/usr/local
fi

export HOMEBREW_NO_GOOGLE_ANALYTICS=true
eval $(${HOMEBREW_PREFIX}/bin/brew shellenv)

# Ruby settings
export PATH="$(brew --prefix ruby)/bin:$PATH"
export PATH="$(gem env gemdir)/bin:$PATH"

# Avoid loading Oh-my-zsh magic functions, bracketed-paste-magic among other
export DISABLE_MAGIC_FUNCTIONS=true

# Fuzzy settings
# Colors from: https://github.com/catppuccin/fzf/blob/main/mocha.md
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS=(
    --ansi --height 90% --layout=reverse --border --inline-info
    '--preview="_fzf_preview {} 2> /dev/null"'
    --bind ctrl-j:preview-page-down --bind ctrl-k:preview-page-up
    --bind ctrl-p:toggle-preview
    --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc
    --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
)

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --color always --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --color always --exclude ".git" . "$1"
}

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export DISABLE_FZF_AUTO_COMPLETION=false
export DISABLE_FZF_KEY_BINDINGS=false

# ripgrep settings
# https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
export RIPGREP_CONFIG_PATH="${HOME}/.ripgreprc"

# bat settings
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# zsh-autosuggestions settings
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=140

# GPG key
export GPG_TTY=$(tty)

# Preferred editors
export EDITOR='nvim'
export GIT_EDITOR='nvim'

if [[ -n $SSH_CONNECTION ]]; then
  # Autostart tmux session in remote session
  export ZSH_TMUX_AUTOSTART=true
else
  # Preferred editor for local sessions
  export EDITOR='bbedit --wait'
  export HOMEBREW_EDITOR='bbedit'
fi
