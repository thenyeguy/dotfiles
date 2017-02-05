# ------------------ #
# INITIALIZE ANTIGEN #
# ------------------ #

export ADOTDIR=~/.dotfiles/antigen-bundles
source ~/.dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle pip
antigen bundle pylint
antigen bundle vi-mode

antigen bundle zsh-users/zsh-completions src

antigen bundle ~/.dotfiles/antigen-bundles/completions
antigen theme ~/.dotfiles/antigen-bundles/themes agnoster-custom

antigen apply


# -------------------------- #
# CONFIGURE GENERAL SETTINGS #
# -------------------------- #

# Set default editor
export EDITOR="vim"

# Add scripts to the path
export PATH=~/.dotfiles/scripts:$PATH

# Only autocomplete my own user
zstyle ':completion:*' users root $USER

# Fix typos
alias sl='ls'
alias dc='cd'
alias mr='rm -i'
alias pc='cp -i'

# Make standard commands safer
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

# Shortcuts to common calls
alias help='man'
alias vimrc="vim ~/.dotfiles/vimrc"
alias zshrc="vim ~/.dotfiles/zshrc"
alias callgrind="valgrind --tool=callgrind --callgrind-out-file=callgrind.out"
alias gitroot='cd "./`git rev-parse --show-cdup`"'

# Bindings for intelligent history search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search
bindkey -a 'k' up-line-or-beginning-search
bindkey -a 'j' down-line-or-beginning-search
bindkey "^R" history-incremental-search-backward

# Reduce timing delay on escape
KEYTIMEOUT=1

# Disable virtualenv prompt overrides
export VIRTUAL_ENV_DISABLE_PROMPT=true

# Source fuzzy matcher if it exists
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi



# ------------------------------------------------------- #
# Fancy operation for advancing a list.                   #
#                                                         #
# The list is kept in a file, and destructively modified. #
# ------------------------------------------------------- #
function advance () {
    sed -i '1d' "$1"
    head "$1"
}

# ------------------------------------ #
# Make Ctrl-Z reopen suspended process #
# ------------------------------------ #
function fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z


# ---------------------------------------- #
# Create simpler wrapper around virtualenv #
# ---------------------------------------- #
function venv () {
    if [ -n "$VIRTUAL_ENV" ]; then
        echo "Deactivating virtualenv..."
        deactivate
    elif [ -e ./env/bin/activate ]; then
        echo "Activating virtualenv..."
        source ./env/bin/activate
    else
        echo "Creating new virtualenv..."
        virtualenv env
    fi
}


# ---------------------------- #
# Fix SSH auth socket for tmux #
# ---------------------------- #
if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;


# --------------------------- #
# SOURCE LOCAL CONFIGURATIONS #
# --------------------------- #
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi


# --------------------------- #
# Source better ls dir colors #
# --------------------------- #
if type dircolors > /dev/null; then
    eval `dircolors ~/.dotfiles/colors/solarized.dircolors`
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi


# ------------- #
# SET GREETING! #
# ------------- #

if type doge > /dev/null; then
    doge
elif type fortune > /dev/null && type cowsay > /dev/null; then
    fortune -a | cowsay -nf stegosaurus
else
    echo "Hello, Michael!"
fi
