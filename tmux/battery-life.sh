#!/bin/bash

# Display constants
BATTERYLENGTH=15
MINWIDTH=150
SEP=""
BRIGHT="colour81"
DIM="colour31"

# Don't display battery if the window is too narrow
columns=$(tmux display-message -p "#{client_width}")
if (( $columns < $MINWIDTH )); then
    exit
fi

# Use OS-specific methods to find battery stats
if type pmset &> /dev/null; then
    # Parse out relevent sections of report
    percent=$(pmset -g batt | egrep "([0-9]+)\%" -o | sed "s/%//")
    remaining=$(pmset -g batt | egrep "([0-9:])+ remaining" -o)
else
    exit
fi

# Display the segment
barwidth=$(( ($percent + (50/$BATTERYLENGTH)) * $BATTERYLENGTH / 100 ))
spacewidth=$(( $BATTERYLENGTH - $barwidth ))
bar=$(perl -E "print '═' x $barwidth")
space=$(perl -E "print '┈' x $spacewidth")
echo -en " #[fg=$DIM]$SEP #[fg=$BRIGHT]╼${space}${bar}╾"
