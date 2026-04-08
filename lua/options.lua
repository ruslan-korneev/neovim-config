local opt = vim.opt
local g = vim.g

g.mapleader = ";"
g.maplocalleader = ";"

-- Disable unused providers — faster startup
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0
g.loaded_node_provider = 0

-- UI
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.termguicolors = true
opt.winborder = "rounded"
opt.laststatus = 3
opt.cmdheight = 1
opt.showmode = false
opt.pumheight = 10
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.fillchars = { eob = " ", fold = " " }

-- Statusline (minimal). Git branch comes from gitsigns (b:gitsigns_head).
opt.statusline = " %f %m%r %= %{get(b:,'gitsigns_head','')!=''?' '.b:gitsigns_head.'  ':''}%{&filetype}  %l:%c  %P "

-- Indentation
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.smartindent = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true
opt.inccommand = "split"

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Files
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.updatetime = 250
opt.timeoutlen = 400

-- Misc
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.confirm = true
opt.completeopt = "menu,menuone,noselect"
opt.shortmess:append("c")
