# ------------------ #
# INITIALIZE ANTIGEN #
# ------------------ #

export ADOTDIR=~/.dotfiles/antigen-bundles
source ~/.dotfiles/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle brew
antigen bundle brew-cask
antigen bundle debian
unalias ag
antigen bundle git
antigen bundle colored-man
antigen bundle pip
antigen bundle pylint
antigen bundle vi-mode

antigen theme ~/.dotfiles/antigen-bundles/themes agnoster-custom

antigen apply


# ------------------ #
# CONFIGURE COMMANDS #
# ------------------ #

# Set default editor
export EDITOR="vim"

# Add scripts to the path
export PATH=~/.dotfiles/scripts:$PATH

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


# ------------------------------------ #
# Make Ctrl-Z reopen suspended process #
# ------------------------------------ #
fancy-ctrl-z () {
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
