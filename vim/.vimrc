" Andrew Schwartzmeyer's vimrc file.

" This must be first, because it changes other options as a side effect.
set nocompatible

" Download vim-plug if not already installed
if has('unix')
  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
  endif
elseif has('win32')
  if empty(glob('~/vimfiles/autoload/plug.vim'))
    echom "Install vim-plug!"
  endif
endif

""" Plugins
call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'                           " Git hunks
Plug 'andschwa/vim-colors-solarized'                    " Best colors ever
Plug 'easymotion/vim-easymotion'                        " Movements
Plug 'EinfachToll/DidYouMean'                           " File guessing
Plug 'elzr/vim-json'                                    " Better JSON
Plug 'fatih/vim-go'                                     " Go lang support
Plug 'ledger/vim-ledger'                                " Ledger
Plug 'majutsushi/tagbar'                                " Tagbar
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }      " Edits graph
Plug 'mhinz/vim-grepper'                                " Better :grep
Plug 'ntpeters/vim-better-whitespace'                   " Whitespace
Plug 'pearofducks/ansible-vim'                          " Ansible
Plug 'PProvost/vim-ps1'                                 " PowerShell
Plug 'rizzatti/dash.vim'                                " Dash integration
Plug 'rust-lang/rust.vim'                               " Rust
Plug 'scrooloose/syntastic'                             " Syntax checker
Plug 'tmux-plugins/vim-tmux'
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
Plug 'vim-airline/vim-airline-themes'                   " Status line themes
call plug#end()

""" Plugin configurations
" GUI
if has('gui_running')
  if has('gui_gtk')
    set guifont=Hack\ 11
  elseif has('gui_win32')
    set guifont=Hack:h11:cANSI
  endif
endif

" appearance
silent! colorscheme solarized
set background=dark
let g:gitgutter_override_sign_column_highlight = 0

" disable concealing in JSON
let g:vim_json_syntax_conceal = 0

" just use :StripWhitespace
let g:better_whitespace_enabled = 0

" use ripgrep first
let g:grepper = {'tools': ['rg', 'ag', 'git', 'grep']}

" recognize all Markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
let g:markdown_fenced_languages = ['c', 'cpp', 'csharp=cs', 'bash=sh', 'json']

""" Other configurations
set hidden      " multiple buffers
set ignorecase  " ignore case in searches
set linebreak   " wrap after words
set smartcase   " match case once specified
set spell       " always spell check
set visualbell  " no sound
set autowrite   " write files when leaving

" configure wildmenu tab completion
set wildmode=list:longest,full
set wildignorecase

if has('persistent_undo')
  set undodir=~/.vim/undodir/
  silent call system('mkdir -p ' . &undodir)
  set undofile
endif

if has('mouse')
  set mouse=a
endif

let mapleader = " "

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

" Load local configurations if available
silent! source ~/.vim/local.vim
