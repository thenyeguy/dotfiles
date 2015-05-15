#!/bin/bash

# Check for printout mode
if [ "$1" == "--tmux" ]; then
    tmux=true
fi

# Check for pmset to determine if we are on OSX
if type pmset &> /dev/null; then
    # Parse out relevent sections of report
    percent=$(pmset -g batt | egrep "([0-9]+\%)" -o)
    remaining=$(pmset -g batt | egrep "([0-9:])+ remaining" -o)
    state=$(pmset -g batt | egrep "(discharging)|(charging)|(charged)" -o)

    if [ -n "$tmux" ]; then
        echo -e "$state\t$percent\t$remaining"
    else
        echo "$percent ($remaining)"
    fi
    exit 0
else
    exit 1
fi
