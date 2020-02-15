#!/bin/sh

echo "Setup Python"
rm -rf markdown
pipenv clean
pipenv run pip install -q pexpect==4.8.0 Jinja2==2.11.1

#Intro
export TEMPLATE_MULTIPLE_SECTIONS="$(pipenv run python ./python/docker-execute.py ./python/intro.txt python 'su - backup -s /bin/sh' | grep -v '^\$')"
pipenv run python ./python/generate-markdown.py
