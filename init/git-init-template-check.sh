#!/bin/sh
rm -rf ${HOME}/template
mkdir -p ${HOME}/template
echo "random content" > ${HOME}/template/content.txt

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


echo "Running git init --separate-git-dir=.repository"
git init --template=${HOME}/template

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

ls -l .git
