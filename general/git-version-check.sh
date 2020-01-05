#!/bin/sh
git --version | grep "$(cat git-version.txt)$"
