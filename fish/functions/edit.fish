function edit
    # If using tmux, try to share sessions across users
    if test -n "$TMUX"
        ~/.dotfiles/tmux/layout.py split -b -- $EDITOR $argv
    else if test "$TERM_PROGRAM" = "WezTerm"
        wezterm cli split-pane --left -- $EDITOR $argv
    else
        eval $EDITOR $argv
    end
end
