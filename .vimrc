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
Plug 'bling/vim-airline'                                " Status line
Plug 'ctrlpvim/ctrlp.vim'                               " Fuzzy finder
Plug 'easymotion/vim-easymotion'                        " Movements
Plug 'jlanzarotta/bufexplorer'                          " Better buffers
Plug 'andschwa/vim-ledger', { 'branch': 'fix-entry' }   " Ledger
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }      " Edits graph
Plug 'ntpeters/vim-better-whitespace'                   " Whitespace
Plug 'rking/ag.vim', { 'on': 'Ag' }                     " The Silver Searcher
Plug 'scrooloose/syntastic'                             " Syntax checker
Plug 'tpope/vim-commentary'                             " Comments
Plug 'tpope/vim-fugitive'                               " Git interface
Plug 'tpope/vim-sensible'                               " Sensible defaults
Plug 'tpope/vim-sleuth'                                 " Adaptive indentation
Plug 'tpope/vim-surround'                               " Surrounding
Plug 'tpope/vim-vinegar'                                " File explorer
call plug#end()

""" Plugin configurations
" appearance
silent! colorscheme solarized
set background=dark
let g:gitgutter_override_sign_column_highlight = 0

" Use ag for CtrlP searching if available
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif

""" Other configurations
if has("persistent_undo")
  set undodir=~/.vim/undodir/
  silent call system('mkdir -p ' . &undodir)
  set undofile
endif

let mapleader = " "

set title       " terminal title
set hidden      " multiple buffers
set ignorecase  " ignore case in searches
set smartcase   " match case once specified
set smarttab    " delete tabs
set visualbell  " no sound
set lazyredraw  " better performance

" bindings
nnoremap <silent> <Leader>ev :split $MYVIMRC<CR>

" spell check commits
autocmd FileType gitcommit setlocal spell

" Don't use Ex mode, use Q for formatting
map Q gq

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Load local configurations if available
silent! source ~/.vim/local.vim
