#
# REDIRECT TO FISH IF PRESENT
#
FISH=`which fish`
if echo $- | grep -q 'i' && [[ -x $FISH ]] && [[ $SHELL != $FISH ]]; then
  # Safeguard to only activate fish for interactive shells and only if fish
  # shell is present and executable. Verify that this is a new session by
  # checking if $SHELL is set to the path to fish. If it is not, we set $SHELL
  # and start fish.
  #
  # If this is not a new session, the user probably typed 'bash' into their
  # console and wants bash, so we skip this.
  exec env SHELL=$FISH $FISH -i
fi


#
# CONFIGURE BASH OTHERWISE
#
# History control
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Create ls shortcuts
alias ll='ls -l'
alias la='ls -al'

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dotfiles/colors/solarized.dircolors && \
      eval "$(dircolors -b ~/.dotfiles/colors/solarized.dircolors)" || \
      eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add bin to the path
export PATH=~/.dotfiles/bin:~/.dotfiles/fzf/bin:$PATH

# Export a simple prompt
export PROMPT_DIRTRIM=4
export PS1="\n\e[91;40m bash \e[30;104m \@ \e[94;44m\e[30;44m \w \e[34;49m\e[m \n › "
