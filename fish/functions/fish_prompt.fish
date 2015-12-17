set __fish_prompt_seperator ""
set __fish_prompt_suspended_symbol " "
set __fish_prompt_failed_symbol ""
set __fish_prompt_root_symbol ""
set __fish_prompt_vcs_symbol ""
set __fish_prompt_vcs_detatched ""

set __fish_git_prompt_describe_style "branch"
set __fish_git_prompt_showdirtystate "true"
set __fish_git_prompt_char_dirtystate " "
set __fish_git_prompt_char_stagedstate ""

function start_segment
    set background $argv[1]
    set foreground $argv[2]

    if [ -n "$__fish_prompt_current_bg" -a \
         "$background" != "$__fish_prompt_current_bg" ]
        printf " "
        set_color -b $background $__fish_prompt_current_bg
        printf "$__fish_prompt_seperator "
    end

    set_color -b $background $foreground
    set -g __fish_prompt_current_bg $background
end

function prompt_time
    start_segment cyan black
    printf (date "+%l:%M%p")
end

function prompt_status
    start_segment black normal
    if [ (jobs | wc -l) -ne "0" ]
        set_color cyan
        printf "$__fish_prompt_suspended_symbol "
    end
    if [ $__prompt_exit_code -ne 0 -a $__prompt_exit_code -ne 20 ]
        set_color red
        printf "$__fish_prompt_failed_symbol "
    end
    if [ "$UID" = "0" ]
        set_color yellow
        printf "$__fish_prompt_root_symbol "
    end
end

function prompt_user
    start_segment black normal
    printf (whoami)"@"(hostname -s)
end

function prompt_cwd
    start_segment blue black
    printf (prompt_pwd)
end

function prompt_git
    if git rev-parse --is-inside-work-tree >/dev/null ^/dev/null
        if test -z (git status --porcelain)
            start_segment green black
        else
            start_segment yellow black
        end

        if test -z (git symbolic-ref --short -q HEAD)
            set sym $__fish_prompt_vcs_detatched
        else
            set sym $__fish_prompt_vcs_symbol
        end
        printf (__fish_git_prompt "$sym %s" | sed -e 's/[ ]*$//')
    end
end

function prompt_indicator
    start_segment normal normal
    set -e __fish_prompt_current_bg
    printf "\n >> "
end

function fish_prompt
    set -g __prompt_exit_code $status
    printf "\n"
    prompt_time
    prompt_status
    prompt_user
    prompt_cwd
    prompt_git
    prompt_indicator
end
