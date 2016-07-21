#!/bin/bash

# Minimum tmux width to display prompts
MINWIDTH=150

# Music segment lengths
MAXARTISTLENGTH=20
MAXMUSICLENGTH=45

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


# Get current song
if (( $(find $HOME/.currentsong -mtime -5m | wc -w) > 0 )); then
    IFS=$'\t' read artist song < $HOME/.currentsong
    if (( ${#artist} > $MAXARTISTLENGTH+3 )); then
        artist="${artist:0:$MAXARTISTLENGTH}..."
    fi
    text="$artist - $song"
    if (( ${#text} > $MAXMUSICLENGTH+3 )); then
        text="${text:0:$MAXMUSICLENGTH}..."
    fi
    echo -en " #[fg=$DIM]$SEP #[fg=$BRIGHT]♫ $text"
fi


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
    echo -en " #[fg=$DIM]$SEP #[fg=$BRIGHT]╼${bar}${space}╾"
fi
