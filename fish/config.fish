# -------------------------- #
# CONFIGURE GENERAL SETTINGS #
# -------------------------- #

set -x EDITOR "vim"
set -x PATH ~/.dotfiles/scripts $PATH

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


# --------------------------- #
# Source better ls dir colors #
# --------------------------- #
if type dircolors > /dev/null ^/dev/null
    eval (dircolors -c ~/.dotfiles/colors/solarized.dircolors)
end


# --------------------------- #
# SOURCE LOCAL CONFIGURATIONS #
# --------------------------- #
if test -e "$local_fish_config_file"
    source $local_fish_config_file
end
