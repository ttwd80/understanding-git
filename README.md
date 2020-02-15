# understanding-git

Decisions
- git under python
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
