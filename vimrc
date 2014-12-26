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

"Toggle Trailing Whitespace Highlighting
map <Leader>w :ToggleSpaceHi<CR>
if !exists("g:spacehi_spacecolor")
    let g:spacehi_spacecolor="ctermbg=white guibg=white"
endif

function! s:SpaceHi()
    syntax match spacehiTrailingSpace /\s\+$/ containedin=ALL
    execute("highlight spacehiTrailingSpace " . g:spacehi_spacecolor)

    let b:spacehi = 1
endfunction

function! s:NoSpaceHi()
    syntax clear spacehiTrailingSpace
    let b:spacehi = 0
endfunction

function! s:ToggleSpaceHi()
    if exists("b:spacehi") && b:spacehi
        call s:NoSpaceHi()
        echo ""
    else
        call s:SpaceHi()
        echo ""
    endif
endfunction

com! SpaceHi call s:SpaceHi()
com! NoSpaceHi call s:NoSpaceHi()
com! ToggleSpaceHi call s:ToggleSpaceHi()

"Toggle Tab Highlighting
map <Leader>t :ToggleTabHi<CR>
if !exists("g:tabhi_color")
    let g:tabhi_color=" ctermbg=red guibg=red"
endif

function! s:TabHi()
    syntax match hiTab /\t/ containedin=ALL
    execute("highlight hiTab " . g:tabhi_color)

    let b:tabhi = 1
endfunction

function! s:NoTabHi()
    syntax clear hiTab
    let b:tabhi = 0
endfunction

function! s:ToggleTabHi()
    if exists("b:tabhi") && b:tabhi
        call s:NoTabHi()
        echo ""
    else
        call s:TabHi()
        echo ""
    endif
endfunction

com! TabHi call s:TabHi()
com! NoTabHi call s:NoTabHi()
com! ToggleTabHi call s:ToggleTabHi()

"Remove trailing whitespace
nnoremap <leader>W :%s/\s\+$//<CR><C-o>

"Toggle color column
nnoremap <Leader>m :exec 'set' (&colorcolumn ==# '') ? 'colorcolumn=+1' : 'colorcolumn='<CR>

"Toggle cursorline
nnoremap <Leader>c :set cursorline!<CR>

"Swap a line with the line below it
nnoremap <Leader>s ddp

"Toggle spelling
nnoremap <Leader>z :set spell!<CR>

"Align in visual
vnoremap <Leader>te :Tab /=<CR>
vnoremap <Leader>tc :Tab /:<CR>

"Clear search highlight
nmap <Leader>/ :nohlsearch<CR>

nnoremap <Leader>g :GundoToggle<CR>

"Allow writing even if you forgot to sudo
cmap w!! w !sudo tee % >/dev/null
cmap x!! x !sudo tee % >/dev/null

set autochdir

if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif
