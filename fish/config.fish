# -------------------------- #
# Configure general settings #
# -------------------------- #

set -x EDITOR "vim"

# Update path
add_to_path ~/.dotfiles/bin ~/.dotfiles/git ~/.dotfiles/fzf/bin 

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


# ---------- #
# Source fzf #
# ---------- #
source ~/.dotfiles/fzf/shell/key-bindings.fish
set -g FZF_TMUX 1


# --------------------------- #
# Source better ls dir colors #
# --------------------------- #
if type dircolors > /dev/null ^/dev/null
    eval (dircolors -c ~/.dotfiles/colors/solarized.dircolors)
end


# --------------------------- #
# Source local configurations #
# --------------------------- #
if test -e "$local_fish_config_file"
    source $local_fish_config_file
end
