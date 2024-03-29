#!/bin/bash

# Install rustup.
if ! which rustup > /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --no-modify-path
fi

# Add components.
rustup component add rust-src rust-analyzer

# Install utils.
cargo install edit
cargo install flamegraph
