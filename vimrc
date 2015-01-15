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
set formatoptions+=w
nnoremap F gqip

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

"Call space highlighting
com! SpaceHi call s:SpaceHi()
com! NoSpaceHi call s:NoSpaceHi()
com! ToggleSpaceHi call s:ToggleSpaceHi()

"Call tab highlighting
com! TabHi call s:TabHi()
com! NoTabHi call s:NoTabHi()
com! ToggleTabHi call s:ToggleTabHi()

"fugitive shortcuts
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader><Up> :Gpush<CR>
nnoremap <Leader><Down> :Gpull<CR>

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

"Toggle rainbow parentheses
nnoremap <Leader>r :RainbowParenthesesToggle<CR>

"Clear search highlight
nmap <Leader>/ :nohlsearch<CR>

"Toggle Gundo tree
nnoremap <Leader>g :GundoToggle<CR>

nnoremap <Leader>wl :w<CR> :Latexmk<CR>

nmap \ <Leader><Leader>

"Disable EX mode
noremap Q <NOP>

"Disable help
noremap <F1> <NOP>
noremap! <F1> <NOP>

"Allow writing even if you forgot to sudo
cmap w!! w !sudo tee % >/dev/null
cmap x!! x !sudo tee % >/dev/null

set autochdir

if filereadable(expand("$HOME/.vimrc.local"))
    source $HOME/.vimrc.local
endif

"Toggle all for rainbow parentheses
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy/<C-R><C-R>=substitute(
    \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
    \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
    \gvy?<C-R><C-R>=substitute(
    \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
    \gV:call setreg('"', old_reg, old_regtype)<CR>

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
