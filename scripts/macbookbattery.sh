#!/bin/bash
if type pmset > /dev/null; then
    percent=$(pmset -g batt | egrep "([0-9]+\%)" -o)
    remaining=$(pmset -g batt | egrep "([0-9:])+ remaining" -o)
    charge=$(pmset -g batt | egrep "(discharging)|(charging)|(charged)" -o)
    if [[ "$charge" == "discharging" && -n "$remaining" ]]; then
        set -- $remaining
        remaining=" ($1)"
    else
        remaining=""
    fi
    echo "#[fg=colour31] #[fg=colour81] $percent$remaining"
    exit 0
else
    exit 1
fi
