function edit
    # If using tmux, try to share sessions across users
    if test -n "$TMUX"
        # If using kak, try to tie all editors in the tmux window to one session.
        if test "$EDITOR" = "kak"
            # Generate a window-unique session name:
            set session (tmux display -p '#{session_id}' | base64 | sed 's/=//g')
            set window (tmux display -p '#{window_id}' | base64 | sed 's/=//g')
            set kak_session "tmux-$session-$window"

            # Collect any dead kak sessions:
            if kak -l | grep -q "dead"
                kak -clear
            end

            # Reuse existing session, or start a new one:
            if kak -l | grep -q "$kak_session"
              set argv -c "$kak_session" $argv
            else
              set argv -s "$kak_session" $argv
            end
        end

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
