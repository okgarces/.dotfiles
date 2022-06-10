syntax on

set colorcolumn=140
set expandtab
set incsearch
set nobackup
set noerrorbells
set noswapfile
set nowrap
set number
set relativenumber
set smartcase
set smartindent

" Old settings
" set shiftwidth=4
" set tabstop=4 softtabstop=4 expandtab
" Java and Typescript Settings
set shiftwidth=2
set tabstop=2 softtabstop=2 expandtab

set undofile
set cursorline
set noshowmode                            " dont show current mode below statusline
set undodir=~/.config/nvim/undodir        " Undo Dir folder

" performance tweaks
set scrolljump=10                          " Allows to jump 20 lines while scrolling
set lazyredraw
set redrawtime=10000
set synmaxcol=180
set re=0                                   " This is to avoid slow highlight files 

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

"Initialize plug calls settings
call plug#begin('~/.config/nvim/plugged')
"Plug 'neoclide/coc.nvim'
"Plug 'morhetz/gruvbox'
Plug 'gruvbox-community/gruvbox'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
"Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'

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

" Telescope remaps
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <C-g> <cmd>Telescope live_grep<cr>
nnoremap <C-b> <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"  LSP builtin
lua << EOF
local nvim_lsp = require('lspconfig')
-- Lightline color scheme
require('lightline_color_theme')

-- Compe Configuration
require('compe_settings')

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

"Terminal mapping 
tnoremap <c-\><c-\> <c-\><c-n>

"Custom functions
command! ClearReg :lua require('custom_functions').clear_registry_function()

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)"
