git am
===

This commmand accepts 32 options:


| No | Option | Description |
| -- | ------- | ----------- |
| 1 | -i, --interactive | run interactively |
| 2 | -3, --3way | allow fall back on 3way merging if needed |
| 3 | -q, --quiet | be quiet |
| 4 | -s, --signoff | add a Signed-off-by line to the commit message |
| 5 | -u, --utf8 | recode into utf8 (default) |
| 6 | -k, --keep | pass -k flag to git-mailinfo |
| 7 | --keep-non-patch | pass -b flag to git-mailinfo |
| 8 | -m, --message-id | pass -m flag to git-mailinfo |
| 9 | --keep-cr | pass --keep-cr flag to git-mailsplit for mbox format |
| 10 | --no-keep-cr | do not pass --keep-cr flag to git-mailsplit independent of am.keepcr |
| 11 | -c, --scissors | strip everything before a scissors line |
| 12 | --whitespace \<action> | pass it through git-apply |
| 13 | --ignore-space-change | pass it through git-apply |
| 14 | --ignore-whitespace | pass it through git-apply |
| 15 | --directory \<root> | pass it through git-apply |
| 16 | --exclude \<path> | pass it through git-apply |
| 17 | --include \<path> | pass it through git-apply |
| 18 | -C \<n> | pass it through git-apply |
| 19 | -p \<num> | pass it through git-apply |
| 20 | --patch-format \<format> | format the patch(es) are in |
| 21 | --reject | pass it through git-apply |
| 22 | --resolvemsg ... | override error message when patch failure occurs |
| 23 | --continue | continue applying patches after resolving a conflict |
| 24 | -r, --resolved | synonyms for --continue |
| 25 | --skip | skip the current patch |
| 26 | --abort | restore the original branch and abort the patching operation. |
| 27 | --quit | abort the patching operation but keep HEAD where it is. |
| 28 | --show-current-patch | show the patch being applied. |
| 29 | --committer-date-is-author-date | lie about committer date |
| 30 | --ignore-date | use current timestamp for author date |
| 31 | --rerere-autoupdate | update the index with reused conflict resolution if possible |
| 32 | -S, --gpg-sign[=\<key-id>] | GPG-sign commits |




