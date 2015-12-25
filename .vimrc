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
Plug 'altercation/vim-colors-solarized'                 " Best colors ever
Plug 'bling/vim-airline'                                " Status line
Plug 'ctrlpvim/ctrlp.vim'                               " Fuzzy finder
Plug 'easymotion/vim-easymotion'                        " Movements
Plug 'jlanzarotta/bufexplorer'                          " Better buffers
Plug 'andschwa/vim-ledger', { 'branch': 'fix-entry' }   " Ledger
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }      " Edits graph
Plug 'ntpeters/vim-better-whitespace'                   " Whitespace
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }  " File explorer
Plug 'scrooloose/nerdcommenter'                         " Commenter
Plug 'rking/ag.vim', { 'on': 'Ag' }                     " The Silver Searcher
Plug 'scrooloose/syntastic'                             " Syntax checker
Plug 'tpope/vim-fugitive'                               " Git interface
Plug 'tpope/vim-sensible'                               " Sensible defaults
Plug 'tpope/vim-sleuth'                                 " Adaptive indentation
Plug 'tpope/vim-surround'                               " Surrounding
call plug#end()

""" Plugin configurations

set background=dark
:silent! colorscheme solarized

if has("persistent_undo")
  set undodir=~/.vim/undodir/
  set undofile
endif

""" Other configurations

let mapleader = " "

set title       " terminal title
set hidden      " multiple buffers
set ignorecase  " ignore case in searches
set smartcase   " match case once specified
set smarttab    " delete tabs
set visualbell  " no sound

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

" Reload vimrc on save
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Load local configurations if available
:silent! source ~/.vim/local.vim
