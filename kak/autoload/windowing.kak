try %{ require-module kitty }
try %{ require-module tmux }
unalias global terminal

define-command terminal -override -docstring "open new terminal" -params 1.. %{
    evaluate-commands %sh{
        if [ -n "$TMUX" ]; then
            ~/.dotfiles/tmux/layout.py split -- $@
        elif [ "$TERM" == "xterm-kitty" ]; then
            kitty @ launch --no-response --cwd=current "$@"
        else
            printf "fail couldn't open split"
        fi
    }
}

define-command terminal-vertical -params 1.. %{
    evaluate-commands %sh{
        if [ -n "$TMUX" ]; then
            ~/.dotfiles/tmux/layout.py split -v -- $@
        else
            printf "fail can't force vertical split"
        fi
    }
}

define-command terminal-horizontal -params 1.. %{
    evaluate-commands %sh{
        if [ -n "$TMUX" ]; then
            ~/.dotfiles/tmux/layout.py split -h -- $@
        else
            printf "fail can't force horizontal split"
        fi
    }
}

define-command split -docstring "split window" -params 0..1 %{
    evaluate-commands %sh{
        if [ "$1" == "-v" ]; then
            printf "terminal-vertical "
        elif [ "$1" == "-h" ]; then
            printf "terminal-horizontal "
        else
            printf "terminal "
        fi

        if [[ -f "$kak_buffile" ]]; then
            file="+$kak_cursor_line $kak_buffile"
        fi
        printf "kak -c \"%s\" %s" "$kak_session" "$file"
    }
}

define-command sp -docstring "split window vertically" %{ split -v }
define-command vsp -docstring "split window horizontally" %{ split -h }

define-command popup -docstring "run command in a popup" -params 1.. %{
    evaluate-commands %sh{
        if [ -n "$TMUX" ]; then
            tmux popup -E "$@"
        elif [ "$TERM" == "xterm-kitty" ]; then
            kitty @ launch --no-response --cwd=current --type=overlay "$@"
        else
            printf "fail couldn't open popup"
        fi
    }
}
