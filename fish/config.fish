# -------------------------- #
# Configure general settings #
# -------------------------- #

set -x EDITOR "nvim"

set -x FZF_TMUX 1
set -x FZF_TMUX_OPTS "-p"

# Update path
fish_add_path --move /opt/homebrew/bin ~/.cargo/bin
fish_add_path --move ~/.dotfiles/bin ~/.dotfiles/git ~/.dotfiles/fzf/bin

# Fix typos
abbr --global --add sl 'ls'
abbr --global --add dc 'cd'
abbr --global --add mr 'rm'
abbr --global --add pc 'cp'

# Make standard commands safer
alias cp 'cp -i'
alias rm 'rm -i'
alias mv 'mv -i'

# Shortcuts to common calls
abbr --global --add rmorig 'find . -name "*.orig" -delete'
alias callgrind "valgrind --tool=callgrind --callgrind-out-file=callgrind.out"
alias gitroot 'cd "./`git rev-parse --show-cdup`"'

#
if test "$TERM" = "xterm-kitty"
    alias icat="kitty +kitten icat"
end


# ------------------------ #
# Source additional config #
# ------------------------ #
source ~/.dotfiles/fzf/shell/key-bindings.fish

if test -e "$local_fish_config_file"
    source $local_fish_config_file
end
