#!/bin/sh

docker pull python:latest

echo "Setup Python"
rm -rf markdown && mkdir markdown
pipenv clean && pipenv run pip install -q pexpect==4.8.0 Jinja2==2.11.1 autopep8==1.5

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
echo "Processing section-1/README.md..."
mkdir -p markdown/section-1
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    1 \
    "Main Porcelain Commands" > markdown/section-1/README.md

# Section 2
# Ancillary Commands / Manipulators
echo "Processing section-2/README.md..."
mkdir -p markdown/section-2
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    2 \
    "Ancillary Commands / Manipulators" > markdown/section-2/README.md

# Section 3
# Ancillary Commands / Manipulators
echo "Processing section-3/README.md..."
mkdir -p markdown/section-3
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    3 \
    "Ancillary Commands / Interrogators" > markdown/section-3/README.md

# Section 4
# Interacting with Others
echo "Processing section-4/README.md..."
mkdir -p markdown/section-4
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    4 \
    "Interacting with Others" > markdown/section-4/README.md

# Section 5
# Low-level Commands / Manipulators
echo "Processing section-5/README.md..."
mkdir -p markdown/section-5
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    5 \
    "Low-level Commands / Manipulators" > markdown/section-5/README.md

# Section 6
# Low-level Commands / Interrogators
echo "Processing section-6/README.md..."
mkdir -p markdown/section-6
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    6 \
    "Low-level Commands / Interrogators" > markdown/section-6/README.md

# Section 7
# Low-level Commands / Synching Repositories
echo "Processing section-7/README.md..."
mkdir -p markdown/section-7
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    7 \
    "Low-level Commands / Synching Repositories" > markdown/section-7/README.md

# Section 8
# Low-level Commands / Internal Helpers
echo "Processing section-8/README.md..."
mkdir -p markdown/section-8
pipenv run python \
    ./python/generate-section.py \
    section-index.md.jinja \
    TEMPLATE_HELP_CONTENT \
    8 \
    "Low-level Commands / Internal Helpers" > markdown/section-8/README.md

# Section 1/8, Command 1/39
# git add
echo "Processing section-1/add.md 1/39..."
export GIT_COMMAND="add"
export TEMPLATE_GIT_HELP="$(docker run -it --rm python su - backup -s /bin/sh -c "mkdir /tmp/git && cd /tmp/git && git init -q . && git ${GIT_COMMAND} -help | grep -v ^usage:")"
pipenv run python \
    ./python/generate-command.py \
    ${GIT_COMMAND} \
    ./section-1/${GIT_COMMAND}.md.jinja \
    "" > ./markdown/section-1/${GIT_COMMAND}.md

# Section 1/8, Command 2/39
# git am
export GIT_COMMAND="am"
echo "Processing section-1/${GIT_COMMAND}.md 2/39..."
export TEMPLATE_GIT_HELP="$(docker run -it --rm python su - backup -s /bin/sh -c "mkdir /tmp/git && cd /tmp/git && git init -q . && git ${GIT_COMMAND} -help | grep -v ^usage: | grep -v '^   or:' ")"
pipenv run python \
    ./python/generate-command.py \
    ${GIT_COMMAND} \
    ./section-1/${GIT_COMMAND}.md.jinja \
    "" > ./markdown/section-1/${GIT_COMMAND}.md


# Section 1/8, Command 21/39
# git init
export GIT_COMMAND="init"
echo "Processing section-1/${GIT_COMMAND}.md 21/39..."
export TEMPLATE_GIT_HELP="$(docker run -it --rm python su - backup -s /bin/sh -c "git ${GIT_COMMAND} -help | grep -v ^usage:")"
export EXAMPLES="$(echo ./session/section-1/init/example-*.txt | sed -e 's#./session/section-1/init/example-##g' -e 's/.txt//g')"
for ID in ${EXAMPLES}
do
    export TEMPLATE_GIT_EXAMPLE_${ID}="$(pipenv run python python/docker-execute.py session/section-1/${GIT_COMMAND}/example-${ID}.txt python "su - -c 'useradd -m git -s /bin/sh && su - git'")"
done
pipenv run python \
    ./python/generate-command.py \
    ${GIT_COMMAND} \
    ./section-1/${GIT_COMMAND}.md.jinja \
    "$(echo ${EXAMPLES} | sed 's/ /,/g')" > ./markdown/section-1/${GIT_COMMAND}.md


echo "Done."