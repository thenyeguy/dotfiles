#!/bin/bash

window=$(tmux list-windows -F "#I: #W" | tac | fzf-tmux -p 50,15 | cut -d ":" -f 1)

if [ -n "$window" ]; then
    tmux select-window -t $window
fi
