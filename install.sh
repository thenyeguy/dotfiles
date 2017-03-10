#!/bin/bash

# Check out the repository
if [[ $@ == **checkout** ]]
then
    echo "Checkout out git repository"
    git clone https://github.com/thenyeguy/dotfiles.git $HOME/.dotfiles
fi

# Enter our directory and initialize our submodules
echo "Initializing git repos..."
pushd $HOME/.dotfiles > /dev/null
git submodule update --init --recursive
echo " "

# Define files to hardlink
dotfiles=(bashrc gitconfig tmux.conf vim vimrc)

# Backup old links
echo "Backing up old data to dotfiles.bak..."
mkdir $HOME/dotfiles.bak
for dotfile in ${dotfiles[*]}
do
    mv $HOME/.$dotfile $HOME/dotfiles.bak/$dotfile
done
mv $HOME/.config/fish $HOME/dotfiles.bak/fish
echo " "


# Create our hardlinks
echo "Creating hardlinks in home directory..."
for dotfile in ${dotfiles[*]}
do
    ln -s $HOME/.dotfiles/$dotfile $HOME/.$dotfile
done
ln -s $HOME/.dotfiles/fish $HOME/.config/fish
echo " "


# Create vim subdirectories
mkdir -p $HOME/.vim/swp
mkdir -p $HOME/.vim/undo

echo "Install complete!"
