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

# Install (one or multiple) selected application(s)
# using "brew search" as source input
# mnemonic [B]rew [I]nstall [P]lugin
function bip() {
  local inst=$(brew search | fzf -m)
  if [[ $inst ]]; then
    for prog in $(echo $inst);
    do; brew install $prog; done;
  fi
}

# Delete (one or multiple) selected application(s)
# mnemonic [B]rew [C]lean [P]lugin (e.g. uninstall)
function bcp() {
  local uninst=$(brew leaves | fzf -m)
  if [[ $uninst ]]; then
    for prog in $(echo $uninst);
    do; brew uninstall $prog; done;
  fi
}

# Update (one or multiple) selected application(s)
# mnemonic [B]rew [U]pdate [P]lugin
function bup() {
  local upd=$(brew leaves | fzf -m)
  if [[ $upd ]]; then
    for prog in $(echo $upd);
    do; brew upgrade $prog; done;
  fi
}

# Install or open the webpage for the selected application
# using brew cask search as input source
# and display a info quickview window for the currently marked application
function install() {
  local token=$(brew search | fzf-tmux --query="$1" +m --preview 'brew cask info {}')
  if [ "x$token" != "x" ]
  then
    echo "(I)nstall or open the (h)omepage of $token"
    read input
    if [ $input = "i" ] || [ $input = "I" ]; then
      brew cask install $token
    fi
    if [ $input = "h" ] || [ $input = "H" ]; then
      brew cask home $token
    fi
  fi
}

# Uninstall or open the webpage for the selected application
# using brew list as input source (all brew cask installed applications)
# and display a info quickview window for the currently marked application
function uninstall() {
  local token=$(brew cask list | fzf-tmux --query="$1" +m --preview 'brew cask info {}')
  if [ "x$token" != "x" ]
  then
    echo "(U)ninstall or open the (h)omepage of $token"
    read input
    if [ $input = "u" ] || [ $input = "U" ]; then
      brew cask uninstall $token
    fi
    if [ $input = "h" ] || [ $token = "h" ]; then
      brew cask home $token
    fi
  fi
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
