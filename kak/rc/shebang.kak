hook global BufCreate .* %{
    evaluate-commands -save-regs "/" %{
        try %{
            set-register /  "^#!"
            execute-keys ggxH<a-k><ret>
            evaluate-commands %sh{
                case "$kak_selection" in
                    *python|*python3) printf "set buffer filetype python";;
                    *sh|bash) printf "set buffer filetype sh";;
                esac
            }
        }
    }
}
