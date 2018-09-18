#!/bin/bash

function ini() {
  if [[ -f $1 ]]
  then
    . $1
  fi  
  check_variables

  SWEEP_FILES=$(ls -1t ${TARGET_DIR}/${PREF}*${SUFF} | tail -n +$((${KEEP_NUM}+1)) )
  if [[ -z ${SWEEP_FILES} ]] ; then
    echo "There is no file to be swept."
    exit 0
  fi  
}

function check_variables(){
  if [[ -z ${TARGET_DIR} || -z ${KEEP_NUM} ]]
  then
    print_help
    exit 1
  fi  
}

function print_help() {
  cat << EOS
# SweepTool
 Tool to sweep for directories.
 
## Usage
1. Use a configration file:
 $0 /path/to/the/config/file.conf

2. Use Environment variable:
 export TARGET_DIR=...
 export KEEP_NUM=...
 $0

## Config
  TARGET_DIR : Target directory to sweep (Require)
  PREF : Sweep file prefix (Option)
  SUFF : Sweep file suffix (Option)
  KEEP_NUM : Number of files to keep (Require)
EOS
}

function sweep() {
  #Leave the specified number of new backup files, and delete others.
  echo "Start to sweep files."
  rm ${SWEEP_FILES}
  echo -e "Deleted files\n${SWEEP_FILES}" 
}

ini $1  
sweep

exit 0
