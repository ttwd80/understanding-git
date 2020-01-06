#!/bin/bash
COMMAND=init
source ${HOME}/build/ttwd80/understanding-git/general/functions.sh
diff <(extract_options ${COMMAND}) <(cat ${HOME}/build/ttwd80/understanding-git/init/git-${COMMAND}-options.txt)
