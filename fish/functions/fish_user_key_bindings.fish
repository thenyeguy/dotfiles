function fish_user_key_bindings
    fish_vi_key_bindings
    fzf_key_bindings

    bind \cf accept-autosuggestion
    bind -M insert \cf accept-autosuggestion

    bind \cg fzf-git-commit
    bind -M insert \cg fzf-git-commit

    set -g FZF_CTRL_T_COMMAND "list_all_files"
end
