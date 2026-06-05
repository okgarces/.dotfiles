local set = vim.opt
set.expandtab = true
set.tabstop = 2
set.shiftwidth = 2
set.softtabstop = 2

set.colorcolumn = "140"
set.incsearch = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.errorbells = false
vim.opt.visualbell = true
set.wrap = false
set.number = true
set.relativenumber = true
set.smartcase = true
set.smartindent = true
set.cursorline = true
set.showmode = false

set.undofile = true
set.undodir = "~/.config/nvim/undodir"        --- Undo Dir folder



--- performance tweaks
set.scrolljump = 10                          --- Allows to jump 20 lines while scrolling
set.lazyredraw = true
set.redrawtime = 10000
set.synmaxcol = 180
set.re = 0                                   --- This is to avoid slow highlight files 

--set.colorscheme = "habamax"
vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("nord")
--

local mapleader = " "
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

vim.keymap.set("n", "<leader>h", "<cmd>wincmd h<CR>", { desc = "Move to left window" })
vim.keymap.set("n", "<leader>j", "<cmd>wincmd j<CR>", { desc = "Move to lower window" })
vim.keymap.set("n", "<leader>k", "<cmd>wincmd k<CR>", { desc = "Move to upper window" })
vim.keymap.set("n", "<leader>l", "<cmd>wincmd l<CR>", { desc = "Move to right window" })

-- Alternative: Split windows quickly using leader
vim.keymap.set("n", "<leader>v", "<cmd>wincmd v<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>s", "<cmd>wincmd s<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>q", "<cmd>wincmd q<CR>", { desc = "Close current window" })


vim.keymap.set("n", "<leader>+", "<cmd>vertical resize +10<CR>", { desc = "Vertical resize +10" })
vim.keymap.set("n", "<leader>-", "<cmd>vertical resize -10<CR>", { desc = "Vertical resize -10" })




--- Install Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add your plugins here
    {
      "saghen/blink.cmp",
	  version = "*", -- Downloads pre-built binaries
	  opts = {
	    keymap = { preset = "default" },
	    sources = {
	      default = { "lsp", "path", "snippets", "buffer" },
	    },
	  },
	}
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
},
{
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
  version = false, -- last release is way too old and doesn't work on Windows
  build = function()
    local TS = require("nvim-treesitter")
    if not TS.get_installed then
      LazyVim.error("Please restart Neovim and run `:TSUpdate` to use the `nvim-treesitter` **main** branch.")
      return
    end
    -- make sure we're using the latest treesitter util
    package.loaded["lazyvim.util.treesitter"] = nil
    LazyVim.treesitter.build(function()
      TS.update(nil, { summary = true })
    end)
  end,
  event = { "LazyFile", "VeryLazy" },
  cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
  opts_extend = { "ensure_installed" },
  ---@alias lazyvim.TSFeat { enable?: boolean, disable?: string[] }
  ---@class lazyvim.TSConfig: TSConfig
  opts = {
    -- LazyVim config for treesitter
    indent = { enable = true }, ---@type lazyvim.TSFeat
    highlight = { enable = true }, ---@type lazyvim.TSFeat
    folds = { enable = true }, ---@type lazyvim.TSFeat
    ensure_installed = {
      "bash",
      "javascript",
      "lua",
      "markdown",
      "python",
      "typescript",
      "vim",
      "vimdoc",
    },
  }
 }
)
