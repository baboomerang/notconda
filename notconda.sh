#!/bin/bash

######################################################
#
# NotConda Script
# Usage: ./notconda create env-name
#        ./notconda activate env-name
#        ./notconda deactivate
#
# Creates and manages pip VENV environments in a global central directory
#
# Normally, pip VENV installs the environment in the local project folder.
# However, if a user wants to reuse those environments for other projects,
#   they would need to memorize and type long paths to activate the envs.
#
# This tool is for Linux users that want easy virtual environment management
#   but do not want to install Anaconda or other bloated venv managers
#
# DISCLAIMER: THIS SOFTWARE IS PROVIDED "AS IS" AND "WITH ALL FAULTS",
# WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
# BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
# OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
# OR OTHER DEALINGS IN THE SOFTWARE.
#
######################################################


__usage="\
Usage: notconda [OPTIONS]
Options:
  create    <env-name>, Create a new pip virtual environment
  activate  <env-name>, Source the \"<env-name>/bin/activate\" file
  deactivate            Exit the current virtual environment (if inside one)
  list                  Print all virtual environments in \"\${HOME}/.venvs/\"
  -h, --help            Print this help message and exit

Name Rules:
  env-names can be alphanumeric and contain '-' or '_' or '.'
  env-names CANNOT START WITH '.' AND CANNOT HAVE '..' NOR '/'

Examples:
  notconda create nodeenv
  notconda activate nodeenv\
"


VENVPATH="${HOME}/.venvs"

is_valid() {
  local env_name="$1"
  if [[ "$env_name" =~ ^((?!(^\.)|\.{2}|\/)[a-zA-Z0-9\.\-\_])+$ ]]; then
    echo "Invalid envname: '$env_name'" >&2
    echo "Try 'notconda -h' for valid envname rules"
    return 1
  fi
  return 0
}

create() {
  local env_name="$1"
  python -m venv "${VENVPATH}/${env_name}"
}

activate() {
  local env_name="$1"
  source "${VENVPATH}/${env_name}/bin/activate"
}

if [ "$0" = "$BASH_SOURCE" ]; then
  echo "Needs to be run using source: . notconda.sh" >&2
else
  case "$1" in
    'create' | 'activate')
      if is_valid "$2"; then
        "$1" "$2"
      fi
      ;;
    'deactivate')
      deactivate
      ;;
    'list')
      for file in "${VENVPATH}"/*; do
        echo $(basename "$file")
      done
      ;;
    '' | '-h' | '--help')
      echo "$__usage"
      ;;
    *)
      echo "Unknown parameter passed: $1" >&2
      echo "Try 'notconda -h' for usage"
      ;;
  esac
  unset -f is_valid create activate
  unset VENVPATH
fi
