" ---------------------------- "
" MANAGE OUR INSTALLED PLUGINS "
" ---------------------------- "

" Configure plugged
filetype off
call plug#begin('~/.vim/plugged')

Plug 'bling/vim-airline'
Plug 'blueyed/vim-diminactive'
Plug 'gerw/vim-latex-suite', { 'for': 'tex' }
Plug 'kien/ctrlp.vim'
Plug 'Lokaltog/vim-easymotion'
Plug 'mhinz/vim-startify'
Plug 'michaeljsmith/vim-indent-object'
Plug 'mileszs/ack.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

call plug#end()
filetype plugin on



" ----------------------------- "
" CONFIGURE VIM EDITOR BEHAVIOR "
" ----------------------------- "

" Colors and Syntax Highlighting
syntax on
colorscheme wombat

" Editor displays
set t_ut= "Fixes screen/tmux background color
set title "Sets terminal title
set number "Line number gutter
set ruler "Current line and column pos
set cursorline "Highlight current line
set showcmd "Info on current command
set laststatus=2 "Always show status bar w/ filename

" General editor behavior
set encoding=utf-8
set textwidth=80 "Autowrap at 80 chars
set scrolloff=7 "Start scrolling page a few lines from edge
set showmatch "Briefly flash matching braces when inserted
set splitbelow "Open split below by default
set mouse=a "Enable mouse use
set completeopt-=preview "Don't open buffer with suggestion
set wildignore+=*.pyc,*.pyo,*.o,*.obj,.git "ignore certain file types
set timeoutlen=1000 ttimeoutlen=0 "Fix escape delay
set directory=~/.vim/swp,~/tmp,/var/tmp,/tmp,. "swp file location

" Invisible characters
set list
set listchars=tab:»-,trail:·

" Code folding
set foldmethod=syntax
set nofoldenable

" Search/replace settings
set hlsearch "Highlights current search
set incsearch "Searches as you type
set ignorecase "Search ignores case
set smartcase "Doesn't ignore uppercase characters in search
set gdefault "Defaults to replacing ALL occurrences on a line

" Editor formatting stuff
filetype indent on "Makes editor manage indent semantically for code
set formatoptions+=j "Remove leading comment chars on join
set formatoptions+=r "Add comment leader on new line
set formatoptions+=n "Intelligently format lists

set linebreak " wrap at words
set backspace=indent,eol,start "Allows backspacing over tab and line breaks
set autoindent "Copies indent from previous line when starting a new one
set expandtab "Replace tabs with spaces

set tabstop=4     "Tab stops are 4 wide
set softtabstop=4
set shiftwidth=4



" ---------------------------------------- "
" ADD COMMANDS AND ALIASES FOR CONVENIENCE "
" ---------------------------------------- "

" Change leader to space
let g:mapleader=" "

" Swap jkhl and g+jkhl
noremap j gj
noremap gj j
noremap k gk
noremap gk k

" Shortcuts for split buffers
noremap <leader>j <C-W><C-J>
noremap <leader>k <C-W><C-K>
noremap <leader>l <C-W><C-L>
noremap <leader>h <C-W><C-H>

" Better shortcuts for fold all
nnoremap zO zr
nnoremap zC zm

" Don't deselect after indent
vnoremap < <gv
vnoremap > >gv

" Region expanding
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Copy/paste
vmap <Leader>y "+y
nmap <Leader>p "+p
nmap <Leader>P "+P

" Misc shortcuts
nnoremap <leader>n :nohlsearch<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :wq<CR>

" Mappings that fix my typos on save and quit
command W w
command Q q
command Wq wq
command WQ wq



" ----------------------- "
" CONFIGURE AUTOCMD GROUP "
" ----------------------- "

augroup vimrc
    autocmd!
augroup END


" ------------------------- "
" CONFIGURE BUNDLE SETTINGS "
" ------------------------- "

" Configure ack.vim
let g:ackhighlight = 1

" Configure airline
let g:airline_detect_whitespace = 0
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'

" Configure ctrlp
let g:ctrlp_max_height = 30            " show more files by default
let g:ctrlp_reuse_window  = 'startify' " closes vim extension startify
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = {
    \ 'types': {
        \ 1: ['.git/', 'git ls-files --cached --others --exclude-standard %s']
    \ },
\ }

" Configure Easy Motion
highlight link EasyMotionIncSearch String

" Configure NERD Commenter
let g:NERDSpaceDelims = 1

" Configure startify
let g:startify_change_to_vcs_root = 1

" Configure YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_filetype_blacklist = {
      \ 'tagbar':1, 'qf':1, 'notes':1, 'markdown':1, 'unite':1,
      \ 'text':1, 'vimwiki':1, 'pandoc':1, 'vim':1,
      \ 'gitconfig':1, 'gitcommit':1, 'gitrebase':1,
      \ 'tex':1
      \}                              " Ignore these filetypes
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm/ycm_extra_conf.py'
highlight YcmErrorSection guifg=#f6f3e8 guibg=#3f0000 ctermfg=230 ctermbg=9

" Configure vim live preview
let g:livepreview_previewer = 'open -a Preview'
autocmd vimrc Filetype tex nmap <leader>lt :LLPStartPreview<CR>



" --------------------------------- "
" DEFINE FILETYPE SPECIFIC SETTINGS "
" --------------------------------- "

" Add filetype support
autocmd vimrc BufNewFile,BufRead *.c0 set filetype=c "Support for c0
autocmd vimrc BufNewFile,BufRead *.h0 set filetype=c "Support for c0 header
autocmd vimrc BufNewFile,BufRead *.pde set filetype=arduino "Arduino code
autocmd vimrc BufNewFile,BufRead *.ino set filetype=arduino "Arduino code
autocmd vimrc BufNewFile,BufRead *.sig set filetype=sml "SML sigs
autocmd vimrc BufNewFile,BufRead *.sable set filetype=xml "SABLE markup
autocmd vimrc BufNewFile,BufRead *.conf set filetype=cfg

" Mappings for braces in languages that use them
autocmd vimrc FileType arduino,c,cpp,css,java,javascript,rust inoremap {<CR> {<CR>}<esc>ko

" Rust - Override textwidth, set documentation highlighting
autocmd vimrc FileType rust set textwidth=80
highlight link rustCommentLineDoc Comment

" SML - change indent size
autocmd vimrc FileType ml,sml set tabstop=2|softtabstop=2|shiftwidth=2

" Makefiles - always use tabs
autocmd vimrc FileType make setlocal noexpandtab

" Python - add additional keywords, override tabstop
autocmd vimrc FileType python,pyrex syn keyword pythonDecorator True None False self
autocmd vimrc FileType python set tabstop=4|set shiftwidth=4

" Latex - use spellcheck
autocmd vimrc FileType tex set spell

" Git commits - use spellcheck
autocmd vimrc FileType gitcommit set spell



" ------------------------------- "
" SOURCE LOCAL VIMRC IF IT EXISTS "
" ------------------------------- "

if filereadable(glob("~/.vimrc.local"))
    source ~/.vimrc.local
endif
