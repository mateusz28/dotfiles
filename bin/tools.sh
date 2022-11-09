#!/bin/bash
#
function die() {
  echo "$@"
  exit 1
}

#check step
function check_step(){
  echo -n "Continue  (y/n)?"
  read CONT
  if [ "$CONT" = "n" ]
  then
    echo "NO"
    exit 0
  else
    echo "YES"
  fi
}
