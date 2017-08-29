" ------------------------- "
" CONFIGURE EDITOR BEHAVIOR "
" ------------------------- "

" Console settings
set title "Sets terminal title
set ttymouse=xterm2 "Fixes mouse drag in tmux
set timeoutlen=1000 ttimeoutlen=0 "Fix escape delay

" Editor displays
colorscheme wombat "Set colors
set cursorline "Highlight current line
set display=lastline "When last line wraps off screen, show as much as possible
set laststatus=2 "Always show status bar w/ filename
set lazyredraw "Don't redraw while executing commands
set number "Show line number gutter
set ruler "Show current line and column
set showcmd "Show current command being entered

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

" Shortcuts for split buffers
noremap <C-j> <C-W><C-J>
noremap <C-k> <C-W><C-K>
noremap <C-l> <C-W><C-L>
noremap <C-h> <C-W><C-H>

" Jumplist shortcuts
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
Plug 'briancollins/vim-jst'
Plug 'cespare/vim-toml'
Plug 'Chiel92/vim-autoformat'
    noremap <leader>= :Autoformat<CR>
Plug 'ctrlpvim/ctrlp.vim'
    let g:ctrlp_map = '<c-o>'
    let g:ctrlp_max_height = 30 " show more files
    let g:ctrlp_reuse_window  = 'startify' " closes vim extension startify
    let g:ctrlp_working_path_mode = 'ra' " use vcs root or cwd
    let g:ctrlp_user_command = {
        \ 'types': {
            \ 1: ['.git/', 'git ls-files --cached --others --exclude-standard %s']
        \ },
    \ } " build index with git-ls-files in git repos (faster)
Plug 'dag/vim-fish'
Plug 'fidian/hexmode'
Plug 'gerw/vim-latex-suite', { 'for': 'tex' }
Plug 'google/vim-searchindex'
Plug 'leafgarland/typescript-vim'
Plug 'Lokaltog/vim-easymotion'
    highlight link EasyMotionIncSearch String
Plug 'mhinz/vim-startify'
    let g:startify_change_to_vcs_root = 1
    let g:startify_custom_header = []
    let g:startify_list_order = [
          \   ['  Most recently used files in the current directory:'], 'dir',
          \   ['  Most recently used files:'], 'files',
          \   ['  My bookmarks:'], 'bookmarks'
          \ ]
    let g:startify_bookmarks = [ '~/.dotfiles/vimrc', '~/.dotfiles/zshrc', '~/.dotfiles/tmux.conf' ]
Plug 'michaeljsmith/vim-indent-object'
Plug 'rking/ag.vim'
    let g:ag_highlight = 1
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'scrooloose/nerdcommenter'
    let g:NERDSpaceDelims = 1
    highlight link cCustomClass Constant
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-liquid'
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
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
    let g:airline_powerline_fonts = 1
    let g:airline_symbols = {}
    let g:airline_symbols.maxlinenr = ''
    let g:airline_theme = 'powerlineish'
    let g:airline#extensions#whitespace#enabled = 0

call plug#end()
