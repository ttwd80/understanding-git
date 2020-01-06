extract_options() {
  curl --silent "$1" |\
    grep -E "OPT_STRING\(|OPT_BIT\(|OPT_SET_INT\(|OPTION_CALLBACK" |\
    sed 's#{ OPTION_CALLBACK, #OPTION_CALLBACK(#' |\
    awk '{ print $2 }' |\
    sed -e 's/^"//' -e 's/\",//' |\
    sort |\
    awk '{print "--" $1}'
}
