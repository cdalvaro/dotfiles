# Uncomment this line for profiling
# After having load .zshrc execute: zprof
# More info at: https://blog.mattclemente.com/2020/06/26/oh-my-zsh-slow-to-load.html
# zmodload zsh/zprof

# https://unix.stackexchange.com/a/71258/355495
# Just for my own notes / confirmation and to help anybody else, the ultimate order is:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# Path to your oh-my-zsh installation.
export ZSH=${HOME}/.oh-my-zsh

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

# forgit aliases
forgit_checkout_branch=fgcb

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(
  brew colored-man-pages docker docker-compose
  fasd fd fzf git forgit osx ripgrep
  salt thefuck tmux xcode extract
)

source $ZSH/oh-my-zsh.sh

# iTerm 2 integration
test "${TERM_PROGRAM}" = "iTerm.app" && \
  test -f ${HOME}/.iterm2_shell_integration.zsh && \
  source ${HOME}/.iterm2_shell_integration.zsh

# Completions
if [[ -v HOMEBREW_PREFIX ]]; then
  # zsh completions
  FPATH=${HOMEBREW_PREFIX}/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit -i

  # zsh autosuggestions
  export ZSH_AUTOSUGGEST_USE_ASYNC=true
  test -f ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh && \
    source ${HOMEBREW_PREFIX}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

  # zsh syntax highlighting
  test -f ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh && \
    source ${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Show completion menu when number of options is at least 2
zstyle ':completion:*' menu select=2

# Starship prompt
# https://starship.rs/config/
eval $(starship init zsh)
