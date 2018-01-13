let s:black = ['#000000', 232]
let s:gray1 = ['#242424', 235]
let s:gray2 = ['#444444', 238]
let s:gray3 = ['#585858', 240]
let s:gray5 = ['#bcbcbc', 250]
let s:gray6 = ['#dadada', 253]

let s:darkblue = ['#0000d7', 20]
let s:darkgreen = ['#005f00', 22]
let s:darkred = ['#5f0000', 52]
let s:blue = ['#5fafff', 75]
let s:green = ['#afd75f', 149]
let s:orange = ['#d78700', 172]
let s:red = ['#d75f5f', 167]

let s:p = {
    \   'normal': {
    \       'left': [ [s:darkgreen, s:green, 'bold'], [s:gray6, s:gray2] ],
    \       'right': [ [s:gray1, s:gray5], [s:gray5, s:gray2] ],
    \       'middle': [ [s:gray2, s:black] ],
    \   },
    \   'inactive': {
    \       'left': [ [s:gray3, s:black], [s:gray3, s:black] ],
    \       'right': [ [s:gray3, s:black], [s:gray3, s:black] ],
    \       'middle': [ [s:gray3, s:black] ],
    \   },
    \   'insert': {
    \       'left': [ [s:darkblue, s:blue, 'bold'], [s:gray6, s:gray2] ],
    \   },
    \   'visual': {
    \       'left': [ [s:darkred, s:orange, 'bold'], [s:gray6, s:gray2] ],
    \   },
    \   'replace': {
    \       'left': [ [s:darkred, s:red, 'bold'], [s:gray6, s:gray2] ],
    \   },
    \ }

let g:lightline#colorscheme#custom#palette = lightline#colorscheme#flatten(s:p)
