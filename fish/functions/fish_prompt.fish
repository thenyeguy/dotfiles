# My custom theme, based on this wonderful zsh theme:
#   agnoster's Theme - https://gist.github.com/3712874
#
# This uses some glyphs that may be specific to Source Code Pro.

# Configure prompt
set __prompt_segment_seperator 
set __prompt_subsegment_seperator 
set __prompt_active_jobs_symbol ☼
set __prompt_bad_exit_symbol ‼
set __prompt_dir_symbol 🖿

set __prompt_git_symbol 
set __prompt_git_unstaged ○
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
    if test -z "$__prompt_current_background"
        # Do nothing - we're starting the first segment.
    else if test "$background" = "$__prompt_current_background"
        # The segment is using the same colors, so just draw a seperator.
        printf " $__prompt_subsegment_seperator"
    else
        # Draw the boundary between two different backgrounds.
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

### Draws a new segment for a generic VCS status.
function __prompt_vcs -a vcs_symbol -a repo_name -a branch -a subtree \
                      -a background -a unstaged -a staged
    # Convert repo status to symbols
    test -n "$unstaged"; and set symbols "$symbols$__prompt_git_unstaged"
    test -n "$staged"; and set symbols "$symbols$__prompt_git_staged"

    __prompt_segment $background black $vcs_symbol $repo_name
    test -n "$branch"; and __prompt_subsegment $branch $symbols
    test -n "$subtree"; and __prompt_subsegment ./$subtree

    # Override the exit code of the test command above
    return 0
end

### Draws a git status segment.
function __prompt_git
    if not silent git rev-parse --git-dir
        return 1
    end

    set repo (basename (git rev-parse --show-toplevel))
    set subtree (git rev-parse --show-prefix | string trim --right -c/)
    set branch (git symbolic-ref HEAD --short --quiet; set os $status)
    if test $os -ne 0
        # Handle detached HEADs
        set branch \((git describe --contains --all HEAD ^/dev/null; \
                      or git rev-parse --short HEAD)\)
    end

    git diff --no-ext-diff --quiet --exit-code 2>/dev/null; or set unstaged y
    git diff-index --cached --quiet HEAD -- 2>/dev/null; or set staged y

    if silent count (git status --short)
        set background yellow
    else
        set background green
    end

    __prompt_vcs $__prompt_git_symbol "$repo" "$branch" "$subtree" \
        "$background" "$unstaged" "$staged"
end

### Draw the actual prompt.
function fish_prompt
    set last_status $status

    __prompt_new_line
    test (jobs -l);
        and __prompt_segment black brred $__prompt_active_jobs_symbol
    test "$last_status" -ne 0; \
        and __prompt_segment black brred $__prompt_bad_exit_symbol
    __prompt_segment brblue black (date "+%l:%M%p" | string trim)
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
