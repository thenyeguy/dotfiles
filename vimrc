" ----------------------------- "
" CONFIGURE VIM EDITOR BEHAVIOR "
" ----------------------------- "

" Colors and Syntax Highlighting
syntax on
colorscheme wombat

" Console settings
set ttymouse=xterm2 "Fixes mouse drag in tmux
set title "Sets terminal title

" Editor displays
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
set wildmenu "Show cmd autocomplete on its own line
set mouse=a "Enable mouse use
set completeopt-=preview "Don't open buffer with suggestion
set wildignore+=*.pyc,*.pyo,*.o,*.obj,.git "ignore certain file types
set timeoutlen=1000 ttimeoutlen=0 "Fix escape delay
set directory=~/.vim/swp,~/tmp,.,/var/tmp,/tmp,. "swp file location

" Invisible characters
set list
set listchars=tab:»-,trail:·

" Code folding
set foldmethod=syntax
set foldlevelstart=99

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
set shiftwidth=4


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

" Copy/paste
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
nnoremap Y y$

" Clear search highlight
nnoremap <leader>n :nohlsearch<CR>
" Rewrap paragraph
nnoremap <leader>q gqip

" Mappings that fix my typos on save and quit
command W w
command Q q
command Wq wq
command WQ wq



" --------------------------------- "
" DEFINE FILETYPE SPECIFIC SETTINGS "
" --------------------------------- "

" Label come additional file extensions
augroup new_filetypes
    autocmd BufNewFile,BufRead *.c0 set filetype=c "Support for c0
    autocmd BufNewFile,BufRead *.h0 set filetype=c "Support for c0 header
    autocmd BufNewFile,BufRead *.pde set filetype=arduino "Arduino code
    autocmd BufNewFile,BufRead *.ino set filetype=arduino "Arduino code
    autocmd BufNewFile,BufRead *.sig set filetype=sml "SML sigs
    autocmd BufNewFile,BufRead *.sable set filetype=xml "SABLE markup
    autocmd BufNewFile,BufRead *.conf set filetype=cfg
    autocmd BufNewFile,BufRead *.md set filetype=markdown
augroup END

" Mappings for braces in languages that use them
augroup braces_macros
    autocmd FileType arduino,c,cpp,css,java,javascript,rust inoremap {<CR> {<CR>}<esc>ko
augroup END

" Rust - Override textwidth, set documentation highlighting
augroup filetype_rust
    autocmd FileType rust set textwidth=80
augroup END
highlight link rustCommentLineDoc Comment

" SML - change indent size
augroup filetype_sml
    autocmd FileType ml,sml set tabstop=2|softtabstop=2|shiftwidth=2
augroup END

" Makefiles - always use tabs
augroup filetype_makefile
    autocmd FileType make setlocal noexpandtab
augroup END

" Python - add additional keywords, override tabstop
augroup filetype_python
    autocmd FileType python,pyrex syn keyword pythonDecorator True None False self
    autocmd FileType python set tabstop=4|set shiftwidth=4
    autocmd FileType python set foldmethod=indent
augroup END

" Latex - use spellcheck, create live preview shortcut
augroup filetype_latex
    autocmd FileType tex set spell
    autocmd Filetype tex nmap <leader>lt :LLPStartPreview<CR>
augroup END

" Markdown - use spellcheck
augroup filetype_markdown
    autocmd FileType markdown set spell
augroup END

" Git commits - use spellcheck
augroup filetype_git
    autocmd FileType gitcommit set spell
augroup END

" Vim - make Plug a keyword
augroup filetype_vim
    autocmd FileType vim syn keyword Statement Plug
augroup END



" ---------------------------- "
" MANAGE OUR INSTALLED PLUGINS "
" ---------------------------- "

" Configure plugged
filetype off
call plug#begin('~/.vim/plugged')
let g:plug_window = 'belowright new'

Plug 'bling/vim-airline'
    let g:airline_powerline_fonts = 1
    let g:airline_theme = 'powerlineish'
    let g:airline#extensions#whitespace#enabled = 0
Plug 'blueyed/vim-diminactive'
Plug 'briancollins/vim-jst'
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
Plug 'gerw/vim-latex-suite', { 'for': 'tex' }
Plug 'Lokaltog/vim-easymotion'
    highlight link EasyMotionIncSearch String
Plug 'mhinz/vim-startify'
    let g:startify_change_to_vcs_root = 1
    let g:startify_bookmarks = [ '~/.dotfiles/vimrc', '~/.dotfiles/zshrc', '~/.dotfiles/tmux.conf' ]
Plug 'michaeljsmith/vim-indent-object'
Plug 'rking/ag.vim'
    let g:aghighlight = 1
Plug 'scrooloose/nerdcommenter'
    let g:NERDSpaceDelims = 1
Plug 'tpope/vim-fugitive'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer' }
    let g:ycm_filetype_blacklist = {
          \ 'tagbar':1, 'qf':1, 'notes':1, 'markdown':1, 'unite':1,
          \ 'text':1, 'vimwiki':1, 'pandoc':1, 'vim':1,
          \ 'gitconfig':1, 'gitcommit':1, 'gitrebase':1,
          \ 'tex':1
          \} " Ignore these filetypes
    let g:ycm_global_ycm_extra_conf = '~/.vim/ycm/ycm_extra_conf.py'
    highlight YcmErrorSection guifg=#f6f3e8 guibg=#3f0000 ctermfg=230 ctermbg=9
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
    let g:livepreview_previewer = 'open -a Preview'

call plug#end()
filetype plugin on
