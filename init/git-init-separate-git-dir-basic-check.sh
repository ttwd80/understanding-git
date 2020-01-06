#!/bin/sh
rm -rf ${HOME}/work
mkdir -p ${HOME}/work
cd ${HOME}/work

#git status before git init
if git status
then
  echo "git status - ok"
else
  echo "git status - failed"
fi

if test -d .git
then
  echo ".git directory exists"
else
  echo ".git directory does not exist"
fi

if test -f .git
then
  echo ".git file exists"
  cat .git
else
  echo ".git file does not exist"
fi

if test -d .repository
then
  echo ".repository directory exists"
else
  echo ".repository directory does not exist"
fi

echo "Running git init --separate-git-dir=.repository"
git init --separate-git-dir=.repository

if git status
then
  echo "git status - ok"
else
  echo "git status - failed"
fi

if test -d .git
then
  echo ".git directory exists"
else
  echo ".git directory does not exist"
fi

if test -f .git
then
  echo ".git file exists"
  cat .git
else
  echo ".git file does not exist"
fi

if test -d .repository
then
  echo ".repository directory exists"
else
  echo ".repository directory does not exist"
fi
