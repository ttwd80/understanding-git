#!/bin/sh
git --version | grep "$(cat ${HOME}/build/ttwd80/understanding-git/general/git-version.txt)$"
