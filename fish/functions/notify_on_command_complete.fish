set __notify_on_command_complete_min_ms 45000

function __notify_get_active_terminal_id \
        -d "Generates a unique ID for the active TMUX pane/terminal."
    if silent type xprop
        echo -n (xprop -root _NET_ACTIVE_WINDOW 2>/dev/null | awk '{print $NF}')
    end

    if test -n "$TMUX"
        set windowid (tmux list-windows -F '#{window_active} #{window_id}' | \
                      awk '{if ($1~/^1/) print $2}')
        set paneid (tmux list-panes -F '#{pane_active} #{pane_pid}' | \
                    awk '{if ($1~/^1/) print $2}')
        echo -n ":$windowid-$paneid"
    end
end

function __notify_preexec --on-event fish_preexec
    set -g __notify_terminal_id (__notify_get_active_terminal_id)
end

function __notify_postexec --on-event fish_postexec
    set -l cmd_duration $CMD_DURATION
    set -l active_terminal_id (__notify_get_active_terminal_id)

    if test $cmd_duration -lt $__notify_on_command_complete_min_ms
        return
    else if test -n "$SSH_CONNECTION"
        tput bel
        return
    else if test "$active_terminal_id" = "$__notify_terminal_id"
        return
    end

    notify "Command complete:" " >> $argv"
end
