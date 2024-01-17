let g:lightline = {
    \   'colorscheme': 'nord',
    \   'separator':    { 'left': '', 'right': '' },
    \   'subseparator': { 'left': '', 'right': '' },
    \   'active':   {
    \     'left': [ ['mode', 'paste'], ['fileinfo'] ],
    \     'right': [ ['searchindex', 'lineinfo'], ['spell'] ],
    \   },
    \   'inactive': {
    \     'left': [ ['fileinfo'] ],
    \     'right': [ [], ['lineinfo'] ]
    \   },
    \   'component': {
    \     'lineinfo': ' %l:%v',
    \     'spell': 'spell:%{&spell?&spelllang:""}',
    \   },
    \   'component_function': {
    \     'fileinfo': 'FileInfoSegment',
    \     'searchindex': 'SearchIndexSegment'
    \   },
    \ }

function! SearchIndexSegment()
    " For some reason, terminal buffers can crash vim if search indices are
    " visible, so disable them when in a terminal buffer.
    if &buftype == 'terminal'
        return ""
    end

    " Only enable the segment if there are currently highlighted results inside
    " the buffer.
    let [l:current, l:total] = searchindex#MatchCounts()
    if v:hlsearch && l:total > 0
        return l:current . "/" . l:total
    else
        return ""
    end
endfunction

function! FileInfoSegment()
    if &filetype == "fzf"
        return "fzf"
    end

    let l:filename = expand("%")
    if l:filename == ""
        return ""
    else
        " Build a trimmed version of the file that fits in the current window
        let l:max_width = winwidth(0) * 0.5
        let l:shortened_filename = ""
        for s in reverse(split(fnamemodify(l:filename, ":~:."), "/"))
            if strlen(l:shortened_filename) > l:max_width
                let l:shortened_filename = ".../" . l:shortened_filename
                break
            end
            let l:shortened_filename = s . "/" . l:shortened_filename
        endfor
        let l:filename = l:shortened_filename[:-2]
    end

    let l:readonly = &readonly ? " " : ""
    let l:modified = &modified ? "  +" : ""

    return l:readonly . l:filename . l:modified
endfunction
