#!/usr/bin/env zsh

# fzf function to preview content
function _fzf_preview() {
  local file="$1"
  case "$(file --brief --mime $file)" in
    inode/directory*)
      eza --long --header --group --modified --git \
        --color=always --color-scale=size --icons=automatic "$file"
      ;;
    *charset=binary)
      bold_green='\033[1;32m'
      yellow='\033[0;33m'
      reset='\033[0m'
      echo -e "${bold_green}${file}${reset} is ${yellow}binary${reset}."
      ;;
    *)
      bat --style=numbers --color=always "$file"
      ;;
  esac
}
