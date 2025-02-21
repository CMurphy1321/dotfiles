"Leader mappings
let mapleader=","
let maplocalleader=","
nmap \ <Leader><Leader>

"Use semicolon to enter commands
nnoremap ; :

"Run pathogen
filetype plugin indent on
execute pathogen#infect()

"Number lines
set relativenumber
"Leave 3 lines above, below cursor
set scrolloff=3

"Show line, column number
set ruler
"Always show status line
set laststatus=2
"Show tab line when 2 or more tabs are open
set showtabline=1

"A few misc things
syntax on
set smartcase ignorecase showmatch incsearch hlsearch wildignorecase wildmenu

nnoremap <silent> <leader>W :%s/\s\+$//e <bar> nohlsearch <bar> echo "Remove trailing whitespace"<CR>
"
"Remap tab to change tab levels in visual mode
vnoremap <TAB> >
vnoremap <S-TAB> <

"Tab formatting
"2 spaces per tab
set softtabstop=2
"2 spaces when indenting
set shiftwidth=2 tabstop=2 expandtab
