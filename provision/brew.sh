#!/bin/bash

# Install homebrew.
if ! which brew > /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install default packages.
brew bundle --no-lock --file ~/.dotfiles/provision/Brewfile
