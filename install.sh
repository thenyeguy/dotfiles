#!/bin/sh

# Enter our directory and initialize our submodules
cd ~/.dotfiles
git submodule update --init --recursive


# Create our hardlinks
echo "Creating hardlinks in home directory..."
ln -s ~/.dotfiles/gitconfig ~/.gitconfig
ln -s ~/.dotfiles/gvimrc    ~/.gvimrc
ln -s ~/.dotfiles/vim       ~/.vim
ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
ln -s ~/.dotfiles/zshrc     ~/.zshrc
