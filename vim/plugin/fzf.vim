let $FZF_DEFAULT_COMMAND = 'ag -g ""'

let g:fzf_layout = { 'window': 'enew' }
let g:fzf_colors = {
    \   'fg':      ['fg', 'Normal'],
    \   'bg':      ['bg', 'Normal'],
    \   'hl':      ['fg', 'Comment'],
    \   'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \   'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \   'hl+':     ['fg', 'Comment'],
    \   'info':    ['fg', 'PreProc'],
    \   'border':  ['fg', 'Ignore'],
    \   'prompt':  ['fg', 'Conditional'],
    \   'pointer': ['fg', 'Exception'],
    \   'marker':  ['fg', 'Keyword'],
    \   'spinner': ['fg', 'Label'],
    \   'header':  ['fg', 'Comment']
    \ }

" Prevent FZF from overriding the statusline by doing nothing. This will make
" sure lightline still draws
function! s:fzf_statusline()
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

nnoremap <c-o> :Files<CR>
