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
    let l:filename = fnamemodify(expand("%"), ":~:.")
    return (&readonly ? ' ' : '') .
         \ ('' != l:filename ? l:filename : '[No Name]')
endfunction
