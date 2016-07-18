#!/bin/bash

# Minimum tmux width to display prompts
MINWIDTH=150

# Music segment lengths
MAXARTISTLENGTH=20
MAXMUSICLENGTH=45

# Display constants
SEP=""
RED="colour178"
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

    # Only display time remaining if we are on battery
    if [[ "$state" == "discharging" && -n "$remaining" ]]; then
        set -- $remaining
        remaining=" ($1)"
    else
        remaining=""
    fi

    # Turn icon red at low battery
    if (( ${percent%?} < 15 )); then
        color="$RED"
    else
        color="$BRIGHT"
    fi

    # Display tmux segment
    echo -en " #[fg=$DIM]$SEP #[fg=$color]☼ #[fg=$BRIGHT]$percent$remaining"
fi
