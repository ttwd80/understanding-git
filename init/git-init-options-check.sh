#!/bin/sh
source ${HOME}/build/ttwd80/understanding-git/general/functions.sh
diff <(extract_options "https://raw.githubusercontent.com/git/git/master/builtin/init-db.c") <(cat ${HOME}/build/ttwd80/understanding-git/init/git-init-options.txt)
