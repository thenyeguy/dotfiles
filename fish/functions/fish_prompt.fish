### Configure symbols
set -g __prompt_segment_seperator ""
set -g __prompt_subsegment_seperator ""

set -g __prompt_active_jobs_symbol "󰣕 "
set -g __prompt_bad_exit_symbol " "
set -g __prompt_ssh_symbol " "

set -g __prompt_git_symbol ""
set -g __prompt_git_staged " "
set -g __prompt_git_semistaged "󰦕 "
set -g __prompt_git_untracked " "


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
        printf " %s" "$__prompt_subsegment_seperator"
    else
        # Draw the boundary between two different backgrounds.
        printf " "
        set_color -b $background $__prompt_current_background
        printf "%s" "$__prompt_segment_seperator"
    end
    set -g __prompt_current_background $background

    set_color -b $background $foreground
    if test (count $argv) -gt 2
        printf " %s" "$argv[3..-1]"
    end
end

### Draws a new subsegment of the current prompt segment.
function __prompt_subsegment
    printf " %s %s" "$__prompt_subsegment_seperator" "$argv"
end

### Clears all segment state and draws any pending segment endings.
function __prompt_finish_segments
    __prompt_segment normal normal
    set -e __prompt_current_background
end

### Prints colored text.
function __prompt_colored -a color
    set_color "$color"
    printf "%s" "$argv[2..]"
    set_color reset
end

function __prompt_ssh
    if test -n "$TMUX" -o -z "$SSH_CONNECTION";
        return 1
    end
    __prompt_segment black magenta $__prompt_ssh_symbol (hostname -s)
end

### Draws a new segment for a generic VCS status.
function __prompt_vcs -a color -a vcs_symbol -a repo_name -a branch -a subtree \
                      -a symbols
    __prompt_segment black $color $vcs_symbol $repo_name
    test -n "$branch"; and __prompt_subsegment $branch
    test -n "$subtree"; and __prompt_subsegment ./$subtree
    test -n "$symbols"; and __prompt_subsegment $symbols

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
        set branch \((git describe --contains --all HEAD 2>/dev/null; \
                      or git rev-parse --short HEAD)\)
    end

    set symbols ""
    set git_status (git status --short --ignore-submodules=dirty)
    if string match -qr "^[A-Z]" $git_status
        if string match -qr "^.[A-Z]" $git_status
            set symbols "$symbols$__prompt_git_semistaged"
        else
            set symbols "$symbols$__prompt_git_staged"
        end
    end
    string match -qr "^\?\?" $git_status;
        and set symbols "$symbols$__prompt_git_untracked"

    if test -n "$git_status"
        set color yellow
    else
        set color green
    end

    __prompt_vcs "$color" "$__prompt_git_symbol" "$repo" "$branch" "$subtree" "$symbols"
end

### Draws a new segment for general shell status.
function __prompt_shell_status -a last_status
    test "$last_status" -ne 0;
        and __prompt_colored red " $__prompt_bad_exit_symbol"
    test (jobs -l);
        and __prompt_colored yellow " $__prompt_active_jobs_symbol"
end

### Draw the actual prompt.
function fish_prompt
    set last_status $status

    __prompt_new_line
    __prompt_segment blue black (date "+%l:%M%p" | string trim)
    __prompt_ssh
    __prompt_git;
        or __prompt_segment black blue (prompt_pwd)
    __prompt_finish_segments

    __prompt_new_line
    __prompt_shell_status $last_status
    switch $fish_bind_mode
        case insert
            printf " › "
        case default
            set_color brblack;   printf " › "
        case replace replace_one
            set_color brred;     printf " › "
        case visual
            set_color yellow;    printf " › "
        case "*"
            set_color brmagenta; printf " › "
    end
    set_color reset
end

function fish_right_prompt
    switch $fish_bind_mode
        case insert
        case default
            set_color brblack;   printf " ‹ normal"
        case replace replace_one
            set_color brred;     printf " ‹ replace"
        case visual
            set_color yellow;    printf " ‹ visual"
        case "*"
            set_color brmagenta; printf " ‹ %s" "$fish_bind_mode"
    end
    set_color reset
end
