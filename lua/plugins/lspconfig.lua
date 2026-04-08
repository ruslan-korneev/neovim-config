-- nvim-lspconfig is used purely as a source of `lsp/<name>.lua` server
-- definitions consumed by the 0.12 native vim.lsp.config / vim.lsp.enable API
-- (see lua/lsp.lua). These files must be on the runtimepath *before*
-- require("lsp") runs, otherwise vim.lsp.enable() can't resolve cmd/filetypes/
-- root_markers and servers silently fail to start. So: load eagerly, not lazy.
return {
  "neovim/nvim-lspconfig",
  lazy = false,
}
