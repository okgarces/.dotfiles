syntax on

set colorcolumn=120
set expandtab
set incsearch
set nobackup
set noerrorbells
set noswapfile
set nowrap
set nu
set shiftwidth=4
set smartcase
set smartindent
set tabstop=4 softtabstop=4 expandtab
set undodir=/Users/ogarces/.vim/undodir
set undofile
set relativenumber
set cursorline


"Initialize plug calls settings
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'sheerun/vim-polyglot'
call plug#end()

colorscheme gruvbox
set background=dark
highlight Normal ctermbg=256

let mapleader = " "
let g:ctrlp_use_caching = 0

let g:netrw_browse_split = 2 "Open in a new vertical split
let g:netrw_liststyle = 3 "Open in tree view
let g:netrw_banner = 0 "Remove netrw banner

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>rp :resize 100<CR>

"(S)plit (W)ith (T)erminal
"Split and have a terminal in bottom position
nnoremap <Leader>swt :split <bar> :vsplit <bar> :wincmd j <bar> :split <bar> :terminal <CR> :wincmd j <bar> :q! <bar> :resize 10 <CR>

"FZF plugin
nnoremap <C-p> :GFiles<CR>
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

"CoC mapping
nmap <leader>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gr <Plug>(coc-references)

"Terminal mapping 
tnoremap <c-\><c-\> <c-\><c-n>


"Change insert mode cursor
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)"
