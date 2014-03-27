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
alias sml='rlwrap sml'
alias matlab="/Applications/MATLAB.app/bin/matlab -nodesktop"

alias vimrc="vim ~/.vim/vimrc"
alias zshrc="vim ~/.zshrc"


#
# CONFIGURE PATH
#
# Add developer tools to path
export PATH=/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH
export PATH=/Applications/Android\ Studio.app/sdk/platform-tools:$PATH
export PATH=/Applications/androidndk:$PATH

# Add tex and homebrew directory to path 
# Homebrew is last to ensure its packages come first
export PATH=/usr/local/texlive/2010/bin/x86_64-darwin:$PATH
export PATH=/usr/local/lib:/usr/local/bin:/usr/local/Cellar:$PATH

# Stuff for Festival - set environment variables
export ESTDIR=/usr/local/festival/build/speech_tools
export FESTVOXDIR=/usr/local/festival/build/festvox
export FESTIVALDIR=/usr/local/festival/build/festival
export SPTKDIR=/usr/local/festival/build/SPTK


#
# SET GREETING!
#
fortune -a | cowsay -nf stegosaurus
