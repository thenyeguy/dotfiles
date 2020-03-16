define-command clipboard-copy -docstring "copy to the system clipboard" %{
    execute-keys "<a-|>clipboard copy<ret>"
    echo -markup "{Information}yanked selection to clipboard"
}

define-command clipboard-paste -params 1 \
        -docstring "paste from the system clipboard" %{
    execute-keys %sh{
        if [[ "$1" == "before" ]]; then
            printf "!clipboard paste<ret>"
        else
            printf "<a-!>clipboard paste<ret>"
        fi
    }
}
