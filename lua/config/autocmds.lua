-- LSP for FunC
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "fc", "func" },
--   callback = function()
--     vim.lsp.start({
--       name = "func-extracted-ls",
--       cmd = { "func-extracted-ls", "--stdio" },
--       -- root_dir = vim.loop.cwd,
--     })
--   end,
-- })

-- Remember folds
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "?*",
  command = "mkview 1",
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "?*",
  command = "silent! loadview 1",
})
