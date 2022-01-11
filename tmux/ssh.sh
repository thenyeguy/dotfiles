#!/bin/bash

if [ -n "$SSH_CONNECTION" ]; then
    printf "  ssh "
fi
