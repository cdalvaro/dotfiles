#!/usr/bin/env zsh

#---  FUNCTION  -------------------------------------------------------------------------------------------------------
#          NAME:  check_and_source_file
#   DESCRIPTION:  Check if a file exists and source it if it does.
#----------------------------------------------------------------------------------------------------------------------
function check_and_source_file() {
  local file="$1"

  # shellcheck disable=SC1090
  test -f "${file}" && source "${file}"
}

#---  FUNCTION  -------------------------------------------------------------------------------------------------------
#          NAME:  s
#   DESCRIPTION:  Use fzf to filter servers and call ssh with the selected server
#----------------------------------------------------------------------------------------------------------------------
function s() {
  local server
  server=$(rg '^Host ' ~/.ssh/config | rg -v '\*' | sort | awk '{print $2}' | fzf)
  if [[-n $server]]; then
    ssh $server
  fi
}
