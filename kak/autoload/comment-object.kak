provide-module comment-object %{
    define-command -hidden comment-object-detect-comment %{
        evaluate-commands -save-regs "/" %{
            set-register / "(?S)^\h*%opt{comment_line}"
            try %{
                execute-keys -draft "ghGls<ret>"
            } catch %{
                fail "not a comment"
            }
        }
    }

    define-command -hidden comment-object-impl -params 1 %{
        comment-object-detect-comment
        evaluate-commands -save-regs "/" %{
            # Execute movement
            set-register / "(?S)(?:^\h*%opt{comment_line}%arg{1}\n)+|^"
            execute-keys %sh{
                if [[ "$kak_select_mode" == "replace" ]]; then
                    replace="\;"
                fi

                if [[ "$kak_object_flags" == *"to_begin"* ]]; then
                    printf "%s%s" "$replace" "<a-?><ret>"
                fi

                if [[ "$kak_object_flags" == *"to_end"* ]]; then
                    printf "%s%s" "$replace" "?<ret>"
                fi

                if [[ "$kak_object_flags" == *"inner"* ]]; then
                    printf "%s" "_"
                fi
            }
        }
    }

    define-command -hidden comment-object-autowrap %{
        try %{
            evaluate-commands -draft -itersel -save-regs "/" %{
                # Detect comments:
                comment-object-detect-comment
                # Detect long lines:
                set-register / "^[^\n]{%opt{autowrap_column},}[^\n]"
                execute-keys -draft "x<a-k><ret>"
                # Replace previous whitespace w/ line break
                set-register / "\s+"
                execute-keys -draft -with-hooks <esc>\;<a-/><ret>c<ret><end>
            }
        }
    }

    define-command comment-object %{
        comment-object-impl ".*"
    }

    define-command comment-object-paragraph %{
        comment-object-impl ".+"
    }

    define-command comment-object-enable-autowrap %{
        hook -group comment-object-autowrap window InsertChar [^\n] \
            comment-object-autowrap
    }

    define-command comment-object-disable-autowrap %{
        remove-hooks comment-object-autowrap comment-object-autowrap
    }
}
