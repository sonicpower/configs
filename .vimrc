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
silent !mkdir ~/.vim/backups > /dev/null 2>&1
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

" Ignore files in .gitignore
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
