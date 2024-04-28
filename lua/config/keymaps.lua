-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable continuations

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "x", '"_x')

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save with root permission (not working for now)
--vim.api.nvim_create_user_command('W', 'w !sudo tee > /dev/null %', {})

-- Disable continuations
keymap.set("n", "<Leader>o", "o<Esc>^Da", opts)
keymap.set("n", "<Leader>O", "O<Esc>^Da", opts)

-- Jumplist
-- keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)

-- Move tab
keymap.set("n", "<c-,>", ":tabm -1<Return>", opts)
keymap.set("n", "<c-.>", ":tabm +1<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-w><left>", "<C-w><")
keymap.set("n", "<C-w><right>", "<C-w>>")
keymap.set("n", "<C-w><up>", "<C-w>+")
keymap.set("n", "<C-w><down>", "<C-w>-")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.goto_next()
end, opts)

-- keymap.set("n", "<leader>r", function()
--   require("craftzdog.utils").replaceHexWithHSL()
-- end)

-- Another
keymap.set("i", "jj", "<Esc>") -- escape to command mode
keymap.set("n", ",<space>", ":nohlsearch<cr>") -- remove highlights from searched pattern

-- Quit, Save, Quit+Save
keymap.set("n", "qq", ":q<cr>")
keymap.set("n", "ww", ":w<cr>")
keymap.set("n", "wq", ":w<cr>")
keymap.set("n", "qa", ":q!<cr>")

-- Switch Pane
keymap.set("n", "<S-h>", "<C-w>W") -- previous
keymap.set("n", "<S-l>", "<C-w>w") -- next

-- Buffer navigation
keymap.set("n", "gn", ":bn<cr>")
keymap.set("n", "gp", ":bp<cr>")
