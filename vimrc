set nocompatible
let mapleader=","
let maplocalleader=","
filetype plugin indent on
execute pathogen#infect()

if has('persistent_undo')
	set undodir=$HOME/.vim/vimundo
	set undofile
endif

set relativenumber
set scrolloff=3
set ruler

set backspace=indent,eol,start

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set tw=79

command! W w
command! Q q
command! Wq wq

syntax on
"set autoindent
set smartindent
set smartcase
set ic
set showmatch
set incsearch
set hlsearch
set wildignorecase

"Keep current buffer at the top for sp, left for vsp
set splitbelow
set splitright

set t_Co=256
set background=dark
colorscheme mustang

"highlight trailing whitespace and whitespace before tab
highlight ExtraWhitespace ctermbg=white guibg=white
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
nnoremap <leader>W :%s/\s\+$//<CR><C-o>

nnoremap <Leader>c :exec 'set' (&colorcolumn ==# '') ? 'colorcolumn=+1' : 'colorcolumn='<CR>
nnoremap <Leader>l :set cursorline!<CR>
nnoremap <Leader>s ddp
nnoremap <Leader>z :set spell!<CR>

set autochdir

if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif
