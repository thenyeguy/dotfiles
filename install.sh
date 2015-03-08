#!/bin/bash

# Check out the repository
if [[ $@ == **checkout** ]]
then
    echo "Checkout out git repository"
    git clone https://github.com/thenyeguy/dotfiles.git $HOME/.dotfiles
fi

# Enter our directory and initialize our submodules
echo "Initializing git repos..."
pushd $HOME/.dotfiles
git submodule update --init --recursive
echo " "

# Define files to hardlink
dotfiles=(bashrc gitconfig gvimrc tmux.conf vim vimrc zshrc)

# Backup old links
echo "Backing up old data to dotfiles.bak..."
mkdir $HOME/dotfiles.bak
for dotfile in ${dotfiles[*]}
do
    mv $HOME/.$dotfile $HOME/dotfiles.bak/$dotfile
done
echo " "


# Create our hardlinks
echo "Creating hardlinks in home directory..."
for dotfile in ${dotfiles[*]}
do
    ln -s $HOME/.dotfiles/$dotfile $HOME/.$dotfile
done
echo " "

echo "Install complete!"
