#!/bin/bash

case "$1" in
  main-left)
    tmux setw main-pane-width 190
    tmux select-layout main-vertical
    ;;
  main-right)
    tmux setw main-pane-width 95
    tmux select-layout main-vertical
    ;;
  center)
    WINDOW_WIDTH=$(tmux display -p '#{window_width}')
    tmux setw main-pane-width $(expr $WINDOW_WIDTH \/ 2)
    tmux select-layout main-vertical
    ;;
  *)
    echo "Usage: $0 {left|center|right}"
    exit 1
esac
