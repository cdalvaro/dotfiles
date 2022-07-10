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
