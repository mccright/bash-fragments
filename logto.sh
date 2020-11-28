#!/bin/bash
#
# Description: Generic logger for Bash scripts
# This script started with code from: 
#              https://github.com/giao/logger.sh/blob/master/logger.sh
#
# Usage:
#   log "message"    //log message
#   info "message"   //info message
#   warn "message"   //warning message
#   err "message"    //error message
#   error "message"  //error message
#   dbg "message"    //debug message
#   debug "message"  //debug message
#
# Integration into your script:
#   put the following lines at beginning of your script:
#
#   PROG=` basename $0 `
#   source $HOME/bin/logto.sh ; ret=$?
#   if [[ $ret -eq 1 ]] ; then
#     echo "$HOME/bin/logto.sh not found. Exiting." ; exit $ret
#   fi
#   thisScript="${0}"
# Here is some example usage:
#   logTag="InScriptTesting"
#   log "${0} - This is a test.  Logging an LOG message ${logTag}"
#   logTag="NewSectionTesting"
#   info "${0} - This is a test.  Logging an INFO message ${logTag}"
#   logTag="EndOfNewSectionTesting"
#   warn "${0} - This is a test.  Logging an WARN message ${logTag}"
#   logTag="New function for input"
#   error "${0} - This is a test.  Logging an ERROR message ${logTag}"
#   debug "${0} - This is a test.  Logging an DEBUG message ${logTag}"
#

## PROG is caller program
PROG=$1
TIMESTAMP=$(date "+%Y-%m-%d-%H%M%S")
# Include a use-case-specific logTag in your script
logTag="logger"
# Path to the log directory
myLogDir="/home/${USER}/logs"
# myLogFile="${myLogDir}/${logTag}-${TIMESTAMP}.log"
# In some environments logging by script name is more appropriate
# Set the script variable in your script:
# This approach will support script-unique log names
thisScript="${0}"
myLogFile="${myLogDir}/${thisScript}-${TIMESTAMP}.log"

function logToFile() {
  # log to syslog first
  logger -i -e -p syslog.$LVL -t ${logTag} -- "${1}"
  # Now log to your app-specific file
  echo -e "${1}" >> ${myLogFile}
  :
}

function log() {
  DT=` date +'%Y-%m-%d %H:%M:%S %:z %Z'`
  case $1 in
  'INFO')
    LVL='INFO'
    MSG="${@:2}"
    ;;
  'WARN')
    LVL='WARN'
    MSG="${@:2}"
    ;;
  'ERR' | 'ERROR')
    LVL='ERROR'
    MSG="${@:2}"
    ;;
  'DBG' | 'DEBUG')
    LVL='DEBUG'
    MSG="${@:2}"
    ;;
  'LOG')
    LVL='LOG'
    MSG="${@:2}"
    ;;
  *)
    LVL='LOG'
    MSG="$*"
    ;;
  esac

  if [ "A$PROG" == "A" ] ; then
    # echo -e "$DT\t$LVL\t$MSG"
    logToFile "$DT $LVL $MSG;"
  else
    # echo -e "$DT\t$LVL\t$PROG\t$MSG"
    logToFile "$DT - $PROG - $LVL - $MSG;"
  fi
}

function info() {
  log INFO $*
}
function warn() {
  log WARN $*
}
function err() {
  log ERROR $*
}
function error() {
    log ERROR $*
}
function dbg() {
  log DEBUG $*
}

function debug() {
  log DEBUG $*
}
