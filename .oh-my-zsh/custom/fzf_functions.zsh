#!/usr/bin/env zsh

# fzf function to preview content
function _fzf_preview() {
  local file="$1"
  case "$(file --brief --mime $file)" in
    inode/directory*)
      exa --long --header --group --modified --git \
        --color=always --color-scale "$file"
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

# fco - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
function fco() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf --no-hscroll --no-multi -n 2 \
      --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# fcoc - checkout git commit with previews
alias glNoGraph='git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | diff-so-fancy'"

function fcoc() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
      --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}
