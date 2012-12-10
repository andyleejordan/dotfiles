""" Andrew Schwartzmeyer's VIM configurations

""" Pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

""" General
set history=700

filetype plugin on
filetype indent on
    " OmniCompletion
set ofu=syntaxcomplete#Complete

set number
set mouse=a

set autoread

""" Map leader
let mapleader = ","
let g:mapleader = ","

""" Interface
set so=7

set wildmenu
set wildignore=*.o,*~,*.pyc,.git\*,.hg\*,.svn\*

set ruler

set cmdheight=2
set hid

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set showmatch
set mat=2

set foldcolumn=1

""" Searching
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic

    " Visual mode search
vnoremap <silent> * :call VisualSelection('f', '')<CR>

""" Performance
set lazyredraw
set nobackup
set nowb
set noswapfile

""" Colors
syntax enable

set t_Co=16
set background=dark
colorscheme solarized

set encoding=utf8
set ffs=unix

""" Formatting
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4

set lbr " linebreak
set tw=80

set ai " auto indent
set si " smart indent
set wrap " wrap lines

    " Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i
inoremap $t <><esc>i

""" Navigation
map j gj
map k gk
map 0 ^
map - $

    " Map noh
map <silent> <leader><cr> :noh<cr>

    " Better pane switching
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

    " Better tab management
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>t<leader> :tabnext
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

map <leader>cd :cd %:p:h<cr>:pwd<cr>

    " Buffer switching behavior
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

    " Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

   " MBE
let g:miniBufExplMapWindowNavVim = 1 
let g:miniBufExplMapWindowNavArrows = 1 
let g:miniBufExplMapCTabSwitchBufs = 1 
let g:miniBufExplModSelTarget = 1 

""" Return to last edit position
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
set viminfo^=%

""" Persistent undo
try
    set undodir=~/.vim/undodir
    set undofile
catch
endtry

""" Status line
set laststatus=2
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

""" Delete trailing whitespace on close
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

""" Toggle paste mode
map <leader>p :setlocal paste!<cr>

""" Spell checking
map <leader>ss :setlocal spell!<cr>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

""" Nerd Tree
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark 
map <leader>nf :NERDTreeFind<cr>

""" MRU
let MRU_Max_Entries = 100
map <leader>f :MRU<CR>

""" LaTeX workaround
let g:tex_flavor='latex'

""" Helper functions
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.' . a:extra_filter)
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction
