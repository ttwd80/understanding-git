git add
===

Offical documentation for [git-add](https://git-scm.com/docs/git-add/2.20.1).

This commmand accepts 15 options:


| No | Option | Description |
| -- | ------- | ----------- |
| 1 | -n, --dry-run | dry run |
| 2 | -v, --verbose | be verbose |
| 3 | -i, --interactive | interactive picking |
| 4 | -p, --patch | select hunks interactively |
| 5 | -e, --edit | edit current diff and apply |
| 6 | -f, --force | allow adding otherwise ignored files |
| 7 | -u, --update | update tracked files |
| 8 | --renormalize | renormalize EOL of tracked files (implies -u) |
| 9 | -N, --intent-to-add | record only the fact that the path will be added later |
| 10 | -A, --all | add changes from all tracked and untracked files |
| 11 | --ignore-removal | ignore paths removed in the working tree (same as --no-all) |
| 12 | --refresh | don't add, only refresh the index |
| 13 | --ignore-errors | just skip files which cannot be added because of errors |
| 14 | --ignore-missing | check if - even missing - files are ignored in dry run |
| 15 | --chmod (+\|-)x | override the executable bit of the listed files |



What is it for?
---
Using `git add` will allow you to add files to the repository.


Example 1: No options, default values.
---
```
$ rm -rf ~/project
$ mkdir ~/project
$ cd ~/project
$ git config --global user.name "Mona Lisa"
$ git config --global user.email "email@example.com"
$ git init
Initialized empty Git repository in /home/git/project/.git/
$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ echo "a" > a.txt
$ echo "b" > b.txt
$ echo "c" > c.txt
$ ls -1
a.txt
b.txt
c.txt
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	a.txt
	b.txt
	c.txt

nothing added to commit but untracked files present (use "git add" to track)
$ git add a.txt
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

	new file:   a.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	b.txt
	c.txt

$ git commit -m "first commit"
[master (root-commit) 4dc1c74] first commit
 1 file changed, 1 insertion(+)
 create mode 100644 a.txt
$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	b.txt
	c.txt

nothing added to commit but untracked files present (use "git add" to track)
$ git add b.txt c.txt
$ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   b.txt
	new file:   c.txt

$ git commit -m "another commit"
[master b8b4d3b] another commit
 2 files changed, 2 insertions(+)
 create mode 100644 b.txt
 create mode 100644 c.txt
$ git status
On branch master
nothing to commit, working tree clean
$ ls -1
a.txt
b.txt
c.txt
$ 
```

