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

# Claude Code
function cc-swiftui() {
  local agent_file="${HOME}/Developer/github/twostraws/SwiftAgents/AGENTS.md"
  if [[ ! -f "${agent_file}"]]; then
    echo "✗ Unable to find ${agent_file}" >&2
    return 1
  fi

  rsync -a "${agent_file}" ./CLAUDE.md \
    && echo "✓ CLAUDE.md for SwiftUI is ready. Good coding!" \
    || echo "✗ Failed to copy ${agent_file}" >&2
}
