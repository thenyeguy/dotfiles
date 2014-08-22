#
# SOURCE LOCAL CONFIGURATIONS
#
if [ -f ~/.zshrc-local ]; then
    source ~/.zshrc-local
fi


#
# INITIALIZE OH MY ZSH
#
# Set preferences
ZSH=~/.dotfiles/oh-my-zsh
ZSH_CUSTOM=~/.dotfiles/oh-my-zsh-custom
ZSH_THEME="agnoster-custom"

# Set plugins and load
plugins=(brew colored-man colorize git history history-substring-search vi-mode)
source ~/.dotfiles/oh-my-zsh/oh-my-zsh.sh

# Workaround, this plugin doesn't seem to load...
source $ZSH/plugins/history-substring-search/history-substring-search.zsh


#
# CONFIGURE COMMANDS
#
# Set default editor
export EDITOR="vim"

# Fix typos
alias sl='ls'
alias dc='cd'
alias mr='rm -i'
alias pc='cp -i'

# Make standard commands nicer
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'

# Shortcuts to common calls
alias help='man'
alias vimrc="vim ~/.vim/vimrc"
alias zshrc="vim ~/.zshrc"


#
# SET GREETING!
#
fortune -a | cowsay -nf stegosaurus
