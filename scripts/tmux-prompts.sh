#!/bin/bash

# Minimum tmux width to display prompts
MINWIDTH=150

# Battery lengths
BATTERYLENGTH=15

# Display constants
SEP=""
BRIGHT="colour81"
DIM="colour31"


# Don't display messages if the window is too narrow
columns=$(tmux display-message -p "#{client_width}")
if (( $columns < $MINWIDTH )); then
    exit 0
fi


# Get script directory
dir=$(dirname $0)


# Get battery output
battery=$($dir/battery-life.sh --tmux)
if [ -n "$battery" ]; then
    IFS=$'\t' read state percent remaining <<< "$battery"

    # Calculate bar widths
    barwidth=$(( ($percent + (50/$BATTERYLENGTH)) * $BATTERYLENGTH / 100 ))
    spacewidth=$(( $BATTERYLENGTH - $barwidth ))
    bar=$(perl -E "print '═' x $barwidth")
    space=$(perl -E "print '┈' x $spacewidth")

    # Display tmux segment
    echo -en " #[fg=$DIM]$SEP #[fg=$BRIGHT]╼${space}${bar}╾"
fi
