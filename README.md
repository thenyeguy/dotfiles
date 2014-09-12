Michael Nye's Dotfiles
======================

This is a repository for my unix configuration - primarily my vim config and
oh-my-zsh. It includes oh-my-zsh and vim/vundle as submodules. It also includes
an install script, which when run will initialize a bare checkout of the
repository, and set hardlinks to my config files in the root directory.

Both the install script and my configuration assume this repository is checked
out into `~/.dotfiles`. To install, perform the following:

    cd
    git clone http://github.com/thenyeguy/dotfiles.git .dotfiles
    .dotfiles/install.sh

The existing configuration files will be moved into `~/dotfiles.bak` before
installation takes place.


Local configurations
--------------------

My zshrc and bashrc will automatically source the files ~/.zshrc.local and
~/.bashrc.local when they load. This allows configurations that are specific to
the local machine without modifying the primary config files.
