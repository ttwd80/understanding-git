list-options-for-git-command() {
  git $1 --help | grep -- "^       -" | sed \
    -e 's/^       //g' \
    -e 's/, /\n/g'  \
    -e 's/=/\n/g'  \
    -e 's/ /\n/g'  \
    -e 's/,$//g' \
    -e 's/\[$//g' \
    | grep -- "^--." | sort
}
