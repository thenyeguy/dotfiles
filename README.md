Michael Nye's Dotfiles
======================

This is a repository for my unix configuration - primarily my vim config and
oh-my-zsh. It includes oh-my-zsh and vim/vundle as submodules. It also includes
an install script, which when run will initialize a bare checkout of the
repository, and set hardlinks to my config files in the root directory.

Both the install script and my configuration assume this repository is checked
out into `~/.dotfiles`. To install, perform the following:

    cd
    git clone git@github.com:thenyeguy/dotfiles.git .dotfiles
    .dotfiles/install.sh
