#!/usr/bin/env zsh

# https://unix.stackexchange.com/a/71258/355495
# Just for my own notes / confirmation and to help anybody else, the ultimate order is:
# .zshenv → [.zprofile if login] → [.zshrc if interactive] → [.zlogin if login] → [.zlogout sometimes].

# Homebrew
[[ -n "${HOMEBREW_PREFIX}" ]] && eval "$(${HOMEBREW_PREFIX}/bin/brew shellenv)"

# Nix
if [[ -n "${NIX_PROFILE}" ]]; then
  source "${NIX_PROFILE}/etc/profile.d/nix.sh"
  GLIBC_LOCALES_PATH=$(nix-env --installed --no-name --out-path --query glibc-locales 2>/dev/null)
  [[ -n "${GLIBC_LOCALES_PATH}" ]] && export LOCALE_ARCHIVE="${GLIBC_LOCALES_PATH}/lib/locale/locale-archive"
fi

# Cargo
CARGO_DIR="${HOME}/.cargo"
if [[ -d "${CARGO_DIR}" ]] && export PATH="${CARGO_DIR}/bin:$PATH"

# rbenv
# https://github.com/rbenv/rbenv
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
  FPATH="$(brew --prefix rbenv)/completions:$FPATH"
fi

# pyenv
# https://github.com/pyenv/pyenv
if command -v pyenv >/dev/null 2>&1; then
  export PYENV_ROOT="${HOME}/.pyenv"
  [[ -d "${PYENV_ROOT}/bin" ]] && export PATH="${PYENV_ROOT}/bin:$PATH"
  eval "$(pyenv init -)"
  FPATH="$(brew --prefix pyenv)/completions:$FPATH"
fi
