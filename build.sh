#!/bin/sh

echo "Setup Python"
rm -rf markdown && mkdir markdown
pipenv clean && pipenv run pip install -q pexpect==4.8.0 Jinja2==2.11.1

#Intro
echo "Processing intro.md..."
export TEMPLATE_MULTIPLE_SECTIONS="$(pipenv run python ./python/docker-execute.py ./python/intro.txt python 'su - backup -s /bin/sh' | grep -v '^\$')"
export TEMPLATE_SINGLE_VERSION="$(pipenv run python ./python/docker-execute.py ./python/version.txt python 'su - backup -s /bin/sh' | grep -v '^\$' | awk '{print $3}')"
pipenv run python \
    ./python/generate-markdown.py \
    intro.md.jinja \
    TEMPLATE_MULTIPLE_SECTIONS,TEMPLATE_SINGLE_VERSION > markdown/intro.md

echo "Done."