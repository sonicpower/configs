" General Config
set nocompatible
syntax on
set nu

" Map leader key to ',' for Command-T and nerdcommenter
let mapleader = ','

" use F2 to toggle paste mode
set pastetoggle=<F2>

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" " Keep undo history across sessions, by storing in file.
" " Only works all the time.
let s:vim_cache = expand('$HOME/.vim/backups')
if filewritable(s:vim_cache) == 0 && exists("*mkdir")
    call mkdir(s:vim_cache, "p", 0700)
endif
if v:version >= 703
  set undodir=~/.vim/backups
  set undofile
endif

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype indent on

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

" ================ Folds ============================
"
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

" ================ Scrolling ========================
"
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Set horizontal and Vertical Line
au WinLeave * set nocursorline nocursorcolumn
au WinEnter * set cursorline cursorcolumn
set cursorline cursorcolumn

" Theme Solarized
execute pathogen#infect()
set background=dark
colorscheme solarized

" NerdTree config
let g:NERDTreeDirArrows=0
nmap <leader>ne :NERDTreeToggle<cr>

" make backspace work like most other apps
set backspace=2

" ================ Relative Line Number =================
nnoremap <silent><leader>r :set relativenumber!<cr> " Toggle relative line number

" use absolute number in insert mode
autocmd InsertEnter * :set norelativenumber | set number
autocmd InsertLeave * :set relativenumber

set relativenumber " use relativenumber by default

" strip whitespace on save
autocmd BufWritePre * StripWhitespace

" Command-T
let g:CommandTMaxHeight = 30
let g:CommandTMaxFiles = 500000
let g:CommandTInputDebounce = 200
let g:CommandTFileScanner = 'watchman'
let g:CommandTMaxCachedDirectories = 10
let g:CommandTSmartCase = 1

" automatically set/unset Vim's paste mode when you paste
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

set shell=/bin/zsh\ -l
