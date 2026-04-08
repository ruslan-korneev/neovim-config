-- LSP setup using Neovim 0.11+ native vim.lsp.config / vim.lsp.enable.
-- Server configs come from nvim-lspconfig (lsp/<name>.lua files on rtp).
--
-- Install language servers manually (no mason):
--   brew install lua-language-server gopls rust-analyzer llvm
--   npm i -g vscode-langservers-extracted vtsls basedpyright
--
-- llvm provides clangd. vscode-langservers-extracted provides html/cssls/jsonls.

local servers = {
  "lua_ls",
  "gopls",
  "vtsls",
  "basedpyright",
  "rust_analyzer",
  "clangd",
  "html",
  "cssls",
  "jsonls",
}

-- Global capabilities (blink.cmp augments LSP defaults)
local ok, blink = pcall(require, "blink.cmp")
local capabilities = ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("*", {
  capabilities = capabilities,
})

-- Per-server overrides
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { globals = { "vim" } },
    },
  },
})

vim.lsp.enable(servers)

-- Diagnostics UI
vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  underline = true,
  virtual_text = {
    spacing = 4,
    prefix = "●",
    source = "if_many",
  },
  float = {
    border = "rounded",
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.INFO]  = "",
      [vim.diagnostic.severity.HINT]  = "",
    },
  },
})

-- Buffer-local LSP keymaps on attach
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
  callback = function(event)
    local buf = event.buf
    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
    end
    map("n", "gd",         vim.lsp.buf.definition,      "Goto definition")
    map("n", "gD",         vim.lsp.buf.declaration,     "Goto declaration")
    map("n", "gi",         vim.lsp.buf.implementation,  "Implementation")
    map("n", "gt",         vim.lsp.buf.type_definition, "Type definition")
    map("n", "K",          vim.lsp.buf.hover,           "Hover")
    map("n", "R",          vim.lsp.buf.rename,          "Rename")
    map("n", "<leader>j",  vim.lsp.buf.references,      "References (finder)")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, "Format")
    map("n", "[d",         function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
    map("n", "]d",         function() vim.diagnostic.jump({ count =  1, float = true }) end, "Next diagnostic")
    map("n", "<leader>cd", vim.diagnostic.open_float,   "Line diagnostics")
  end,
})
