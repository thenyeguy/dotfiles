" ------------------------- "
" CONFIGURE EDITOR BEHAVIOR "
" ------------------------- "

" Console settings
set title "Sets terminal title
set timeoutlen=1000 ttimeoutlen=0 "Fix escape delay

" Editor displays
colorscheme wombat "Set colors
set cursorline "Highlight current line
set display=lastline "When last line wraps off screen, show as much as possible
set laststatus=2 "Always show status bar w/ filename
set lazyredraw "Don't redraw while executing commands
set noshowmode "Don't show mode in command line
set number "Show line number gutter

" General editor behavior
syntax on "Parse code syntax
set backspace=indent,eol,start "Allows backspacing over tab and line breaks
set completeopt=menuone "Only show menu for completion (even for one item)
set directory=~/.vim/swp,~/tmp,/var/tmp,/tmp,. "swp file location
set encoding=utf-8 "Use utf-8 for text encoding
set modeline "Enable setting options in file comments
set mouse=a "Enable mouse use
set scrolloff=7 "Start scrolling page a few lines from edge
set showmatch "Briefly flash matching braces when inserted
set splitbelow "Open split below by default
set wildignore+=*.pyc,*.pyo,*.o,*.obj,.git "ignore certain file types
set wildmenu "Enable tab-complete menu

" Editor formatting
set autoindent "Copies indent from previous line
set expandtab "Replace tabs with spaces
set shiftwidth=4 "Tab stops are 4 wide
set tabstop=4

set formatoptions+=j "Remove leading comment chars on join
set formatoptions+=n "Intelligently format lists
set formatoptions+=r "Add comment leader on new line
set formatlistpat=^\\s*[0-9*]\\+[\\]:.)}\\t\ ]\\s* "Configure list pattern
set nojoinspaces "Do not put two spaces after punctuation on join

" Search/replace settings.
set gdefault "Defaults to replacing ALL occurrences on a line
set hlsearch "Highlights current search
set ignorecase "Search ignores case
set incsearch "Searches as you type
set smartcase "Doesn't ignore uppercase characters in search

" Linewrapping
set breakindent "Indent to the same level
set linebreak "Wrap at word boundaries
set showbreak=»- "Prefix wrapped text with this
set textwidth=80 "Autowrap at 80 chars

" Code folding
set nofoldenable "Start with folds disabled
set foldmethod=syntax "Use code syntax to fold

" Highlight invisible characters: tabs and trailing whitespace
set list
set listchars=tab:»-,trail:·

" Use persistent undo
set undodir=$HOME/.vim/undo
set undofile



" ---------------------------------------- "
" ADD COMMANDS AND ALIASES FOR CONVENIENCE "
" ---------------------------------------- "

" Change leader to space
let g:mapleader=" "

" Use semicolon for commands
noremap ; :

" Swap jkhl and g+jkhl
noremap j gj
noremap gj j
noremap k gk
noremap gk k

" Remap navigation keys
noremap <Home> gg
noremap <End> G
noremap <PageUp> <C-u>
noremap <PageDown> <C-d>

" Shortcuts for split buffers
noremap <C-j> <C-W><C-J>
noremap <C-k> <C-W><C-K>
noremap <C-l> <C-W><C-L>
noremap <C-h> <C-W><C-H>

" Remap shortcuts
nnoremap <C-p> <C-o>
nnoremap <C-n> <C-i>

" Don't deselect after indent
vnoremap < <gv
vnoremap > >gv

" Improve copy/paste, primarily clipboard interaction
nnoremap Y y$
noremap  <leader>y "+y
nnoremap <leader>Y "+y$
nnoremap <leader>p :put +<CR>
nnoremap <leader>P :put! +<CR>
vnoremap <leader>p "+p

" Clear search highlight
nnoremap <leader>n :nohlsearch<CR>

" Rewrap paragraph
nnoremap <leader>q gqip

" Auto expand curly braces
inoremap {<CR> {<CR>}<esc>ko

" Mappings that fix my typos on save and quit
command W w
command Q q
command Wq wq
command WQ wq

" Shortcut for closing all open buffers.
command CloseAll %bd | Startify



" ----------------------------- "
" HANDLE MERGE CONFLICT MARKERS "
" ----------------------------- "
match Todo '\v^(\<|\=|\||\>){7}([^=].+)?$'
nnoremap <silent> ]c /\v^(\<){7}([^=].+)?$<CR>
nnoremap <silent> [c ?\v^(\<){7}([^=].+)\?$<CR>


" ---------------------------- "
" MANAGE OUR INSTALLED PLUGINS "
" ---------------------------- "

" Configure plugged
call plug#begin('~/.vim/plugged')
let g:plug_window = 'belowright new'

Plug 'blueyed/vim-diminactive'
Plug 'google/vim-searchindex'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
    let g:fzf_colors =
        \ { 'fg':      ['fg', 'Normal'],
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
        \   'header':  ['fg', 'Comment'] }
    let g:fzf_layout = { 'down': '~50%' }
    nnoremap <c-o> :Files<CR>
Plug 'Lokaltog/vim-easymotion'
Plug 'mhinz/vim-startify'
    let g:startify_change_to_vcs_root = 1
    let g:startify_custom_header = []
    let g:startify_enable_unsafe = 1
    let g:startify_list_order = [
          \   ['  Most recently used files in the current directory:'], 'dir',
          \   ['  Most recently used files:'], 'files',
          \ ]
Plug 'michaeljsmith/vim-indent-object'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --racer-completer' }
    let g:ycm_filetype_blacklist = {
          \ 'tagbar':1, 'qf':1, 'notes':1, 'markdown':1, 'unite':1,
          \ 'text':1, 'vimwiki':1, 'pandoc':1, 'vim':1,
          \ 'gitconfig':1, 'gitcommit':1, 'gitrebase':1,
          \ 'tex':1
          \} " Ignore these filetypes
    let g:ycm_global_ycm_extra_conf = '~/.vim/ycm/ycm_extra_conf.py'
    let g:ycm_rust_src_path = '/usr/local/rust/rustc-1.5.0/src'
    nnoremap <leader>g :YcmCompleter GoTo<CR>
    highlight YcmErrorSection guifg=#f6f3e8 guibg=#3f0000 ctermfg=230 ctermbg=9

call plug#end()
