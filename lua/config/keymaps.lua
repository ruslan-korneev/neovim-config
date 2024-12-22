-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local default_options = { silent = true, remap = true }

-- Auxiliary
keymap.set("i", "jj", "<esc>", { desc = "Go to normal mode", unpack(default_options) })
keymap.set("n", ",<space>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlights", unpack(default_options) })
keymap.set("n", "x", '"_x', { desc = "Remove symbol and move cursor backwards", unpack(default_options) })
keymap.set("n", "dw", 'vb"_d', { desc = "Delete a word backwards", unpack(default_options) })
keymap.set("n", "<c-a>", "gg<s-v>G", { desc = "Select all", unpack(default_options) })

-- Save and Quit File
keymap.set("n", "qq", "<cmd>q<cr>", { desc = "Quit", unpack(default_options) })
keymap.set("n", "ww", "<cmd>w<cr>", { desc = "Save File", unpack(default_options) })
keymap.set("n", "wq", "<cmd>w<cr>", { desc = "Save and Quit File", unpack(default_options) })
keymap.set("n", "qa", "<cmd>qa!<cr>", { desc = "Force quit without saving", unpack(default_options) })

-- Panes
keymap.set("n", "ss", "<cmd>split<cr>", { desc = "Split window horizontally", unpack(default_options) })
keymap.set("n", "sv", "<cmd>vsplit<cr>", { desc = "Split window vertically", unpack(default_options) })
keymap.set("n", "<c-w><left>", "<c-w><", { desc = "Resize pane Left", unpack(default_options) })
keymap.set("n", "<c-w><right>", "<c-w>>", { desc = "Resize pane Right", unpack(default_options) })
keymap.set("n", "<c-w><up>", "<c-w>+", { desc = "Resize pane Up", unpack(default_options) })
keymap.set("n", "<c-w><down>", "<c-w>-", { desc = "Resize pane Down", unpack(default_options) })
-- keymap.set("n", "<s-h>", "<c-w>W", { desc = "Left Pane", unpack(default_options) }) -- previous
-- keymap.set("n", "<s-l>", "<c-w>w", { desc = "Right Pane", unpack(default_options) }) -- next
keymap.set("n", "<space>", "<c-w>w", { desc = "Next Pane", unpack(default_options) }) -- next
keymap.set("n", "<S><S>", "<c-w>W", { desc = "Prev Pane", unpack(default_options) }) -- previous

-- Buffer
keymap.set("n", "gn", "<cmd>bn<cr>", { desc = "Next Buffer", unpack(default_options) })
keymap.set("n", "gp", "<cmd>bp<cr>", { desc = "Previous Buffer", unpack(default_options) })

-- Tabs
keymap.set("n", "te", "<cmd>tabedit<cr>", { desc = "Empty File in a new tab", unpack(default_options) })
keymap.set("n", "<tab>", "<cmd>tabnext<cr>", { desc = "Next tab", unpack(default_options) })
keymap.set("n", "<s-tab>", "<cmd>tabprev<cr>", { desc = "Previous tab", unpack(default_options) })
keymap.set("n", "tq", "<cmd>tabclose<cr>", { desc = "Close tab", unpack(default_options) })
keymap.set("n", "<c-,>", "<cmd>tabm -1<cr>", { desc = "Move tab to the left", unpack(default_options) })
keymap.set("n", "<c-.>", "<cmd>tabm +1<cr>", { desc = "Move tab to the right", unpack(default_options) })

-- Diagnostic
keymap.set("n", "<c-j>", function()
  vim.diagnostic.goto_next()
end, { desc = "Next diagnostic", unpack(default_options) })

-- Terminal
keymap.set("t", "<c-l>", "clear<cr>", { desc = "Clear terminal input", unpack(default_options) })
-- keymap.set("t", "qq", "<esc><esc>", { desc = "Toggle terminal normal mode", unpack(default_options) })
keymap.set("n", "<S-space>", "<c-w>W", { desc = "Prev Pane", unpack(default_options) }) -- previous
