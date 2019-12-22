#!/bin/bash

width=$(tmux display -p "#{pane_width}")
height=$(tmux display -p "#{pane_height}")

# If no direction is specified, then intelligently split based on aspect ratio,
# favoring wide windows.
if [ "$1" == "-v" ] || [ "$1" == "-h" ]; then
    dir="$1"
    shift
elif (( $width < 120)) || (( $width < 2 * $height )); then
    dir="-v"
else
    dir="-h"
fi

# Split and automatically rebalance the new row or column.
tmux split-window $dir -c "#{pane_current_path}" ${@:1}
