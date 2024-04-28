-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Indtent for these file types is 2
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "markdown", "toml", "yaml", "html" },
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
  end,
})
