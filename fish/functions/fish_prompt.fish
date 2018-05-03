# My custom theme, based on this wonderful zsh theme:
#   agnoster's Theme - https://gist.github.com/3712874
#
# This uses some glyphs that may be specific to Source Code Pro.

# Configure prompt
set __prompt_segment_seperator 
set __prompt_active_jobs_symbol ☼
set __prompt_bad_exit_symbol ‼
set __prompt_git_symbol 
set __prompt_hg_symbol ☿

# Configure fish git prompt
set __fish_git_prompt_describe_style branch
set __fish_git_prompt_showdirtystate true
set __fish_git_prompt_char_dirtystate ○
set __fish_git_prompt_char_stagedstate ◉

### Starts a new, empty line.
# This will clear the entire line of any existing contents.
function __prompt_new_line
    printf "\n\033[K"
end

### Draws a prompt segment
# Usage: segment <background> <foreground> [contents]
# Consecutive calls with the same background will merge segments together.
function __prompt_segment -S -a background foreground
    if test \( -n "$__prompt_current_background" \) -a \
            \( "$background" != "$__prompt_current_background" \)
        printf " "
        set_color -b $background $__prompt_current_background
        printf "$__prompt_segment_seperator"
    end
    set -g __prompt_current_background $background

    set_color -b $background $foreground
    if test (count $argv) -gt 2
        printf " $argv[3..-1]"
    end
end

### Clears all segment state and draws any pending segment endings.
function __prompt_finish_segments
    __prompt_segment normal normal
    set -e __prompt_current_background
end

### Draws a git status segment.
function __prompt_git_segment
    if not silent git rev-parse --git-dir
        return 1
    end

    if silent count (git status --short)
        __prompt_segment yellow black
    else
        __prompt_segment green black
    end
    __fish_git_prompt " $__prompt_git_symbol %s"
end

### Draws a mercurial status segment
function __prompt_mercurial_segment
    if silent not hg_root
        return 1
    end

    __prompt_segment brmagenta black "$__prompt_hg_symbol "(hg_prompt)
end

### Draw the actual prompt.
function fish_prompt
    set last_status $status

    __prompt_new_line
    __prompt_segment cyan black (date "+%l:%M%p" | string trim)
    test (jobs -l); and __prompt_segment black cyan $__prompt_active_jobs_symbol
    test "$last_status" -ne 0; \
        and __prompt_segment black red $__prompt_bad_exit_symbol
    __prompt_segment black normal $USER@(hostname -s)
    __prompt_segment blue black (prompt_pwd)
    __prompt_git_segment
    __prompt_mercurial_segment
    __prompt_finish_segments

    __prompt_new_line
    switch $fish_bind_mode
        case default
            set_color brred
            printf " << "
            set_color reset
        case visual
            set_color yellow
            printf " << "
            set_color reset
        case "*"
            printf " >> "
    end
end
