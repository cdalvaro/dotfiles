#!/usr/bin/env zsh

# macOS specific settings

# -- iTerm2
if [[ "${TERM_PROGRAM}" == "iTerm.app" ]]; then
  zi snippet OMZP::iterm2
  zstyle :omz:plugins:iterm2 shell-integration yes
fi

# Claude Code
function cc-swiftui() {
  local agent_file="${HOME}/Developer/github/twostraws/SwiftAgents/AGENTS.md"
  if [[ ! -f "${agent_file}" ]]; then
    echo "✗ Unable to find ${agent_file}" >&2
    return 1
  fi

  rsync -a "${agent_file}" ./CLAUDE.md \
    && echo "✓ CLAUDE.md for SwiftUI is ready. Good coding!" \
    || echo "✗ Failed to copy ${agent_file}" >&2
}

# OpenCore Legacy Patcher
if nvram 4D1FDA02-38C7-4A6A-9CC6-4BCCA8B30102:opencore-version >/dev/null 2>&1; then

  ## Open Electron app using OpenGL
  # https://github.com/dortania/OpenCore-Legacy-Patcher/issues/1145
  function oclp-open-elapp() {
    local app_name="$*"
    open "/Applications/${app_name}.app" --args --use-angle=gl
  }

fi
