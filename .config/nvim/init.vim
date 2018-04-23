" -----------------------------
" -----------------------
"  Plugins Begin
" ----------------------
" -----------------------------
call plug#begin()

" -----------------------------
"  General Plugins
" -----------------------------
" --- Colorscheme/Aesthetics
Plug 'flazz/vim-colorschemes'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-startify'
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" --- File Formatting & Tools
Plug 'editorconfig/editorconfig-vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Yggdroot/indentLine'
Plug 'ervandew/supertab'

" --- Vim Improvements
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'

" --- NeoVim Improvements
Plug 'neovim/node-host'

" --- Views
Plug 'junegunn/goyo.vim'

" --- Tmux
Plug 'christoomey/vim-tmux-navigator'

" --- Slime
Plug 'jpalardy/vim-slime'

" --- Git
Plug 'tpope/vim-fugitive'
Plug 'gregsexton/gitv'
Plug 'airblade/vim-gitgutter'

" --- File Trees and Searching
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'Shougo/vimproc.vim', {'do': 'make'} | Plug 'Shougo/unite.vim'
Plug 'rking/ag.vim'

" --- Programming Plugins
Plug 'Valloric/YouCompleteMe', {'do': './install.py --all'}
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdcommenter'

" --- Snippits
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" -----------------------------
"  Programming Languages
" -----------------------------

" --- Polyglot for general/quite huge language coverage
Plug 'sheerun/vim-polyglot'

" --- Clojure
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
Plug 'guns/vim-sexp' | Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-clojure-highlight'
Plug 'snoe/nvim-parinfer.js'

" --- CoffeeScript
Plug 'kchmck/vim-coffee-script'

" --- Erlang
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-compiler'

" --- Go
Plug 'fatih/vim-go'

" --- Haskell
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'
Plug 'eagletmt/ghcmod-vim'

" --- Java/Scala
Plug 'ensime/ensime-vim'

" --- JavaScript

" --- Julia
Plug 'JuliaEditorSupport/julia-vim'

" --- LaTeX
Plug 'lervag/vimtex'

" --- Markdown
Plug 'gabrielelana/vim-markdown'
Plug 'reedes/vim-pencil', {'for': ['mkd', 'markdown', 'text', 'txt']}

" --- Python
Plug 'hdima/python-syntax'
Plug 'vim-scripts/indentpython.vim'
Plug 'cjrh/vim-conda'

" --- Scala
Plug 'derekwyatt/vim-scala'

" -------------------------------------
"  Things that need to go at the end
" -------------------------------------

" --- Cute little text symbols
Plug 'ryanoasis/vim-devicons'

call plug#end()
" -----------------------------
" -----------------------
"  Plugins End
" ----------------------
" -----------------------------

" -----------------------------
" ---------------------
"  Global Vim Settings
" ---------------------
" -----------------------------

" ----------------------
"  a e s t h e t i c
" ----------------------
" --- Use Truecolors
set termguicolors
set t_Co=256
" --- Color Theme
set background=light
colorscheme gruvbox
syntax on
" --- Airline Theme
let g:airline_powerline_fonts=1
let g:airline_theme='gruvbox'
" --- Line Numbers in Gutter
set number
set relativenumber
" --- Add Colored Column at 100 chars
if (exists('+colorcolumn'))
    set colorcolumn=100
    highlight ColorColumn ctermbg=4
endif
" --- Rainbow Brackets!!
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" ----------------------
"  General Key Remaps
" ----------------------
" --- Set Leader key to <Space>
map <Space> <Leader>
set showcmd
" --- Sane Split Navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" ------------------------------
"  File Formatting - General
" ------------------------------
" --- Sensible Tabbing
"  Let EditorConfig sort theses things out
"set tabstop=4
"set shiftwidth=4
"set expandtab
" --- Reasonable File Defaults
set encoding=utf-8
set fileformat=unix
set textwidth=0
set wrapmargin=0
" --- Better Swap File Placement
set backup
set swapfile
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp

" -----------------------------
" ---------------------
"  Plugin Settings
" ---------------------
" -----------------------------

" --------------------
"  Vim-Slime
" --------------------
let g:slime_target="tmux"
if !empty($TMUX)
  let g:slime_default_config = {"socket_name": split($TMUX, ",")[0], "target_pane": ":.2"}
endif
let g:slime_python_ipython=1

" -------------------
"  EditorConfig
" -------------------
" Play nice with fugative
let g:EditorConfig_core_mode='external_command'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" --------------------
"  delimitMate
" --------------------
" Auto Backet Completion
let delimitMate_expand_cr = 1

" -----------------------
"  UltiSnips
" -----------------------
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" -----------------------
"  YouCompleteMe
" -----------------------
" make YCM compatible with UltiSnips (using supertab)
" http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" Close autocomplete window after selection
let g:ycm_autoclose_preview_window_after_completion=1
" <Leader>g jumps to definition of decleration of variable
map <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" -----------------------------
"  NERDTree Config Options
" -----------------------------
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
autocmd bufenter * if (winnr("$") == 1
                                \ && exists("b:NERDTreeType")
                                \ && b:NERDTreeType == "primary") | q | endif

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

" -----------------------
"  Unite
" -----------------------
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

" ------------------------------------------
" ----------------------------
"  Language Plugin Settings
" -----------------------------
" ------------------------------------------

" --- Specify Linters
let g:syntastic_python_checkers = ['flake8']

" --- Polygot Ignore Languages
let g:polyglot_disabled=['python',
                       \ 'markdown', 'latex', 'mkd', 'tex', 'text']

" ----------------
"  Clojure
" ----------------
au Filetype clojure nmap <C-C><C-K> :Require<cr>
" Vim-Sexp play nice with parinfer
let g:sexp_enable_insert_mode_mappings = 0
" Set parinfer mode - Default: 'indent'
let g:parinfer_mode='indent'

" ---------------------
"  LaTeX
" ---------------------
let g:tex_flavor='latex'

" --------------------
"  Python
" --------------------
let g:python_host_prog='/usr/local/bin/python2'
let g:conda_startup_msg_suppress=1
let python_highlight_all=1
let g:ycm_python_binary_path='python'
let g:SimpylFold_fold_import=0
let g:SimpylFold_fold_docstring=0

