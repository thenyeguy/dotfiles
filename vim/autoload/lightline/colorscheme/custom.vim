let s:black = ['#121212', 233]
let s:gray1 = ['#3c3836', 237]
let s:gray2 = ['#504945', 239]
let s:gray3 = ['#ebdbb2', 15]
let s:white = ['#ffffdf', 230]

let s:darkblue = ['#076678', 24]
let s:darkred = ['#9d0006', 88]
let s:blue = ['#83a598', 109]
let s:green = ['#b8bb26', 142]
let s:orange = ['#fe8019', 208]
let s:red = ['#fb4934', 167]

let s:p = {
    \   'normal': {
    \       'left': [ [s:gray1, s:green, 'bold'], [s:gray3, s:gray1] ],
    \       'right': [ [s:gray1, s:gray3], [s:gray3, s:gray1] ],
    \       'middle': [ [s:gray1, s:black] ],
    \   },
    \   'inactive': {
    \       'left': [ [s:gray2, s:black], [s:gray2, s:black] ],
    \       'right': [ [s:gray2, s:black], [s:gray2, s:black] ],
    \       'middle': [ [s:gray2, s:black] ],
    \   },
    \   'insert': {
    \       'left': [ [s:gray1, s:white, 'bold'], [s:black, s:blue] ],
    \       'right': [ [s:gray1, s:white], [s:black, s:blue] ],
    \       'middle': [ [s:gray2, s:darkblue] ],
    \   },
    \   'visual': {
    \       'left': [ [s:gray1, s:orange, 'bold'], [s:gray3, s:gray1] ],
    \   },
    \   'replace': {
    \       'left': [ [s:darkred, s:white, 'bold'], [s:black, s:red] ],
    \       'right': [ [s:darkred, s:white], [s:black, s:red] ],
    \       'middle': [ [s:gray2, s:darkred] ],
    \   },
    \   'terminal': {
    \       'left': [ [s:gray1, s:gray3, 'bold'], [s:gray3, s:gray1] ],
    \       'right': [ [s:black, s:black], [s:black, s:black] ],
    \       'middle': [ [s:black, s:black] ],
    \   }
    \ }

let g:lightline#colorscheme#custom#palette = lightline#colorscheme#flatten(s:p)
