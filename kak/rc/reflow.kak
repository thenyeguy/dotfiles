define-command reflow -docstring "rewraps the currently selected text" %{
    execute-keys "<a-x>|reflow --comment_line '%opt{comment_line}'<ret>"
}

map global user f ": reflow<ret>" -docstring "rewrap text"
