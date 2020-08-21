function tm
    if test -n "$TMUX"
        echo "Already using tmux..."
        return 2
    else
        tmux new-session -A -s dev
    end
end
