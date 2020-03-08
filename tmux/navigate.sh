#!/bin/bash

key="$1"
if [[ "$key" != [jkhl] ]]; then
    echo "Bad key: $key"
    exit 1
fi

pane_cmd=$(tmux display -p "#{pane_start_command}")
if [[ "$pane_cmd" == *"fzf"* ]]; then
    tmux send-keys ^$key
else
    case "$key" in
        j) tmux select-pane -D;;
        k) tmux select-pane -U;;
        h) tmux select-pane -L;;
        l) tmux select-pane -R;;
    esac
fi
