function edit
    if test -n "$ZELLIJ"
        zellij run --close-on-exit -- $EDITOR $argv
        zellij action move-pane-backwards
    else if test -n "$TMUX"
        ~/.dotfiles/tmux/layout.py split -b -- $EDITOR $argv
    else if test "$TERM_PROGRAM" = "WezTerm"
        wezterm cli split-pane --left -- $EDITOR $argv
    else
        eval $EDITOR $argv
    end
end
