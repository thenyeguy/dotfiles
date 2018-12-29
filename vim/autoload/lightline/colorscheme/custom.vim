let s:black = ['#000000', 232]
let s:gray1 = ['#444444', 238]
let s:gray2 = ['#585858', 240]
let s:gray3 = ['#bcbcbc', 250]
let s:gray4 = ['#dadada', 253]
let s:white = ['#ffffff', 231]

let s:darkblue = ['#005f87', 24]
let s:darkgreen = ['#005f00', 22]
let s:darkred = ['#5f0000', 52]
let s:blue = ['#5f87af', 67]
let s:green = ['#afd75f', 149]
let s:orange = ['#d78700', 172]
let s:red = ['#af5f5f', 131]

let s:p = {
    \   'normal': {
    \       'left': [ [s:darkgreen, s:green, 'bold'], [s:gray4, s:gray1] ],
    \       'right': [ [s:gray1, s:gray3], [s:gray3, s:gray1] ],
    \       'middle': [ [s:gray1, s:black] ],
    \   },
    \   'inactive': {
    \       'left': [ [s:gray2, s:black], [s:gray2, s:black] ],
    \       'right': [ [s:gray2, s:black], [s:gray2, s:black] ],
    \       'middle': [ [s:gray2, s:black] ],
    \   },
    \   'insert': {
    \       'left': [ [s:darkblue, s:white, 'bold'], [s:white, s:blue] ],
    \       'right': [ [s:darkblue, s:white], [s:white, s:blue] ],
    \       'middle': [ [s:gray2, s:darkblue] ],
    \   },
    \   'visual': {
    \       'left': [ [s:darkred, s:orange, 'bold'], [s:gray4, s:gray1] ],
    \   },
    \   'replace': {
    \       'left': [ [s:darkred, s:white, 'bold'], [s:white, s:red] ],
    \       'right': [ [s:darkred, s:white], [s:white, s:red] ],
    \       'middle': [ [s:gray2, s:darkred] ],
    \   },
    \   'terminal': {
    \       'left': [ [s:gray1, s:gray3, 'bold'], [s:gray3, s:gray1] ],
    \       'right': [ [s:black, s:black], [s:black, s:black] ],
    \       'middle': [ [s:black, s:black] ],
    \   }
    \ }

let g:lightline#colorscheme#custom#palette = lightline#colorscheme#flatten(s:p)
