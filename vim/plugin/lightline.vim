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
    return (&readonly ? ' ' : '') .
         \ ('' != expand('%') ? expand('%') : '[No Name]')
endfunction
