extract_options() {
  git $1 --help | grep "^\s*-" | grep -o -- "--.*" | sed -e 's/,.*//' -e 's/=.*//' | grep -v "^..$" | awk '{print $1}' | sort
}
