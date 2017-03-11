# My custom theme, based on this wonderful zsh theme:
#   agnoster's Theme - https://gist.github.com/3712874
#
# This uses some glyphs that may be specific to Source Code Pro.

# Configure fish git prompt
set __fish_git_prompt_describe_style branch
set __fish_git_prompt_showdirtystate true
set __fish_git_prompt_char_dirtystate ○
set __fish_git_prompt_char_stagedstate ◉

function fish_prompt
    set last_status $status

    set segment_seperator 
    set active_jobs_symbol ☼
    set bad_exit_symbol ‼
    set vcs_symbol 

    ### Draws a prompt segment
    # Usage: segment <background> <foreground> [contents]
    # Consecutive calls with the same background will merge segments together.
    function segment -S -a background foreground
        if test \( -n "$__prompt_current_background" \) -a \
                \( "$background" != "$__prompt_current_background" \)
            printf " "
            set_color -b $background $__prompt_current_background
            printf "$segment_seperator"
        end
        set __prompt_current_background $background

        set_color -b $background $foreground
        if test (count $argv) -gt 2
            printf " $argv[3..-1]"
        end
    end

    printf "\n"
    segment cyan black (date "+%l:%M%p" | string trim)
    test (jobs -l); and segment black cyan $active_jobs_symbol
    test "$last_status" -ne 0; and segment black red $bad_exit_symbol
    segment black normal $USER@(hostname -s)
    segment blue black (prompt_pwd)
    if silent git rev-parse --git-dir
        if count (git status --short) >/dev/null
            segment yellow black ""
        else
            segment green black ""
        end
        __fish_git_prompt "$vcs_symbol %s"
    end
    segment normal normal "  \n >> "
end
