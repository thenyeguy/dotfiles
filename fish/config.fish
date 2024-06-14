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

# Customize ripgrep flags
alias rg "rg --smart-case"

# Shortcuts to common calls
abbr --add rmorig --position command --set-cursor=% 'find % -name "*.orig" -delete'
alias callgrind "valgrind --tool=callgrind --callgrind-out-file=callgrind.out"
alias gitroot 'cd "./`git rev-parse --show-cdup`"'

# FZF colors
set -x FZF_DEFAULT_OPTS "--color=bg+:#3B4252,bg:#2E3440,spinner:#81A1C1,hl:#81A1C1,fg:#D8DEE9,header:#616E88,info:#5E81AC,pointer:#EBCB8B,marker:#81A1C1,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1"


# ------------------------ #
# Source additional config #
# ------------------------ #
source ~/.dotfiles/fzf/shell/key-bindings.fish
maybe_source $local_fish_config_file
maybe_source ~/.opam/opam-init/init.fish
