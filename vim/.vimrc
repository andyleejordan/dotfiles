" Andrew Schwartzmeyer's vimrc file.

" This must be first, because it changes other options as a side effect.
set nocompatible

" Download vim-plug if not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

""" Plugins
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'                           " Git hunks
Plug 'andschwa/vim-colors-solarized'                    " Best colors ever
Plug 'ctrlpvim/ctrlp.vim'                               " Fuzzy finder
Plug 'easymotion/vim-easymotion'                        " Movements
Plug 'elzr/vim-json'                                    " Better JSON
Plug 'ledger/vim-ledger'                                " Ledger
Plug 'majutsushi/tagbar'                                " Tagbar
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }      " Edits graph
Plug 'ntpeters/vim-better-whitespace'                   " Whitespace
Plug 'PProvost/vim-ps1'                                 " PowerShell
Plug 'rking/ag.vim', { 'on': 'Ag' }                     " The Silver Searcher
Plug 'scrooloose/syntastic'                             " Syntax checker
Plug 'tpope/vim-commentary'                             " Comments
Plug 'tpope/vim-eunuch'                                 " UNIX commands
Plug 'tpope/vim-fugitive'                               " Git interface
Plug 'tpope/vim-repeat'                                 " Repeat for plugins
Plug 'tpope/vim-rsi'                                    " Readline bindings
Plug 'tpope/vim-scriptease'                             " VimL REPL
Plug 'tpope/vim-sensible'                               " Sensible defaults
Plug 'tpope/vim-sleuth'                                 " Adaptive indentation
Plug 'tpope/vim-surround'                               " Surrounding
Plug 'tpope/vim-unimpaired'                             " ][ mappings
Plug 'tpope/vim-vinegar'                                " File explorer
Plug 'vim-airline/vim-airline'                          " Status line
call plug#end()

""" Plugin configurations
" appearance
silent! colorscheme solarized
set background=dark
let g:gitgutter_override_sign_column_highlight = 0

" cached fuzzy finding
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_clear_cache_on_exit = 0

" just use :StripWhitespace
let g:better_whitespace_enabled = 0

""" Other configurations
set hidden      " multiple buffers
set ignorecase  " ignore case in searches
set smartcase   " match case once specified
set smarttab    " delete tabs
set spell       " always spell check
set visualbell  " no sound
set lazyredraw  " better performance
set linebreak   " wrap after words

if has("persistent_undo")
  set undodir=~/.vim/undodir/
  silent call system('mkdir -p ' . &undodir)
  set undofile
endif

if has('mouse')
  set mouse=a
endif

""" Bindings
let mapleader = " "

""" Auto-commands
" recognize all Markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['c', 'cpp', 'csharp=cs', 'bash=sh', 'json']

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Load local configurations if available
silent! source ~/.vim/local.vim
