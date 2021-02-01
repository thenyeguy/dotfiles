#!/bin/bash

ag -l | fzf --prompt "file> " | :edit
