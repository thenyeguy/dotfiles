# Detection
# ‾‾‾‾‾‾‾‾‾

hook global BufCreate .*(tmux\.conf|\.tmux) %{
    set-option buffer filetype tmux
}

# Initialization
# ‾‾‾‾‾‾‾‾‾‾‾‾‾‾

hook -group tmux-highlight global WinSetOption filetype=tmux %{
    require-module tmux-filetype

    add-highlighter window/tmux ref tmux
    hook -once -always window WinSetOption filetype=.* %{
        remove-highlighter window/tmux
    }
}

provide-module tmux-filetype %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/tmux regions
add-highlighter shared/tmux/code default-region group
add-highlighter shared/tmux/single_string region '"' '"' fill string
add-highlighter shared/tmux/double_string region "'" "'" fill string
add-highlighter shared/tmux/comment region "#" "$" fill comment

# Constants
add-highlighter shared/tmux/code/ regex "\b([0-9]*)\b" 0:value
add-highlighter shared/tmux/code/ regex "\b(on|off)\b" 0:value

}
