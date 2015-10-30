" Maintainer:   Lars H. Nielsen (dengmao@gmail.com)
" Cterm addition: Paul deGrandis
" Last Change:  January 22 2007
"
" Cterm colors modified by Michael Nye

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "wombat"


" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine                 guibg=#303030                            ctermbg=236 cterm=none
  hi CursorColumn               guibg=#303030                            ctermbg=236
  hi ColorColumn                guibg=#303030                            ctermbg=236
  hi MatchParen   guifg=#ffffd7 guibg=#87875f gui=bold      ctermfg=230  ctermbg=101 cterm=bold
  hi Pmenu        guifg=#ffffd7 guibg=#444444               ctermfg=230  ctermbg=238
  hi PmenuSel     guifg=#000000 guibg=#d7d787               ctermfg=0    ctermbg=186
endif

" General colors
hi Cursor                       guibg=#626262                            ctermbg=241
hi Normal         guifg=#ffffd7 guibg=#1c1c1c               ctermfg=230  ctermbg=234
hi NonText        guifg=#808080 guibg=#262626               ctermfg=244  ctermbg=235
hi LineNr         guifg=#87875f guibg=#121212               ctermfg=101  ctermbg=233
hi StatusLine     guifg=#ffffd7 guibg=#444444 gui=italic    ctermfg=230  ctermbg=238
hi StatusLineNC   guifg=#87875f guibg=#444444               ctermfg=101  ctermbg=238
hi VertSplit      guifg=#444444 guibg=#444444               ctermfg=238  ctermbg=238
hi Folded         guibg=#3a3a3a guifg=#a8a8a8               ctermbg=237  ctermfg=248
hi Title          guifg=#ffffd7 guibg=#000000 gui=bold      ctermfg=230  ctermbg=238 cterm=bold
hi Visual                       guibg=#444444                            ctermbg=238
hi SpecialKey     guifg=#585858 guibg=#1c1c1c               ctermfg=240  ctermbg=234
hi Search         guifg=#1c1c1c guibg=#cae682 gui=bold      ctermfg=234  ctermbg=149 cterm=bold
hi SpellBad       guifg=#e5786d guibg=#1c1c1c gui=undercurl ctermfg=167  ctermbg=234 cterm=underline

" Syntax highlighting
hi Comment        guifg=#808080               gui=italic    ctermfg=244
hi Todo           guifg=#ffaf00               gui=italic    ctermfg=214              cterm=bold,underline
hi Constant       guifg=#d75f5f                             ctermfg=167
hi String         guifg=#afff00                             ctermfg=154
hi Identifier     guifg=#d7d787                             ctermfg=186              cterm=none
hi Function       guifg=#5fafff                             ctermfg=75
hi Type           guifg=#afd75f                             ctermfg=149
hi Statement      guifg=#5fafff                             ctermfg=75               cterm=bold
hi Keyword        guifg=#5fafff                             ctermfg=75
hi PreProc        guifg=#d75f5f                             ctermfg=167
hi Number         guifg=#d75f5f                             ctermfg=167

" Diff colors
hi DiffAdd                      guibg=#005f00                            ctermbg=22
hi DiffDelete    guifg=#870000  guibg=#5f0000               ctermfg=88   ctermbg=52
hi DiffChange                   guibg=#444444                            ctermbg=238
hi DiffText                     guibg=#875f00                            ctermbg=94  cterm=bold
