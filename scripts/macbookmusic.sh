#!/bin/bash

# Queries a Mac media player using applescript
function checkMacPlayer () {
    # First query if the app is running
    service=$1
    running=$(osascript -e "tell application \"System Events\" to \
        (name of processes) contains \"$service\"")
    if [[ $running == "false" ]]; then return 0; fi

    # If the app is running, then check whether it is playing
    status=$(osascript -e "tell application \"$service\" to \
        player state as string")
    if [[ "$status" == "playing" ]]; then
        artist=$(osascript -e "tell application \"$service\" to \
            artist of current track as string")
        track=$(osascript -e "tell application \"$service\" to \
            name of current track as string")
        displaySong $status "$artist" "$track"
    fi
}

# Write a tmux prompt segment
function displaySong () {
    if [ $1 == "playing" ]; then
        color="colour81"
    else
        color="colour31"
    fi
    icon=""
    echo "#[fg=colour31] #[fg=$color]$icon $2 - $3"
    exit 0
}

# If we have applescript, then we are on a Mac
if type osascript > /dev/null; then
    checkMacPlayer iTunes
    checkMacPlayer Spotify
    exit 2
else
    exit 1
fi
