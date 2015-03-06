#!/bin/bash

# Check for pmset to determine if we are on OSX
if type pmset &> /dev/null; then
    # Parse out relevent sections of report
    percent=$(pmset -g batt | egrep "([0-9]+\%)" -o)
    remaining=$(pmset -g batt | egrep "([0-9:])+ remaining" -o)
    charge=$(pmset -g batt | egrep "(discharging)|(charging)|(charged)" -o)

    # Only display time remaining if we are on battery
    if [[ "$charge" == "discharging" && -n "$remaining" ]]; then
        set -- $remaining
        remaining=" ($1)"
    else
        remaining=""
    fi

    # Turn icon red at low battery
    if (( ${percent%?} < 10 )); then
        color="colour9"
    else
        color="colour81"
    fi

    # Display tmux segment
    echo "#[fg=colour31] #[fg=$color] #[fg=colour81]$percent$remaining "
    exit 0
else
    exit 1
fi
