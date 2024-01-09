function edit
    # If using tmux, try to share sessions across users
    if test -n "$TMUX"
        ~/.dotfiles/tmux/layout.py split -b -- $EDITOR $argv
    else if test "$TERM" = "xterm-kitty"
        # Launch in a new kitty split. Use fish,in order to pass down environment.
        kitty @ launch --no-response --cwd=$PWD --location=before fish -c "$EDITOR $argv"
    else if test "$TERM_PROGRAM" = "WezTerm"
        wezterm cli split-pane --left -- $EDITOR $argv
    else
        eval $EDITOR $argv
    end
end
