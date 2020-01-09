set-face global CursorLine default

define-command -hidden smartcursor-update-line %{
    try %{ rmhl window/smartcursor-line }
    try %{ addhl window/smartcursor-line line %val{cursor_line} CursorLine }
}

define-command -hidden smartcursor-hide-faces %{
    set-face window PrimaryCursor default
    set-face window PrimaryCursorEol default
    set-face window PrimarySelection default
    set-face window SecondaryCursor default
    set-face window SecondaryCursorEol default
    set-face window SecondarySelection default
    set-face window CursorLine default
}

define-command -hidden smartcursor-show-faces %{
    unset-face window PrimaryCursor
    unset-face window PrimaryCursorEol
    unset-face window PrimarySelection
    unset-face window SecondaryCursor
    unset-face window SecondaryCursorEol
    unset-face window SecondarySelection
    unset-face window CursorLine
}

define-command smartcursor-enable %{
    hook -group smartcursor-toggle window FocusOut .* %{
        smartcursor-hide-faces
    }
    hook -group smartcursor-toggle window FocusIn .* %{
        smartcursor-show-faces
    }
}

define-command smartcursor-disable %{
    remove-hooks window smartcursor-toggle
    smartcursor-show-faces
}

define-command smartcursor-enable-lines %{
    smartcursor-update-line
    hook -group smartcursor-lines window RawKey .* %{
        smartcursor-update-line
    }

}
define-command smartcursor-disable-lines %{
    remove-hooks window smartcursor-lines
    try %{ rmhl window/smartcursor-line }
}
