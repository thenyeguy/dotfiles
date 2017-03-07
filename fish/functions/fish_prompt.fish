# My custom theme, based on the wonderful zsh theme:
#   agnoster's Theme - https://gist.github.com/3712874
#
# This uses some glyphs that may be specific to Source Code Pro.

set segment_seperator 
set active_jobs_symbol ☼
set bad_exit_symbol ‼
set root_symbol 

set vcs_symbol 
set __fish_git_prompt_describe_style "branch"
set __fish_git_prompt_showdirtystate "true"
set __fish_git_prompt_char_dirtystate ○
set __fish_git_prompt_char_stagedstate ◉


### Draws a new segment
# Usage: new_segment <background> <foreground> [contents]
# Consecutive calls with the same background will merge segments together.
function new_segment
    set background $argv[1]
    set foreground $argv[2]

    if test \( "$background" != "$__prompt_current_background" \) \
            -a \( -n $__prompt_current_background \)
        printf " "
        set_color -b $background $__prompt_current_background
        printf "$segment_seperator"
    end
    set -g __prompt_current_background $background

    set_color -b $background $foreground
    if test (count $argv) -gt 2
        printf " $argv[3..-1]"
    end
end

# Status:
# - are there background jobs?
# - was there an error (that wasn't suspend)
# - am I root
function prompt_status
    set njobs (jobs -l | wc -l | sed 's/ //g')
    if test $njobs -gt 0
        new_segment black cyan $active_jobs_symbol
    end
    if test $__prompt_last_status -ne 0
        new_segment black red $bad_exit_symbol
    end
    if test (id -u) -eq 0
        new_segment black normal $root_symbol
    end
end

function prompt_git
    if git rev-parse --is-inside-work-tree >/dev/null ^/dev/null
        if test -z "(git status --porcelain)"
            new_segment green black
        else
            new_segment yellow black
        end
        printf (__fish_git_prompt "$vcs_symbol %s" | sed -e 's/[ ]*$//')
    end
end

function fish_prompt
    set -g __prompt_current_background ""
    set -g __prompt_last_status "$status"

    printf "\n"
    new_segment cyan black (date "+%l:%M%p" | sed 's/^ //')
    prompt_status
    new_segment black normal $USER@(hostname -s)
    new_segment blue black (prompt_pwd)
    prompt_git
    new_segment normal normal "\n >> "
end
