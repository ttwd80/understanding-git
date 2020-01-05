#!/bin/sh
GIT_COMMAND_COUNT_EXPECTED="$(cat ${HOME}/build/ttwd80/understanding-git/general/git-command-count.txt)"
GIT_COMMAND_COUNT_ACTUAL="$(curl --silent "https://raw.githubusercontent.com/git/git/master/command-list.txt" | grep "^git-" | wc -l | awk '{print $1}')"
test "${GIT_COMMAND_COUNT_EXPECTED}" = "${GIT_COMMAND_COUNT_ACTUAL}"
