#!/bin/bash

if [[ "$1" =~ "Z" ]]; then
    echo -n "  "
fi

if [[ "$1" =~ "!" ]]; then
    echo -n "#[fg=yellow]󰂚  #[fg=white]"
fi
