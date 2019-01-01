# My custom theme, based on this wonderful zsh theme:
#   agnoster's Theme - https://gist.github.com/3712874
#
# This uses some glyphs that may be specific to Source Code Pro.

# Configure prompt
set __prompt_segment_seperator 
set __prompt_subsegment_seperator 
set __prompt_active_jobs_symbol ☼
set __prompt_bad_exit_symbol ‼

set __prompt_git_symbol 
set __prompt_git_dirty ○
set __prompt_git_staged ◉

set fish_prompt_pwd_dir_length 0

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

### Draws a new subsegment of the current prompt segment.
function __prompt_subsegment
    printf " $__prompt_subsegment_seperator $argv"
end

### Clears all segment state and draws any pending segment endings.
function __prompt_finish_segments
    __prompt_segment normal normal
    set -e __prompt_current_background
end

### Draws a git status segment.
function __prompt_git
    if not silent git rev-parse --git-dir
        return 1
    end

    if silent count (git status --short)
        set color yellow
    else
        set color green
    end

    # Draw repo name.
    set repo (basename (git rev-parse --show-toplevel))
    __prompt_segment $color black $__prompt_git_symbol $repo

    # Draw branch name, identifying detached heads.
    set branch (git symbolic-ref HEAD --short --quiet; set os $status)
    if test $os -ne 0
        set branch \((git describe --contains --all HEAD ^/dev/null; \
                      or git rev-parse --short HEAD)\)
    end
    __prompt_subsegment $branch

    # Attach any status symbols to the current branch.
    git diff --no-ext-diff --quiet --exit-code 2>/dev/null;
        or set symbols "$symbols$__prompt_git_dirty"
    git diff-index --cached --quiet HEAD -- 2>/dev/null;
        or set symbols "$symbols$__prompt_git_staged"
    if test -n "$symbols"
        printf " $symbols"
    end

    # Draw the path relative to the git root, if we aren't already in the root.
    set path (git rev-parse --show-prefix | string trim --right -c/)
    if test -n "$path"
        __prompt_subsegment $path
    end
end

### Draw the actual prompt.
function fish_prompt
    set last_status $status

    __prompt_new_line
    test (jobs -l);
        and __prompt_segment black cyan $__prompt_active_jobs_symbol
    test "$last_status" -ne 0; \
        and __prompt_segment black red $__prompt_bad_exit_symbol
    __prompt_segment cyan black (date "+%l:%M%p" | string trim)
    __prompt_git;
        or __prompt_segment blue black (prompt_pwd)
    __prompt_finish_segments

    __prompt_new_line
    switch $fish_bind_mode
        case default
            set_color brred
            printf " « "
            set_color reset
        case visual
            set_color yellow
            printf " « "
            set_color reset
        case "*"
            printf " » "
    end
end
