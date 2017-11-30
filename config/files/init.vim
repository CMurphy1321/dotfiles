"Leader mappings
let mapleader=","
let maplocalleader=","
nmap \ <Leader><Leader>

"Use semicolon to enter commands
nnoremap ; :

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

nnoremap <silent> <leader>W :%s/\s\+$//e <bar> nohlsearch <bar> echo "Remove trailing whitespace"<CR>
