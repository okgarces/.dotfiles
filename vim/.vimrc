syntax on

set colorcolumn=140
set expandtab
set incsearch
set nobackup
set noerrorbells
set noswapfile
set nowrap
set nu
" Old settings
" set shiftwidth=4
" set tabstop=4 softtabstop=4 expandtab
" Java and Typescript Settings
set shiftwidth=2
set tabstop=2 softtabstop=2 expandtab
set smartcase
set smartindent
set undodir=/Users/ogarces/.vim/undodir
set undofile
set relativenumber
set cursorline


"Initialize plug calls settings
call plug#begin('~/.vim/plugged')
"Plug 'neoclide/coc.nvim'
"Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
"Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

" Just testing
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'mhartington/formatter.nvim'
Plug 'nvim-treesitter/playground'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" For Java
Plug 'mfussenegger/nvim-jdtls'
Plug 'vim-syntastic/syntastic'
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
nnoremap <Leader>pf :vertical resize<CR>
nnoremap <Leader>+ :vertical resize +10<CR>
nnoremap <Leader>- :vertical resize -10<CR>

"(S)plit (W)ith (T)erminal
"Split and have a terminal in bottom position
nnoremap <Leader>swt :split <bar> :vsplit <bar> :wincmd j <bar> :split <bar> :terminal <CR> :wincmd j <bar> :q! <bar> :resize 10 <CR>

"(S)plit (W)ith (T)abs
"Split and have a terminal in bottom position
nnoremap <Leader>swT <bar> :tabnew <CR>

"FZF plugin
"nnoremap <C-p> :GFiles  --cached --exclude-standard --others<CR>
"let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

" Telescope remaps
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"  LSP builtin
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd> Telescope lsp_definitions <CR>', opts)
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches

local servers = { "pyright", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- Treesitter configs, add more languages when needed
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"java"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}

-- Telescope settings to open definitions in a vsplit
require("telescope").setup {
  pickers = {
      lsp_definitions = {
          jump_type = 'vsplit'
      }
  }
}

-- Formatter for java
require('formatter').setup({
  filetype = {
    java = {
      -- google java formatter
      function()
        return {
          exe = "java -jar /Users/ogarces/dev/google-java-format/google-java-format-1.11.0-all-deps.jar",
          args = {"--replace", vim.api.nvim_buf_get_name(0)},
          stdin = false
        }
      end
    },
  }
})

local signs = { Error = '❌', Warning = '❕', Hint = '❔', Information = 'ℹ️ ' }

for type, icon in pairs(signs) do
  local hl = "LspDiagnosticsSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

EOF
""""""""""""""""" End LUA LSP """"""""""""
" Java setup
augroup lsp
    au!
    au FileType java lua require'jdtls_setup'.setup()
    "au!
    "au FileType java lua require('jdtls').start_or_attach({cmd = {'/Users/ogarces/Documents/dotfiles/.dotfiles/vim/java-lsp.sh'}})
augroup end

" Java syntastic checkstyle
let g:syntastic_java_checkers = ['checkstyle']
let g:syntastic_java_checkstyle_classpath = '/Users/ogarces/dev/checkstyle/checkstyle-8.45.1-all.jar'
let g:syntastic_java_checkstyle_conf_file = './.code_quality/checkstyle_rules.xml'
let g:syntastic_loc_list_height = 5
let g:syntastic_check_on_open = 0
let g:syntastic_auto_loc_list = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <C-c>E :SyntasticCheck<CR>
nnoremap <C-c>q :lclose<CR>
let g:syntastic_error_symbol = '❌'
let g:syntastic_style_error_symbol = '🚧'
let g:syntastic_warning_symbol = '⚠️'
let g:syntastic_style_warning_symbol = '⚠️'


let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Setup for JDTLS for the code actions
nnoremap <silent> <F12> <Cmd>lua require('jdtls').code_action()<CR>
vnoremap <silent> <F12> <Esc><Cmd>lua require('jdtls').code_action(true)<CR>

" Git Gutter Options
set updatetime=100

" Compe Configuration
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true
set completeopt=menuone,noselect


"CoC mapping
"nmap <leader>gd <Plug>(coc-definition)
"nmap <silent>gy <Plug>(coc-type-definition)
"nmap <leader>gi <Plug>(coc-implementation)
"nmap <leader>gr <Plug>(coc-references)
"nmap <leader>gr <Plug>(coc-references)

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

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)"
