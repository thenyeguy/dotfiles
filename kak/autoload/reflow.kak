declare-option int reflow_line_width 80

define-command reflow -docstring "rewraps the currently selected text" %{
    execute-keys "<a-x>|reflow --comment_line '%opt{comment_line}' --width '%opt{reflow_line_width}'<ret>"
}

hook global BufSetOption filetype=rust %{
    set-option buffer reflow_line_width 100
}

map global user f ": reflow<ret>" -docstring "rewrap text"
