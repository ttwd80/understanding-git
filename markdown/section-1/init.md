git init
===

This commmand accepts 5 options:


| No | Option | Description |
| -- | ------- | ----------- |
| 1 | --template <template-directory> | directory from which templates will be used |
| 2 | --bare | create a bare repository |
| 3 | --shared[=<permissions>] | specify that the git repository is to be shared amongst several users |
| 4 | -q, --quiet | be quiet |
| 5 | --separate-git-dir <gitdir> | separate git dir from working tree |



What is it for?
---
Using `git init` will allow you to manipulate the specified directory with `git`. 


Example 1 : No options, default values.
---
```
$ mkdir project1
$ cd project1
$ touch Makefile
$ git add Makefile
fatal: not a git repository (or any of the parent directories): .git
$ git status
fatal: not a git repository (or any of the parent directories): .git
$ git init
Initialized empty Git repository in /home/git/project1/.git/
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

Here we first create a directory called `project1`. This will be our new git repository. We make `project1` the current directory by running the `cd` command. Next we create an empty file called `Makefile`. 

Adding the file to git results in an error. Checking the git status also results in an error. The important bit is `not a git repository`. This tells us that you can run `add` and `status` only in a git repository.

The command `git init` makes it a git repository. Since we did not specify any directory or any options, it will process the current directory.

We can then run `git status` and `git add` and it will behave as expected.

