#!/bin/bash
function displaySong () {
    if [ $1 == "playing" ]; then
        color="colour81"
    else
        color="colour31"
    fi
    icon=""
    echo "#[fg=colour31] #[fg=$color]$icon $2 - $3"
}

if type osascript > /dev/null; then
    # First check iTunes
    itunes=$(osascript -e 'tell application "iTunes" to player state as string')
    if [[ "$itunes" == "playing" ]]; then
        artist=`osascript -e 'tell application "iTunes" to \
            artist of current track as string'`;
        track=`osascript -e 'tell application "iTunes" to \
            name of current track as string'`;
        displaySong $itunes "$artist" "$track"
        exit 0
    fi

    # Then check Spotify
    spotify=$(osascript -e 'tell application "Spotify" to player state as string')
    if [[ "$spotify" == "playing" ]]; then
        artist=`osascript -e 'tell application "Spotify" to \
            artist of current track as string'`;
        track=`osascript -e 'tell application "Spotify" to \
            name of current track as string'`;
        displaySong $spotify "$artist" "$track"
        exit 0
    fi
    exit 2
else
    exit 1
fi
