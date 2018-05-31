let g:lightline = {
    \   'colorscheme': 'custom',
    \   'separator':    { 'left': '', 'right': '' },
    \   'subseparator': { 'left': '', 'right': '' },
    \   'active':   {
    \     'left': [ ['mode', 'paste'], ['fileinfo', 'modified'] ],
    \     'right': [ ['percent', 'lineinfo'], ['spell', 'filetype'] ],
    \   },
    \   'inactive': { 'right': [ [], ['lineinfo'] ] },
    \   'component_function': { 'fileinfo': 'CustomFileInfo' },
    \ }

function! CustomFileInfo()
    " Build a trimmed version of the file that fits in the current window
    let l:max_width = winwidth(0) * 0.5
    let l:filename = ""
    for s in reverse(split(fnamemodify(expand("%"), ":~:."), "/"))
        let l:extended_filename = s . "/" . l:filename
        if strlen(l:filename) > l:max_width
            let l:filename = ".../" . l:filename
            break
        end
        let l:filename = l:extended_filename
    endfor
    let l:filename = l:filename[:-2]  " strip trailing / from join

    return (&readonly ? ' ' : '') .
         \ ('' != l:filename ? l:filename : '[No Name]')
endfunction
