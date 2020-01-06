#!/bin/bash

git_init_shared() {
  umask 0077
  rm -rf ${HOME}/work
  mkdir -p ${HOME}/work
  cd ${HOME}/work

  echo "Running git init --shared=$1"
  git init --shared=$1

  ls -ld .git
  ls -l .git
}


#invalid
git_init_shared garbage

#default
git_init_shared false

#group
git_init_shared true

#all
git_init_shared all

#custom
git_init_shared 0707
