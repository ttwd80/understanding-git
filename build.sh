#!/bin/sh

echo "Setup Python"
rm -rf markdown && mkdir markdown
pipenv clean && pipenv run pip install -q pexpect==4.8.0 Jinja2==2.11.1

#Intro
echo "Processing intro.md..."
export TEMPLATE_HELP_CONTENT="$(docker run -it --rm python su - backup -s /bin/sh -c 'git help -a | cat')"
export TEMPLATE_MULTIPLE_SECTIONS="$(echo "${TEMPLATE_HELP_CONTENT}" | grep -vE '>|<' | grep '^[A-Z].*')"
export TEMPLATE_SINGLE_VERSION="$(docker run -it --rm python su - backup -s /bin/sh -c 'git --version' | cut -f 3 -d' ')"
pipenv run python \
    ./python/generate-markdown.py \
    intro.md.jinja \
    TEMPLATE_MULTIPLE_SECTIONS,TEMPLATE_SINGLE_VERSION > markdown/intro.md

# Section 1
# Main Porcelain Commands
echo "Processing section-1/index.md..."
mkdir -p markdown/section-1
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    1 \
    "Main Porcelain Commands" > markdown/section-1/index.md

# Section 2
# Ancillary Commands / Manipulators
echo "Processing section-2/index.md..."
mkdir -p markdown/section-2
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    2 \
    "Ancillary Commands / Manipulators" > markdown/section-2/index.md

# Section 3
# Ancillary Commands / Manipulators
echo "Processing section-3/index.md..."
mkdir -p markdown/section-3
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    3 \
    "Ancillary Commands / Interrogators" > markdown/section-3/index.md

# Section 4
# Interacting with Others
echo "Processing section-4/index.md..."
mkdir -p markdown/section-4
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    4 \
    "Interacting with Others" > markdown/section-4/index.md

# Section 5
# Low-level Commands / Manipulators
echo "Processing section-5/index.md..."
mkdir -p markdown/section-5
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    5 \
    "Low-level Commands / Manipulators" > markdown/section-5/index.md

# Section 6
# Low-level Commands / Interrogators
echo "Processing section-6/index.md..."
mkdir -p markdown/section-6
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    6 \
    "Low-level Commands / Interrogators" > markdown/section-6/index.md

# Section 7
# Low-level Commands / Synching Repositories
echo "Processing section-7/index.md..."
mkdir -p markdown/section-7
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    7 \
    "Low-level Commands / Synching Repositories" > markdown/section-7/index.md

# Section 8
# Low-level Commands / Internal Helpers
echo "Processing section-8/index.md..."
mkdir -p markdown/section-8
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    8 \
    "Low-level Commands / Internal Helpers" > markdown/section-8/index.md

# Section 1/8, Command 21/39
# git init
echo "Processing section-1/init.md 21/39..."
export TEMPLATE_GIT_HELP="$(docker run -it --rm python su - backup -s /bin/sh -c 'git init -help | grep -v ^usage:')"
export TEMPLATE_GIT_EXAMPLE_1="$(pipenv run python python/docker-execute.py session/section-1/add/example-1.txt python "su - -c 'useradd -m git -s /bin/sh && su - git'")"
pipenv run python \
    ./python/generate-command.py \
    ./section-1/init.md.jinja 1 > ./markdown/section-1/init.md


echo "Done."