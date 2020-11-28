#!/bin/bash
## Usage: script-template.sh [options]
##    options
##       -e --example            Run example program
##       -h --help               This text

BASE=$(cd "$(dirname "$0")" || exit; pwd -P)
# Use our logging module -- 
# The logging script must be in your path. Correct the path if needed for your environment.
logscript=`which logto.sh`
source $logscript ; ret=$?
if [[ $ret -eq 1 ]] ; then
  echo "$HOME/bin/logto.sh not found. Exiting." ; exit $ret
fi
PROG=` basename $0 `
thisScript="${0}"
logTag="tagForTesting"

usage() {
   grep "^## " "${BASH_SOURCE[0]}" | cut -c 4-
   exit 0
}

[[ $# == 0 ]] && usage

example() {
   warn "This is just an example."
}

EXAMPLE=

while [[ $# -gt 0 ]]; do
   key="$1"
   case $key in
      -h|--help)
         usage
         ;;
      -e|--example)
         EXAMPLE=1
         ;;
   esac
   shift
done

if [[ -n "$EXAMPLE" ]]; then
   example
fi

# Here is a section demonstrating an approach to logging - Delete if not needed
log "${0} - This is a test.  Logging an LOG message ${logTag}"
logTag="StartOfSomethingNotable"
info "${0} - This is a test.  Logging an INFO message ${logTag}"
logTag=""
warn "${0} - This is a test.  Logging an WARN message ${logTag}"
logTag="New function for input"
error "${0} - This is a test.  Logging an ERROR message ${logTag}"
logTag="StartOfDebuggingSection"
debug "${0} - This is a test.  Logging an DEBUG message ${logTag}"
logTag=""

