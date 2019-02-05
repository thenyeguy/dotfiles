" Set options then load the colorscheme
let g:gruvbox_invert_selection = 0
set background=dark
colorscheme gruvbox

" Make split borders look solid.
highlight VertSplit ctermfg=233 ctermbg=233

" Fix spelling in terminal.
highlight SpellBad ctermfg=9 cterm=underline

" Customize YCM highlighting.
highlight SignColumn ctermbg=0
highlight YcmErrorSign ctermfg=1 ctermbg=0 cterm=bold
highlight YcmWarningSign ctermfg=11 ctermbg=0 cterm=bold

" Customize EasyMotion
highlight EasyMotionTarget ctermfg=11 ctermbg=0 cterm=bold
