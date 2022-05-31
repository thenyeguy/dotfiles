#!/bin/bash

key="$1"
if [[ "$key" != [jkhl] ]]; then
    echo "Bad key: $key"
    exit 1
fi

pane_tty=$(tmux display -p "#{pane_tty}")
processes=$(ps -o state= -o comm= -t "$pane_tty" | grep -iE "^[^TXZ ]+")

if [[ "$processes" == *"fzf"* ]]; then
    case "$key" in
        j) tmux send-keys ^$key;;
        k) tmux send-keys ^$key;;
        h) tmux select-pane -L;;
        l) tmux select-pane -R;;
    esac
elif [[ "$processes" == *"nvim"* ]]; then
    tmux send-keys ^$key
else
    case "$key" in
        j) tmux select-pane -D;;
        k) tmux select-pane -U;;
        h) tmux select-pane -L;;
        l) tmux select-pane -R;;
    esac
fi
