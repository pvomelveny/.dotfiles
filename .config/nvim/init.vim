" -------
" Plugins
" -------
call plug#begin()

" --- Colorscheme/Aesthetics
Plug 'flazz/vim-colorschemes'
Plug 'mhinz/vim-startify'
" --- General Vim Plugins
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-dispatch'
Plug 'junegunn/goyo.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'ervandew/supertab'
" --- Snippits
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" --- Tmux
Plug 'christoomey/vim-tmux-navigator'
" --- File Trees and Searching
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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
" --- Java/Scala
Plug 'ensime/ensime-vim'
Plug 'derekwyatt/vim-scala'
" --- Markdown/Text Editing
Plug 'gabrielelana/vim-markdown'
Plug 'reedes/vim-pencil', {'for': ['mkd', 'markdown', 'text', 'txt']}
" --- LaTeX
Plug 'lervag/vimtex'
" --- General Language Plugins
Plug 'Valloric/YouCompleteMe', {'do': './install.py --all'}
Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" --- Cute little text symbols
Plug 'ryanoasis/vim-devicons'

call plug#end()
"
" Personal Settings
"

" Color Scheme
set t_Co=256
colorscheme cobalt2
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
    highlight ColorColumn ctermbg=4
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

" Tab Characters
let g:indentLine_char='¦'
let g:indentLine_color_term=239

" Auto Backet Completion
let delimitMate_expand_cr = 1

" Rainbow Brackets!!
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Polygot Ignore Languages
let g:polyglot_disabled=['python', 'markdown', 'latex', 'mkd', 'tex', 'text']

" make YCM compatible with UltiSnips (using supertab)
" http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

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

" Syntatic Checkers
let g:syntastic_python_checkers = ['flake8']

" Close autocomplete window after selection
let g:ycm_autoclose_preview_window_after_completion=1
" <Leader>g jumps to definition of decleration of variable
map <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" NERDTree Config Options
" Open by default when nothing passed to vim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | Startify
                                                       \ | NERDTree
                                                       \ | wincmd w
                                                       \ | endif

" Open Tree with <Leader>f
nnoremap <Leader>f :NERDTreeToggle<Enter>
" Open Tree on file itself
nnoremap <silent> <Leader>v :NERDTreeFind<CR>
" Quit the tree when you open a file - True {1} or False {0}
let NERDTreeQuitOnOpen = 0
" Close a tab if Tree is the only remaining window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Delete Buffer if you delete file in Tree
let NERDTreeAutoDeleteBuffer = 1
" NERDTree Ignore Cases
let NERDTreeIgnore=['.DS_Store', '.git']
" NERDTree Cusomization
let NERDTreeWinPos='right'
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
let NERDTreeHighlightCursorline=1
let NERDTreeCaseSensitiveSort=0
" Clean up interface looks
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

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
