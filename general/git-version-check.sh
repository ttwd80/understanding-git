#!/bin/sh
GIT_VERSION="$(cat ${HOME}/build/ttwd80/understanding-git/general/git-version.txt)"
git --version | grep "${GIT_VERSION}$"
