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
Plug 'itchyny/lightline.vim'
call plug#end()

colorscheme gruvbox
set background=dark
highlight Normal ctermbg=256

let mapleader = " "
let g:ctrlp_use_caching = 0

let g:netrw_browse_split = 2 "Open in a new vertical split
let g:netrw_liststyle = 3 "Open in tree view
let g:netrw_banner = 0 "Remove netrw banner

""" This is the config for lightline color scheme based on Wombat
let s:base03 = [ '#242424', 235 ]
let s:base023 = [ '#353535', 236 ]
let s:base02 = [ '#444444', 238 ]
let s:base01 = [ '#585858', 240 ]
let s:base00 = [ '#666666', 242  ]
let s:base0 = [ '#808080', 244 ]
let s:base1 = [ '#969696', 247 ]
let s:base2 = [ '#a8a8a8', 248 ]
let s:base3 = [ '#d0d0d0', 252 ]
let s:yellow = [ '#cae682', 180 ]
let s:orange = [ '#e5786d', 173 ]
let s:red = [ '#e5786d', 203 ]
let s:magenta = [ '#f2c68a', 216 ]
let s:blue = [ '#8ac6f2', 117 ]
let s:dark_blue = ['5f87af', 67]
let s:cyan = s:blue
let s:green = [ '#87d700', 112 ]
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:base02, s:blue ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base0 ], [ s:base1, s:base01 ] ]
" [ [ <font color>, <background> ] ] "
let s:p.inactive.right = [ [ s:base02, s:dark_blue ], [ s:base02, s:dark_blue ] ]
let s:p.inactive.left =  [ [ s:base1, s:base02 ], [ s:base00, s:base023 ] ]
let s:p.insert.left = [ [ s:base02, s:green, 'bold' ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base023, s:red ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:base02, s:magenta ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base2, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base1, s:base023 ] ]
let s:p.tabline.left = [ [ s:base3, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:base03 ] ]
let s:p.tabline.middle = [ [ s:base2, s:base02 ] ]
let s:p.tabline.right = [ [ s:base2, s:base00 ] ]
let s:p.normal.error = [ [ s:base03, s:red ] ]
let s:p.normal.warning = [ [ s:base023, s:yellow ] ]
let g:lightline#colorscheme#wombat#palette = lightline#colorscheme#flatten(s:p)
let g:lightline = { 'colorscheme': 'wombat'}

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
nnoremap <C-p> :GFiles  --cached --exclude-standard --others<CR>
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

"CoC mapping
nmap <leader>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gr <Plug>(coc-references)

"Terminal mapping 
tnoremap <c-\><c-\> <c-\><c-n>

"Custom functions
command! ClearReg :call ClearRegFunction()
function! ClearRegFunction()
    let regs=split('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789*+/-"', '\zs')
    for r in regs
      call setreg(r, [])
    endfor
endfunction

"Change insert mode cursor
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)"
