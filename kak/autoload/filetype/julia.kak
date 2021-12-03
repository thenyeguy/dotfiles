hook global WinSetOption filetype=julia %{
    require-module julia-extended

    hook window ModeChange pop:insert:.* -group julia-trim-indent julia-trim-indent
    hook window InsertChar .* -group julia-indent julia-indent-on-char
    hook window InsertChar \n -group julia-indent julia-indent-on-new-line
    hook window InsertChar \n -group julia-insert julia-insert-on-new-line

    hook -always -once window WinSetOption filetype=.* %{
        remove-hooks window julia-.+
    }
}

provide-module julia-extended %[

# Commands
# ‾‾‾‾‾‾‾‾

define-command -hidden julia-trim-indent %[
    # remove trailing whitespaces
    try %[ execute-keys -draft -itersel <a-x> s \h+$ <ret> d ]
]
  
define-command -hidden julia-indent-on-char %[
    evaluate-commands -no-hooks -draft -itersel %[
        # unindent middle and end structures
        try %[ execute-keys -draft \
            <a-h><a-k>^\h*(\b(end|else|elseif)\b|[)}])$<ret> \
            :julia-indent-on-new-line<ret> \
            <a-lt>
        ]
    ]
]

define-command -hidden julia-indent-on-new-line %[
    evaluate-commands -no-hooks -draft -itersel %[
        # remove trailing white spaces from previous line
        try %[ execute-keys -draft k : julia-trim-indent <ret> ]
        # preserve previous non-empty line indent
        try %[ execute-keys -draft <space>gh<a-?>^[^\n]+$<ret>s\A|.\z<ret>)<a-&> ]
        # add one indentation level if the previous line is not a comment and:
        #     - starts with a block keyword that is not closed on the same line,
        #     - or contains an unclosed function expression,
        #     - or ends with an enclosed '(' or '{'
        try %[ execute-keys -draft \
            <space> K<a-x> \
            <a-K>\A\h*--<ret> \
            <a-K>\A[^\n]*\b(end)\b<ret> \
            <a-k>\A(\h*\b(else|elseif|for|function|if|while|struct)\b|[^\n]*[({]$|[^\n]*\bfunction\b\h*[(])<ret> \
            <a-:><semicolon><a-gt>
        ]
    ]
]

define-command -hidden julia-insert-on-new-line %[
    evaluate-commands -no-hooks -draft -itersel %[
        # copy -- comment prefix and following white spaces
        try %[ execute-keys -draft k<a-x>s^\h*\K--\h*<ret> y gh j <a-x><semicolon> P ]
        # wisely add end structure
        evaluate-commands -save-regs x %[
            # save previous line indent in register x
            try %[ execute-keys -draft k<a-x>s^\h+<ret>"xy ] catch %[ reg x '' ]
            try %[
                # check that starts with a block keyword that is not closed on the same line
                execute-keys -draft \
                    k<a-x> \
                    <a-k>^\h*\b(else|elseif|for|function|if|while|struct)\b|[^\n]\bfunction\b\h*[(]<ret> \
                    <a-K>\bend\b<ret>
                # check that the block is empty and is not closed on a different line
                execute-keys -draft <a-a>i <a-K>^[^\n]+\n[^\n]+\n<ret> j<a-x> <a-K>^<c-r>x\b(else|elseif|end)\b<ret>
                # auto insert end
                execute-keys -draft o<c-r>xend<esc>
                # auto insert ) for anonymous function
                execute-keys -draft k<a-x><a-k>\([^)\n]*function\b<ret>jjA)<esc>
            ]
        ]
    ]
]

]
