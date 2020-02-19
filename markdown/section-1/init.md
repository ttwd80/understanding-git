git init
===

Offical documentation for [git-init](https://git-scm.com/docs/git-init/2.20.1).

This commmand accepts 5 options:


| No | Option | Description |
| -- | ------- | ----------- |
| 1 | --template \<template-directory> | directory from which templates will be used |
| 2 | --bare | create a bare repository |
| 3 | --shared[=\<permissions>] | specify that the git repository is to be shared amongst several users |
| 4 | -q, --quiet | be quiet |
| 5 | --separate-git-dir \<gitdir> | separate git dir from working tree |



What is it for?
---
Using `git init` will allow you to manipulate the specified directory with `git`. 


Example 1: No options, default values.
---
```
$ mkdir project
$ cd project
$ touch Makefile
$ git add Makefile
fatal: not a git repository (or any of the parent directories): .git
$ git status
fatal: not a git repository (or any of the parent directories): .git
$ git init
Initialized empty Git repository in /home/git/project/.git/
$ git status
On branch master

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	Makefile

nothing added to commit but untracked files present (use "git add" to track)
$ git add Makefile
$ git status
On branch master

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)

	new file:   Makefile

$ 
```

Here we first create a directory called `project`. This will be our new git repository. We make `project` the current directory by running the `cd` command. Next we create an empty file called `Makefile`. 

Adding the file to git results in an error. Checking the git status also results in an error. The important bit is `not a git repository`. This tells us that you can run `add` and `status` only in a git repository.

The command `git init` makes it a git repository. Since we did not specify any directory or any options, it will process the current directory.

We can then run `git status` and `git add` and it will behave as expected.

Example 2: --template \<template-directory>
---
```
$ ls -RF1 /usr/share/git-core/templates
/usr/share/git-core/templates:
branches/
description
hooks/
info/

/usr/share/git-core/templates/branches:

/usr/share/git-core/templates/hooks:
applypatch-msg.sample*
commit-msg.sample*
fsmonitor-watchman.sample*
post-update.sample*
pre-applypatch.sample*
pre-commit.sample*
pre-push.sample*
pre-rebase.sample*
pre-receive.sample*
prepare-commit-msg.sample*
update.sample*

/usr/share/git-core/templates/info:
exclude
$ mkdir ~/project
$ cd ~/project
$ git init
Initialized empty Git repository in /home/git/project/.git/
$ ls -RF1 .git
.git:
HEAD
branches/
config
description
hooks/
info/
objects/
refs/

.git/branches:

.git/hooks:
applypatch-msg.sample*
commit-msg.sample*
fsmonitor-watchman.sample*
post-update.sample*
pre-applypatch.sample*
pre-commit.sample*
pre-push.sample*
pre-rebase.sample*
pre-receive.sample*
prepare-commit-msg.sample*
update.sample*

.git/info:
exclude

.git/objects:
info/
pack/

.git/objects/info:

.git/objects/pack:

.git/refs:
heads/
tags/

.git/refs/heads:

.git/refs/tags:
$ rm -rf .git
$ mkdir ~/base
$ git init --template ~/base
Initialized empty Git repository in /home/git/project/.git/
$ ls -RF1 .git
.git:
HEAD
config
objects/
refs/

.git/objects:
info/
pack/

.git/objects/info:

.git/objects/pack:

.git/refs:
heads/
tags/

.git/refs/heads:

.git/refs/tags:
$ 
```

What does this tell us?

- `git init` without the `--template` option will use `/usr/share/git-core/templates` as the template directory.
- `git init` with the `--template` option on an empty template directory would still create:
  - HEAD file
  - config file
  - objects directory
  - refs directory

What if the template directory is not empty?

Example 2a:  --template \<template-directory>
---
```
$ mkdir ~/project
$ cd ~/project
$ mkdir ~/base
$ echo "<html>" > ~/base/content.txt
$ git init --template ~/base
Initialized empty Git repository in /home/git/project/.git/
$ ls -RF1 .git
.git:
HEAD
config
content.txt
objects/
refs/

.git/objects:
info/
pack/

.git/objects/info:

.git/objects/pack:

.git/refs:
heads/
tags/

.git/refs/heads:

.git/refs/tags:
$ 
```
What does this tell us?

- If a files does not conflict with the git structure, it will be copied over.

What if the template directory contains a file called `config` with garbage content?

Example 2b:  --template \<template-directory>
---
```
$ mkdir ~/project
$ cd ~/project
$ git init .
Initialized empty Git repository in /home/git/project/.git/
$ cat .git/config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
$ rm -rf .git
$ mkdir ~/base
$ echo "something" > ~/base/content.txt
$ echo "<html>" > ~/base/config
$ ls -a
.  ..
$ git init --template ~/base
fatal: bad config line 1 in file /home/git/base/config
$ git status
fatal: not a git repository (or any of the parent directories): .git
$ ls -a
.  ..  .git
$ ls -RF1 .git
.git:
$ cat .git/config
cat: .git/config: No such file or directory
$ 
```
What does this tell us?

- If it the template directory contains a file called `config`, it has to be in the right format.
- The `.git` directory will still be created but it will not be a valid repository.
- What would be a valid content? [Here](https://git-scm.com/docs/git-config/2.20.1#_variables) are some of the values that can be used.
- How about we give that a try with `blame.showEmail` ?

Example 2c:  --template \<template-directory>
```
$ mkdir ~/project
$ cd ~/project
$ git init .
Initialized empty Git repository in /home/git/project/.git/
$ git config blame.showEmail 
$ cat .git/config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
$ rm -rf .git
$ mkdir ~/base
$ echo "[blame]" > ~/base/config
$ echo "showEmail = true" >> ~/base/config
$ cat ~/base/config
[blame]
showEmail = true
$ git init --template ~/base
Initialized empty Git repository in /home/git/project/.git/
$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ git config blame.showEmail 
true
$ cat .git/config
[blame]
showEmail = true
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
$ 
```
What does this tell us?



