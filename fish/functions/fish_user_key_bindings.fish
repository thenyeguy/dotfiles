function fish_user_key_bindings
    fish_vi_key_bindings

    if test -e ~/.fzf/bin
        set -x PATH ~/.fzf/bin $PATH
        source ~/.fzf/shell/key-bindings.fish
        fzf_key_bindings
    end
end
