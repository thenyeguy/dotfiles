#!/bin/bash

# Check out the repository
if [[ $@ == **checkout** ]]
then
    echo "Checkout out git repository"
    git clone https://github.com/thenyeguy/dotfiles.git $HOME/.dotfiles
fi

# Define files to hardlink
dotfiles=(bashrc gitconfig hgrc vim vimrc)

# Backup old links
echo "Backing up old data to dotfiles.bak..."
mkdir $HOME/dotfiles.bak
for dotfile in ${dotfiles[*]}
do
    mv $HOME/.$dotfile $HOME/dotfiles.bak/$dotfile
done
mv $HOME/.config/fish $HOME/dotfiles.bak/fish
mv $HOME/.tmux.conf $HOME/dotfiles.bak/tmux.conf
echo " "

# Create our hardlinks
echo "Creating hardlinks in home directory..."
for dotfile in ${dotfiles[*]}
do
    ln -s $HOME/.dotfiles/$dotfile $HOME/.$dotfile
done
mkdir -p $HOME/.config
ln -s $HOME/.dotfiles/tmux/tmux.conf $HOME/.tmux.conf
ln -s $HOME/.dotfiles/fish $HOME/.config/fish
echo " "

# Create vim subdirectories
mkdir -p $HOME/.vim/swp
mkdir -p $HOME/.vim/undo

echo "Install complete!"
