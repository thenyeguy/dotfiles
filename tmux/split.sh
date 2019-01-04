#!/bin/bash

width=$(tmux display -p "#{pane_width}")
height=$(tmux display -p "#{pane_height}")

# Automatically split based on aspect ratio, favoring wide windows.
if (( $width < 120)) || (( $width < 2 * $height )); then
    dir="-v"
else
    dir="-h"
fi

# Split and automatically rebalance the new row or column.
tmux split-window $dir -c "#{pane_current_path}"
tmux select-layout -E
