# -------------------------- #
# Configure general settings #
# -------------------------- #

set -x EDITOR "vim"

# Update path
add_to_path ~/.dotfiles/fzf/bin ~/.dotfiles/git ~/.dotfiles/scripts

# Fix typos
abbr -a sl 'ls'
abbr -a dc 'cd'
abbr -a mr 'rm'
abbr -a pc 'cp'

# Make standard commands safer
alias cp 'cp -i'
alias rm 'rm -i'
alias mv 'mv -i'

# Shortcuts to common calls
abbr rmorig 'find . -name "*.orig" -delete'
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
