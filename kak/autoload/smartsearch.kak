provide-module smartsearch %{
    set-face global SearchMatch default

    declare-option -hidden bool smartsearch_enabled false
    declare-option -hidden bool smartsearch_visible false

    define-command -hidden smartsearch-show %{
        set-option global smartsearch_visible true
        try %{ add-highlighter global/smartsearch dynregex '%reg{/}' 0:SearchMatch }
    }

    define-command -hidden smartsearch-hide %{
        set-option global smartsearch_visible false
        try %{ remove-highlighter global/smartsearch }
    }

    define-command smartsearch-toggle %{
        evaluate-commands %sh{
            if [ "$kak_opt_smartsearch_enabled" != true ]; then
                exit
            fi
            if [ "$kak_opt_smartsearch_visible" = true ]; then
                printf "smartsearch-hide"
            else
                printf "smartsearch-show"
            fi
        }
    }

    define-command smartsearch-enable %{
        set-option global smartsearch_enabled true
        hook global -group smartsearch NormalKey [/?nN*]|<a-[/?nN*]> %{
            smartsearch-show
        }
    }

    define-command smartsearch-disable %{
        smartsearch-hide
        set-option global smartsearch_enabled false
        remove-hooks global smartsearch
    }

    define-command smartsearch-select %{
        execute-keys -with-hooks -save-regs "" %sh{
            if (( "$kak_selection_length" > 1 )); then
                printf "*"
            else
                printf "<a-i>w*"
            fi
        }
    }
}
