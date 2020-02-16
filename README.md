# understanding-git

Decisions
===

Decision to use git that is in the python Docker image 
===

From the list of [all official packages in docker hub](https://hub.docker.com/search?q=&type=image&image_filter=official) only 3 came with git pre-installed.
  - node - `git version 2.11.0`
  - golang - `git version 2.20.1`
  - python - `git version 2.20.1`
As both golang and python are both popular projects and have the same high git version number, Python came out as the one that I picked because I am using pexpect. This may change in the future.

Between these 2 versions of git, `2.20.1` had the advantage of dividing the git commands into sections. This can be seen when `git help -a` is executed:
  - Main Porcelain Commands
  - Ancillary Commands / Manipulators
  - Ancillary Commands / Interrogators
  - Interacting with Others
  - Low-level Commands / Manipulators
  - Low-level Commands / Interrogators
  - Low-level Commands / Synching Repositories
  - Low-level Commands / Internal Helpers

Decision to use `pexpect`
===
I took a look at `pexpect` and Netflix's `github.com/Netflix/go-expect`. I wanted a tool that would display the raw prompt as well as any input and output. Something like this:
```
$ ls -a
.	..
$ 
```
I can get this with `pexpect` but not `github.com/Netflix/go-expect`.

Decision to use `/bin/sh`
===
I want the runs to produce the same output for the same git version. Using `/bin/bash`, I would get this:
```
root@58a765450cdc:/# 
```
and 
```
root@448082c91936:/#
```
The Bourne shell, `/bin/sh` consistently gives me:
```
# 
```

Decision not to use `virtualenv`
===
I want the packages in the `Python` environment to be isolated from what ever has been installed on the current machine. The [package](https://virtualenv.pypa.io/en/stable/) `virtualenv` solves this. However, I do not want to have to run `source bin/activate` to activate the environment.

Instead of directly using `virtualenv`, I decided to use `pipenv` (which use `virtualenv` internally). There is no need to activate the environment, but I do need to add use `pipenv run python` instead of just using `python`.
