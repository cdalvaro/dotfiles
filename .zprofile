#!/usr/bin/env zsh

# https://unix.stackexchange.com/a/71258/355495
# Just for my own notes / confirmation and to help anybody else, the ultimate order is:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# Avoid loading Oh-my-zsh magic functions, bracketed-paste-magic among other
export DISABLE_MAGIC_FUNCTIONS=true

# Fuzzy settings
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS=(
    --ansi --height 90% --layout=reverse --border --inline-info
    '--preview="_fzf_preview {} 2> /dev/null"'
    --bind ctrl-j:preview-page-down --bind ctrl-k:preview-page-up
    --bind ctrl-p:toggle-preview
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

# zsh-autosuggestions settings
export ZSH_AUTOSUGGEST_USE_ASYNC=true
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=140

# GPG key
export GPG_TTY=$(tty)

if [[ -n $SSH_CONNECTION ]]; then
  # Preferred editor for remote sessions
  export EDITOR='vim'

  # Autostart tmux session in remote session
  export ZSH_TMUX_AUTOSTART=true
else
  # Preferred editor for local sessions
  export EDITOR='mvim --remote-wait-silent'
  export HOMEBREW_EDITOR='mvim --remote-silent'
fi

# Configuration based in terminal program
if [[ $LC_TERMINAL == 'iTerm2' ]]; then
  export ZSH_TMUX_ITERM2=true
fi
