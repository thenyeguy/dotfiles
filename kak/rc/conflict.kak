hook global WinCreate .* %{
    require-module conflict
    add-highlighter window/conflicts ref conflicts
    map window user m ": enter-user-mode merge-conflict<ret>" \
        -docstring "merge conflict mode"
}

provide-module conflict %{

# Commands
# ‾‾‾‾‾‾‾‾

define-command conflict-goto-previous %{
    try %{
        execute-keys -save-regs "/" <a-/> ^<<<<<<< <ret>
        execute-keys -save-regs "/" ? ^>>>>>>> <ret>
        execute-keys <a-x>
    } catch %{
        fail "no conflicts found"
    }
}

define-command conflict-goto-next %{
    try %{
        execute-keys -save-regs "/" / ^<<<<<<< <ret>
        execute-keys -save-regs "/" ? ^>>>>>>> <ret>
        execute-keys <a-x>
    } catch %{
        fail "no conflicts found"
    }
}

# Modes
# -----

declare-user-mode merge-conflict

map global merge-conflict p ": conflict-goto-previous<ret>" \
    -docstring "previous conflict"
map global merge-conflict n ": conflict-goto-next<ret>" \
    -docstring "next conflict"

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/conflicts group
add-highlighter shared/conflicts/ regex "^=======" 0:DiffMarker
add-highlighter shared/conflicts/ regex "^(<<<<<<<|>>>>>>>)[^\n]*" 0:DiffMarker
add-highlighter shared/conflicts/ regex "^(\|\|\|\|\|\|\|)[^\n]*" 0:DiffMarker

}
