# Initialize oh my zsh
ZSH=~/.dotfiles/oh-my-zsh
ZSH_CUSTOM=~/.dotfiles/oh-my-zsh-custom
ZSH_THEME="agnoster-custom"
plugins=(brew git history history-substring-search vi-mode)
source ~/.dotfiles/oh-my-zsh/oh-my-zsh.sh

# Workaround, this plugin doesn't seem to load...
source $ZSH/plugins/history-substring-search/history-substring-search.zsh


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

# Color stderr. Kind of buggy? Commented out
#exec 2>>( while read X; do print "\e[91m${X}\e[0m" > /dev/tty; done & )

# Shortcuts to common calls
alias smlnj='rlwrap sml'
alias matlab="/Applications/MATLAB.app/bin/matlab -nodesktop"

alias vimrc="vim ~/.dotfiles/vim/vimrc"
alias zshrc="vim ~/.dotfiles/zshrc"


# Add developer tools to path
export PATH=/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH
export PATH=/Applications/Android\ Studio.app/sdk/platform-tools:$PATH
export PATH=/Applications/androidndk:$PATH

# Add tex and homebrew directory to path 
export PATH=/usr/local/texlive/2010/bin/x86_64-darwin:$PATH
export PATH=/usr/local/lib:/usr/local/bin:/usr/local/Cellar:$PATH


# Stuff for Festival - set environment variables
export ESTDIR=/usr/local/festival/build/speech_tools
export FESTVOXDIR=/usr/local/festival/build/festvox
export FESTIVALDIR=/usr/local/festival/build/festival
export SPTKDIR=/usr/local/festival/build/SPTK


# Greeting
fortune -a | cowsay -nf stegosaurus


# OLD PROMPT
#autoload -U colors && colors
#PROMPT="%{$fg_bold[blue]%}[%n @ %m: %2~]: %b"
#RPROMPT="%{$fg_bold[yellow]%}[%T]%{$reset_color%}"
