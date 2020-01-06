#!/bin/bash
GIT_VERSION_EXPECTED="$(cat ${HOME}/build/ttwd80/understanding-git/general/git-version.txt)"
GIT_VERSION_ACTUAL="$(git --version | awk '{print $3}')"
test "${GIT_VERSION_EXPECTED}" = "${GIT_VERSION_ACTUAL}"
