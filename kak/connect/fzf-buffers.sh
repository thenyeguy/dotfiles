#!/bin/bash

:ls | fzf --prompt "buf> " | :buffer
