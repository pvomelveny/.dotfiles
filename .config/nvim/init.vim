" -------
" Plugins
" -------
call plug#begin()

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/goyo.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-surround'
" --- Tmux
Plug 'christoomey/vim-tmux-navigator'
" --- Searching
Plug 'Shougo/vimproc.vim', {'do': 'make'} | Plug 'Shougo/unite.vim'
Plug 'rking/ag.vim'
" --- Git
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
" --- Python
Plug 'hdima/python-syntax'
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'cjrh/vim-conda'
" --- Clojure
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'venantius/vim-cljfmt'
Plug 'kien/rainbow_parentheses.vim'
" --- Markdown/Text Editing
Plug 'gabrielelana/vim-markdown'
Plug 'reedes/vim-pencil', {'for': ['mkd', 'markdown', 'text', 'txt']}
" --- LaTeX
Plug 'lervag/vimtex'
" --- General Language Plugins
Plug 'Valloric/YouCompleteMe', {'do': './install.py --all'}
Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()
"
" Personal Settings
"

" Color Scheme
set t_Co=256
colorscheme pink_theme
syntax on
" Fonts
let g:airline_powerline_fonts=1
let g:airline_theme='molokai'

" Set Leader key to <Space>
map <Space> <Leader>
set showcmd

" Set Line numbers and relative line
set number
set relativenumber

" Sane Split Navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Add colored column at 80 chars
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" Sensible Tabbing
set tabstop=4
set shiftwidth=4
set expandtab

" Reasonable default assumption
set encoding=utf-8
set fileformat=unix
set textwidth=0
set wrapmargin=0

" Polygot Ignore Languages
let g:polyglot_disabled=['python', 'markdown', 'latex', 'mkd', 'tex', 'text']

" Python Settings
let g:python_host_prog='/usr/local/bin/python2'
let g:conda_startup_msg_suppress=1
let python_highlight_all=1
let g:ycm_python_binary_path='python'
let g:SimpylFold_fold_import=0
let g:SimpylFold_fold_docstring=0

" Clojure
au Filetype clojure nmap <C-C><C-K> :Require<cr>

" Markdown/LaTex/Text Settings
let g:tex_flavor='latex'

" Web Development Settings
" au BufNewFile,BufRead *.js, *.html, *.css, *.jsx
"            \ set tabstop=2
"            \ set softtabstop=2
"            \ set shiftwidth=2

" Syntatic Checkers
let g:syntastic_python_checkers = ['flake8']

" Close autocomplete window after selection
let g:ycm_autoclose_preview_window_after_completion=1
" <Leader>g jumps to definition of decleration of variable
map <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


" Unite File Searching
let g:unite_source_history_yank_enable = 1
try
    let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
nnoremap <Leader><Space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <Leader>r <Plug>(unite_restart)

" Project Tree search
nnoremap <Leader>/ :Ag 
