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
    ./python/generate-commands.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    1 \
    "Main Porcelain Commands" > markdown/section-1/index.md

# Section 2
# Ancillary Commands / Manipulators
echo "Processing section-2/index.md..."
mkdir -p markdown/section-2
pipenv run python \
    ./python/generate-commands.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    2 \
    "Ancillary Commands / Manipulators" > markdown/section-2/index.md

# Section 3
# Ancillary Commands / Manipulators
echo "Processing section-3/index.md..."
mkdir -p markdown/section-3
pipenv run python \
    ./python/generate-commands.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    3 \
    "Ancillary Commands / Interrogators" > markdown/section-3/index.md

# Section 4
# Interacting with Others
echo "Processing section-4/index.md..."
mkdir -p markdown/section-4
pipenv run python \
    ./python/generate-commands.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    4 \
    "Interacting with Others" > markdown/section-4/index.md

# Section 5
# Low-level Commands / Manipulators
echo "Processing section-5/index.md..."
mkdir -p markdown/section-5
pipenv run python \
    ./python/generate-commands.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    5 \
    "Low-level Commands / Manipulators" > markdown/section-5/index.md

echo "Done."