#!/bin/bash

case "$1" in
  big-left)
    tmux resize-pane -t 1 -x 190
    ;;
  small-left)
    tmux resize-pane -t 1 -x 95
    ;;
  even-cols)
    WINDOW_WIDTH=$(tmux display -p '#{window_width}')
    tmux resize-pane -t 1 -x $(expr $WINDOW_WIDTH \/ 2)
    ;;
  *)
    echo "Usage: $0 {big-left|small-left|even-cols}"
    exit 1
esac
