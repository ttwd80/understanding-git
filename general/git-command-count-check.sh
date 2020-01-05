#!/bin/sh
COUNT=$(curl --silent "https://raw.githubusercontent.com/git/git/master/command-list.txt" | grep "^git-" | wc -l | awk '{print $1}')
test "${COUNT}" == "$(cat ${HOME}/build/ttwd80/understanding-git/general/git-command-count.txt)"
