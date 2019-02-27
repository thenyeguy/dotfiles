#!/bin/bash

# Update the layout settings, if provided.
case "$1" in
  automatic)
    tmux setw -u main-pane-width
    ;;
  editor-small)
    tmux setw main-pane-width 90
    ;;
  editor-big)
    tmux setw main-pane-width 180
    ;;
esac

# Perform auto rebalancing.
main_pane_width=$(tmux showw main-pane-width | cut -d' ' -f2)
if [[ -n "$main_pane_width" ]]; then
    # Editor mode: fix the size of the left-most pane.
    tmux resize-pane -t 1 -x $main_pane_width
else
    # Autobalance all pane sizes.
    tmux select-layout -E
fi
