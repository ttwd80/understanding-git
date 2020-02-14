#!/bin/sh
echo Generating html content
rm -rf html
mkdir html

export GIT_VERSION=$(python src/git-version.py | grep "^git" | awk '{print $3}' | tr -d '\n\r')

#TODO - to get the latest automatically by processing https://getbootstrap.com/
export BOOTSTRAP_VERSION="4.4.1"
export BOOTSTRAP_CSS_HASH="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
export BOOTSTRAP_JS_HASH="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"

export JQUERY_VERSION="3.4.1"
export JQUERY_JS_HASH="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"

export POPPER_VERSION="1.16.0"
export POPPER_JS_HASH="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"

#intro
python src/intro.py
