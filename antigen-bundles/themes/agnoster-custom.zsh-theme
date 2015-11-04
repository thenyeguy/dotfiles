# vim:ft=zsh
#
# My custom theme, based off the wonderful:
#   agnoster's Theme - https://gist.github.com/3712874
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
#

CURRENT_BG='NONE'

if [[ -n $ZSH_NO_SYMBOLS ]]; then
    SEGMENT_SEPARATOR=''

    ACTIVE_JOBS_SYM='*'
    BAD_EXIT_SYM='x'
    ROOT_SYM='su'

    VCS_SYM=''
    VCS_DETATCHED_SYM=''
    VCS_UNSTAGED_SYM='*'
    VCS_STAGED_SYM='+'
else
    SEGMENT_SEPARATOR=''

    ACTIVE_JOBS_SYM=' '
    BAD_EXIT_SYM=''
    ROOT_SYM=''

    VCS_SYM=''
    VCS_DETATCHED_SYM=''
    VCS_UNSTAGED_SYM=''
    VCS_STAGED_SYM=' '
fi


### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
    local bg fg
    [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
    [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
    if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
        echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
    else
        echo -n "%{$bg%}%{$fg%} "
    fi
    CURRENT_BG=$1
    [[ -n $3 ]] && echo -n $3
}

# Begin our prompt with whitespcae for easier reading
prompt_start() {
    echo -n "\n"
}

# End the prompt, closing any open segments
prompt_end() {
    if [[ -n $CURRENT_BG ]]; then
        echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
    else
        echo -n "%{%k%}"
    fi
    echo -n "%{%f%}"
    echo -n "\n"
    CURRENT_BG=''
}


### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
    local user=`whoami`

    if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
        prompt_segment black default "%(!.%{%F{yellow}%}.)$user@%m"
    fi
}

# Git: branch/detached head, dirty status
prompt_git() {
    local ref dirty
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        dirty=$(parse_git_dirty)
        ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="$VCS_DETATCHED_SYM $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
        if [[ -n $dirty ]]; then
            prompt_segment yellow black
        else
            prompt_segment green black
        fi

        setopt promptsubst
        autoload -Uz vcs_info

        zstyle ':vcs_info:*' enable git
        zstyle ':vcs_info:*' get-revision true
        zstyle ':vcs_info:*' check-for-changes true
        zstyle ':vcs_info:*' unstagedstr $VCS_UNSTAGED_SYM
        zstyle ':vcs_info:*' stagedstr $VCS_STAGED_SYM
        zstyle ':vcs_info:*' formats '%b %u%c'
        zstyle ':vcs_info:*' actionformats '%b (%a) %u%c'
        vcs_info
        echo -n "${VCS_SYM} ${vcs_info_msg_0_}"
    fi
}

# Dir: current working directory
prompt_dir() {
    prompt_segment blue black '%4~'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
    local virtualenv_path="$VIRTUAL_ENV"
    if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
        prompt_segment black default "(`basename $virtualenv_path`)"
    fi
}

# Status:
# - are there background jobs?
# - was there an error (that wasn't suspend)
# - am I root
prompt_status() {
    local symbols
    symbols=()
    [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}$ACTIVE_JOBS_SYM"
    [[ $RETVAL -ne 0 && $RETVAL -ne 20 ]] && symbols+="%{%F{red}%}$BAD_EXIT_SYM"
    [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}$ROOT_SYM"

    [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

# The current time
prompt_time() {
    prompt_segment cyan black `date "+%l:%M%p"`
}

# On its own line, under the main prompt. Displays the current mode.
prompt_indicator() {
    if [[ $KEYMAP == "vicmd" ]]; then
        echo " %{$fg_bold[red]%}%{$fg[red]%}<<%{$reset_color%}"
    else
        echo " >>"
    fi
}

## Main prompt
build_prompt() {
    RETVAL=$?
    prompt_start
    prompt_time
    prompt_status
    prompt_context
    prompt_virtualenv
    prompt_dir
    prompt_git
    prompt_end
    prompt_indicator
}

MODE_INDICATOR="%{$fg_bold[red]%}%{$fg[red]%}>>%{$reset_color%}"
PROMPT='%{%f%b%k%}$(build_prompt) '
