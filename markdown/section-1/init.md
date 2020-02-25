git init
===

Offical documentation for [git-init](https://git-scm.com/docs/git-init/2.20.1).

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
- What would be a valid content? [Here](https://git-scm.com/docs/git-config/2.20.1#_variables) are some of the values that can be used.
- How about we give that a try with `blame.showEmail` ?

Example 2c:  --template \<template-directory>
---
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
- The proper format will works.

What if we use the proper format but with some made up content?

Example 2d:  --template \<template-directory>
---
```
$ mkdir ~/project
$ cd ~/project
$ git init .
Initialized empty Git repository in /home/git/project/.git/
$ git config magic.weapon
$ cat .git/config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
$ rm -rf .git
$ mkdir ~/base
$ echo "[magic]" > ~/base/config
$ echo "weapon = ring" >> ~/base/config
$ cat ~/base/config
[magic]
weapon = ring
$ git init --template ~/base
Initialized empty Git repository in /home/git/project/.git/
$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ git config magic.weapon
ring
$ cat .git/config
[magic]
weapon = ring
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
$ 
```
What does this tell us?
- You can configure any values as long as they are in the right format? 

- Can you overwrite existing ones?

Example 2e:  --template \<template-directory>
---
```
$ mkdir ~/project
$ cd ~/project
$ git init .
Initialized empty Git repository in /home/git/project/.git/
$ git config core.filemode
true
$ cat .git/config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
$ rm -rf .git
$ mkdir ~/base
$ echo "[core]" > ~/base/config
$ echo "filemode = false" >> ~/base/config
$ cat ~/base/config
[core]
filemode = false
$ git init --template ~/base
Initialized empty Git repository in /home/git/project/.git/
$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ git config core.filemode
true
$ cat .git/config
[core]
	filemode = true
	repositoryformatversion = 0
	bare = false
	logallrefupdates = true
$ 
```
What does this tell us?
- It looks like it is not possible to overwrite existing values.

- What if you add a little padding?

Example 2f:  --template \<template-directory>
---
```
$ mkdir ~/project
$ cd ~/project
$ git init .
Initialized empty Git repository in /home/git/project/.git/
$ git config core.filemode
true
$ cat .git/config
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
$ rm -rf .git
$ mkdir ~/base
$ echo "[core]" > ~/base/config
$ echo "\tfilemode = false" >> ~/base/config
$ cat ~/base/config
[core]
	filemode = false
$ git init --template ~/base
Initialized empty Git repository in /home/git/project/.git/
$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ git config core.filemode
true
$ cat .git/config
[core]
	filemode = true
	repositoryformatversion = 0
	bare = false
	logallrefupdates = true
$ 
```
What does this tell us?
- Even with padding, the default value cannot be changed using `--template`

Example 2g:  --template \<template-directory>
---
```
$ cd ~
$ rm -rf ~/base
$ mkdir ~/base
$ echo "ref: refs/heads/prime" > ~/base/HEAD
$ rm -rf ~/project
$ mkdir ~/project
$ cd ~/project
$ git init  --template ~/base
Reinitialized existing Git repository in /home/git/project/.git/
$ cat .git/HEAD
ref: refs/heads/prime
$ git status
On branch prime

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ rm -rf ~/project
$ mkdir ~/project
$ cd ~/project
$ git init
Initialized empty Git repository in /home/git/project/.git/
$ cat .git/HEAD
ref: refs/heads/master
$ git status
On branch master

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ 
```

What does this tell us?
- If you specify `HEAD` file, it will display `Reinitialized existing Git repository` instead of `Initialized empty Git repository`.

- What if `HEAD` was not in the correct format?

Example 2h:  --template \<template-directory>
---
```
$ cd ~
$ rm -rf ~/base
$ mkdir ~/base
$ echo "<br/>" > ~/base/HEAD
$ rm -rf ~/project
$ mkdir ~/project
$ cd ~/project
$ git init  --template ~/base
Reinitialized existing Git repository in /home/git/project/.git/
$ cat .git/HEAD
<br/>
$ git status
fatal: not a git repository (or any of the parent directories): .git
$ ls -a .git
.  ..  HEAD  config  objects  refs
$ 
```

What does this tell us?
- The directory structure will be created but it will not be a proper git repository.

- What you run `git init` on an existing git repository?

Example 2i:  --template \<template-directory>
---
```
$ cd ~
$ rm -rf ~/base
$ mkdir ~/base
$ echo "ref: refs/heads/prime" > ~/base/HEAD
$ echo hello > ~/base/hello.txt
$ echo "[blame]" > ~/base/config
$ echo "showEmail = true" >> ~/base/config
$ rm -rf ~/project
$ mkdir ~/project
$ cd ~/project
$ git init  --template ~/base
Reinitialized existing Git repository in /home/git/project/.git/
$ ls -a .git
.  ..  HEAD  config  hello.txt	objects  refs
$ cat .git/HEAD
ref: refs/heads/prime
$ cat .git/config
[blame]
showEmail = true
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
$ git status
On branch prime

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ git config blame.showEmail
true
$ git init .
Reinitialized existing Git repository in /home/git/project/.git/
$ ls -a .git
.   HEAD      config	   hello.txt  info     refs
..  branches  description  hooks      objects
$ cat .git/HEAD
ref: refs/heads/prime
$ cat .git/config
[blame]
showEmail = true
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
$ git status
On branch prime

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ git config blame.showEmail
true
$ echo "[blame]" > ~/base/config
$ echo "showEmail = false" >> ~/base/config
$ echo aloha > ~/base/aloha.txt
$ rm ~/base/hello.txt
$ git init  --template ~/base
Reinitialized existing Git repository in /home/git/project/.git/
$ ls -a .git
.   HEAD       branches  description  hooks  objects
..  aloha.txt  config	 hello.txt    info   refs
$ cat .git/HEAD
ref: refs/heads/prime
$ cat .git/config
[blame]
showEmail = true
[core]
	repositoryformatversion = 0
	filemode = true
	bare = false
	logallrefupdates = true
$ git status
On branch prime

No commits yet

nothing to commit (create/copy files and use "git add" to track)
$ git config blame.showEmail
true
$ 
```

What does this tell us?
- `git init --template` on an existing git repository
   - will copy over new files in the template directory.
   - will not overwrite/merge/delete any file that already exist.

Example 3:  --bare
---
```
$ cd ~
$ rm -rf ~/project
$ mkdir ~/project
$ cd ~/project
$ git init --bare
Initialized empty Git repository in /home/git/project/
$ git status
fatal: this operation must be run in a work tree
$ echo hello > hello.txt
$ git add hello.txt
fatal: this operation must be run in a work tree
$ 
```

What does this tell us?
- the bare repository behaves differently.

Example 3a:  --bare
---
```
$ cd ~
$ rm -rf ~/project ~/project1 ~/project2
$ mkdir  ~/project ~/project1 ~/project2
$ cd ~/project
$ git init --bare
Initialized empty Git repository in /home/git/project/
$ cd ~/project1
$ git init
Initialized empty Git repository in /home/git/project1/.git/
$ echo "hello" > hello.txt
$ git config user.name "John Doe"
$ git config user.email johndoe@example.com
$ git add hello.txt
$ git commit -m "first commit" -q
$ git remote add origin ~/project
$ git push -q --set-upstream origin master 
Branch 'master' set up to track remote branch 'master' from 'origin'.
$ ls hello.txt
hello.txt
$ cd ~/project2
$ ls hello.txt
ls: cannot access 'hello.txt': No such file or directory
$ git clone ~/project .
Cloning into '.'...
done.
$ ls hello.txt
hello.txt
$ cd ~/project1
$ echo new > new.txt
$ git add new.txt
$ git commit -m "adding new file" -q
$ git push -q
$ cd ~/project2
$ ls new.txt
ls: cannot access 'new.txt': No such file or directory
$ git pull -q
$ ls new.txt
new.txt
$ 
```

What does this tell us?
- We can push-to/clone-from/pull-from the bare repository.

Can we clone from .git?

Example 3b: --bare
---
```
$ cd ~
$ rm -rf ~/project
$ mkdir  ~/project
$ cd ~/project
$ mkdir ~/project/project1
$ cd ~/project/project1
$ git init
Initialized empty Git repository in /home/git/project/project1/.git/
$ git config user.name "John Doe"
$ git config user.email johndoe@example.com
$ echo "hello" > hello.txt
$ git add hello.txt
$ git commit -m "first commit" -q
$ cd ~/project
$ git clone ~/project/project1      project2
Cloning into 'project2'...
done.
$ ls -a project2
.  ..  .git  hello.txt
$ rm -rf project2
$ ls -a project2
ls: cannot access 'project2': No such file or directory
$ git clone ~/project/project1/.git project2
Cloning into 'project2'...
done.
$ ls -a project2
.  ..  .git  hello.txt
$ 
```

What does this tell us?
- We can push-to/clone-from/pull-from the non-bare repository too.

Example 4: --shared
---
```
$ cd ~
$ rm -rf ~/project
$ mkdir ~/project
$ umask 027
$ umask
0027
$ git init . 
Initialized empty Git repository in /home/git/.git/
$ stat .git | grep Gid
Access: (0750/drwxr-x---)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
$ rm -rf .git
$ git init --shared
Initialized empty shared Git repository in /home/git/.git/
$ stat .git | grep Gid
Access: (2770/drwxrws---)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
$ rm -rf .git
$ git init --shared=false
Initialized empty Git repository in /home/git/.git/
$ stat .git | grep Gid
Access: (0750/drwxr-x---)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
$ rm -rf .git
$ git init --shared=umask
Initialized empty Git repository in /home/git/.git/
$ stat .git | grep Gid
Access: (0750/drwxr-x---)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
$ rm -rf .git
$ git init --shared=group
Initialized empty shared Git repository in /home/git/.git/
$ stat .git | grep Gid
Access: (2770/drwxrws---)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
$ rm -rf .git
$ git init --shared=true
Initialized empty shared Git repository in /home/git/.git/
$ stat .git | grep Gid
Access: (2770/drwxrws---)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
$ rm -rf .git
$ git init --shared=all
Initialized empty shared Git repository in /home/git/.git/
$ stat .git | grep Gid
Access: (2775/drwxrwsr-x)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
$ rm -rf .git
$ git init --shared=world
Initialized empty shared Git repository in /home/git/.git/
$ stat .git | grep Gid
Access: (2775/drwxrwsr-x)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
$ rm -rf .git
$ git init --shared=everybody
Initialized empty shared Git repository in /home/git/.git/
$ stat .git | grep Gid
Access: (2775/drwxrwsr-x)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
$ rm -rf .git
$ git init --shared=0606
Initialized empty shared Git repository in /home/git/.git/
$ stat .git | grep Gid
Access: (2707/drwx--Srwx)  Uid: ( 1000/     git)   Gid: ( 1000/     git)
$ 
```

What does this tell us?
- If `--shared` is ommitted, it is the same as `--shared=umask` or `--shared=false`. It is not shared and the `.git` direcrory would be created as the `umask` value.
- If `--shared` is specified, but no value is given, it is the same as `--shared=group` or `--shared=true`. Users from the same group have access to the `.git` directory.
- If `--shared=all` or `--shared=world` or `--shared=everybody`, it is the same as  `--shared=group` + readable by others.
- If `--shared=0xxx`, the repository will be created with the octal permission. The option `--shared=0606` will create a `.git` direcrory with the permission `drwx--Srwx`.

Example 5: -q
---
```
$ cd ~
$ rm -rf ~/base 
$ mkdir ~/base
$ rm -rf ~/project
$ mkdir ~/project
$ cd ~/project
$ git init
Initialized empty Git repository in /home/git/project/.git/
$ rm -rf .git
$ git init -q
$ rm -rf .git
$ git init --bare
Initialized empty Git repository in /home/git/project/
$ cd ~
$ rm -rf ~/project
$ mkdir ~/project
$ cd ~/project
$ git init --bare -q
$ cd ~
$ rm -rf ~/project
$ mkdir ~/project
$ cd ~/project
$ git init --template ~/base
Initialized empty Git repository in /home/git/project/.git/
$ rm -rf .git
$ git init --template ~/base -q
$ rm -rf .git
$ git init --shared=all
Initialized empty shared Git repository in /home/git/project/.git/
$ rm -rf .git
$ git init --shared=all -q
$ rm -rf .git
$ git init --separate-git-dir=something
Initialized empty Git repository in /home/git/project/something/
$ rm -rf .git
$ git init --separate-git-dir=something -q
$ rm -rf .git
$ 
```

What does this tell us?
- Adding `-q` makes it less verbose.



