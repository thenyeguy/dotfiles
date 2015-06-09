#!/bin/bash

# Check for printout mode
if [ "$1" == "--tmux" ]; then
    tmux=true
fi

# Queries a Mac media player using applescript
function checkMacPlayer () {
    # First query if the app is running
    service=$1
    running=$(osascript -e "tell application \"System Events\" to \
        (name of processes) contains \"$service\"")
    if [[ $running == "false" ]]; then return 0; fi

    # If the app is running, then check whether it is playing
    state=$(osascript -e "tell application \"$service\" to \
        player state as string")
    if [[ "$state" == "playing" || "$state" == "paused" ]]; then
        artist=$(osascript -e "tell application \"$service\" to \
            artist of current track as string")
        track=$(osascript -e "tell application \"$service\" to \
            name of current track as string")
        displaySong $state "$artist" "$track"
    fi
}

# Queries Nuvola Player using its command line interface
function checkNuvola () {
    state=$(nuvolaplayer3ctl track-info state 2> /dev/null)
    if [[ "$state" == "playing" || "$state" == "paused" ]]; then
        artist=$(nuvolaplayer3ctl track-info artist 2> /dev/null)
        track=$(nuvolaplayer3ctl track-info title 2> /dev/null)

        # Nuvola reports as "paused" when it is really "stopped" with no music,
        # so we check that we actually found a playing song first
        if [[ -n $artist && -n $track ]]; then
            displaySong $state "$artist" "$track"
        fi
    fi
}

# Display the results
function displaySong () {
    state=$1
    artist=$2
    song=$3
    if [ -n "$tmux" ]; then
        echo -e "$state\t$artist\t$song"
    else
        echo -n "$artist - $song"
        if [ "$state" == "paused" ]; then
            echo -n " (paused)"
        fi
        echo ""
    fi
    exit 0
}

# If we have applescript, then we are on a Mac
if type osascript &> /dev/null; then
    checkMacPlayer iTunes
    checkMacPlayer Spotify
    exit 2
# Check for Nuvola Player
elif type nuvolaplayer3ctl > /dev/null; then
    checkNuvola
    exit 2
else
    exit 1
fi
