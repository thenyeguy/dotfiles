let g:lightline = {
    \   'colorscheme': 'custom',
    \   'separator':    { 'left': '', 'right': '' },
    \   'subseparator': { 'left': '', 'right': '' },
    \   'active':   {
    \     'left': [ ['mode', 'paste'], ['fileinfo'] ],
    \     'right': [ ['percent', 'lineinfo'], ['spell', 'filetype'] ],
    \   },
    \   'inactive': {
    \     'left': [ ['fileinfo'] ],
    \     'right': [ [], ['lineinfo'] ]
    \   },
    \   'component_function': { 'fileinfo': 'CustomFileInfo' },
    \ }

function! CustomFileInfo()
    if &filetype == "fzf"
        return "fzf"
    en

    let l:filename = expand("%")
    if l:filename == ""
        return ""
    else
        " Build a trimmed version of the file that fits in the current window
        let l:max_width = winwidth(0) * 0.5
        let l:shortened_filename = ""
        for s in reverse(split(fnamemodify(l:filename, ":~:."), "/"))
            let l:shortened_filename = s . "/" . l:shortened_filename
            if strlen(l:filename) > l:max_width
                let l:shortened_filename = ".../" . l:shortened_filename
                break
            end
        endfor
        let l:filename = l:shortened_filename[:-2]
    end

    let l:readonly = &readonly ? " " : ""
    let l:modified = &modified ? "  +" : ""

    return l:readonly . l:filename . l:modified
endfunction
