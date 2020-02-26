hook global WinSetOption filetype=git-commit %{
    require-module git-commit
    require-module git-commit-extended

    set-option window autowrap_column 72
    set-option window autowrap_format_paragraph true
    autowrap-enable
}

provide-module git-commit-extended %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

# Highlight first line over 50 characters:
add-highlighter shared/git-commit/description default-region group
add-highlighter shared/git-commit/description/ regex \
    "\A[\s\n]*[^#\s][^\n]{49}([^\n]+)" 1:Error

# Highlight branch names:
add-highlighter shared/git-commit/comments/ regex "On branch (\w+)" 1:bright-blue
add-highlighter shared/git-commit/comments/ regex "Your branch .* '(.+)'" 1:bright-blue

}
