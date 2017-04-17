Michael Nye's Dotfiles
======================

This is a repository for my unix configuration - primarily my vim and fish
configs. It includes an install script, which when run will initialize a
checkout of the repository, and create symlinks in the home directory.

To install, perform the following:

    wget https://raw.githubusercontent.com/thenyeguy/dotfiles/master/install.sh && /bin/bash install.sh checkout

Both the install script and my configuration assume this repository is checked
out into `~/.dotfiles`.

The existing configuration files will be moved into `~/dotfiles.bak` before
installation takes place.
