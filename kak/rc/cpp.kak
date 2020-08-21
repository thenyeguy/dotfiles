hook global BufCreate .*\.h$ %{
    set-option buffer filetype cpp
}

hook global WinSetOption filetype=cpp %{
    require-module cpp
    require-module cpp-extended
}

provide-module cpp-extended %{

# Highlighters
# ‾‾‾‾‾‾‾‾‾‾‾‾

add-highlighter shared/cpp/code/ regex "(\w+)::" 1:module
add-highlighter shared/cpp/code/ regex "(\w+)\(" 1:function

}
