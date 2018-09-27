let g:ycm_filetype_blacklist = {
    \   'tagbar':1, 'qf':1, 'notes':1, 'markdown':1, 'unite':1,
    \   'text':1, 'vimwiki':1, 'pandoc':1, 'vim':1,
    \   'gitconfig':1, 'gitcommit':1, 'gitrebase':1,
    \   'tex':1
    \ } " Ignore these filetypes
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm/ycm_extra_conf.py'
nnoremap <leader>g :YcmCompleter GoTo<CR>
nnoremap <leader>t :YcmCompleter GetType<CR>
highlight YcmErrorSection guifg=#f6f3e8 guibg=#3f0000 ctermfg=230 ctermbg=9
