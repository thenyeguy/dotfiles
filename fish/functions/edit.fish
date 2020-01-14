function edit
    # If using tmux, try to share sessions across users
    if test -n "$TMUX"
        # Generate a window-unique session name:
        set session (tmux display -p '#{session_id}' | base64 | sed 's/=//g')
        set window (tmux display -p '#{window_id}' | base64 | sed 's/=//g')
        set kak_session "tmux-$session-$window"
    end
    
    if kak -l | grep -q $kak_session
      set session_flags -c $kak_session
    else
      set session_flags -s $kak_session
    end
    ~/.dotfiles/tmux/layout.py split -b -- kak $session_flags $argv
end
