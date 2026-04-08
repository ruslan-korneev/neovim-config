-- LSP setup using Neovim 0.11+ native vim.lsp.config / vim.lsp.enable.
-- Server configs come from nvim-lspconfig (lsp/<name>.lua files on rtp).
--
-- Install language servers manually (no mason):
--   brew install lua-language-server gopls rust-analyzer llvm
--   npm i -g vscode-langservers-extracted vtsls basedpyright
--   uv tool install ruff  (provides `ruff server` LSP; per-project ruff from .venv is preferred)
--
-- llvm provides clangd. vscode-langservers-extracted provides html/cssls/jsonls.

local servers = {
  "lua_ls",
  "gopls",
  "vtsls",
  "basedpyright",
  -- ruff is started manually via FileType autocmd below so we can prefer
  -- a project-local .venv/bin/ruff over the global uv-installed one.
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
-- basedpyright: keep hover/goto/completion, but let ruff own diagnostics.
-- `ignore = {"**"}` makes the analyzer skip publishing diagnostics for all files
-- while leaving the rest of the language features intact.
vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        ignore = { "**" },
      },
    },
  },
})

-- ruff: started manually per-buffer so we can resolve the binary dynamically.
-- Prefer <root>/.venv/bin/ruff (e.g. `uv add --dev ruff` + `uv sync`), fall back
-- to the global `ruff` on $PATH (installed via `uv tool install ruff`).
-- Hover is disabled so basedpyright owns hover docs.
local function resolve_ruff_cmd(root)
  if root then
    for _, p in ipairs({ root .. "/.venv/bin/ruff", root .. "/venv/bin/ruff" }) do
      if vim.uv.fs_stat(p) then
        return { p, "server" }
      end
    end
  end
  return { "ruff", "server" }
end

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("user-ruff-lsp", { clear = true }),
  pattern = "python",
  callback = function(ev)
    local root = vim.fs.root(ev.buf, { "pyproject.toml", "uv.lock", "setup.py", "setup.cfg", ".git" })
    vim.lsp.start({
      name = "ruff",
      cmd = resolve_ruff_cmd(root),
      root_dir = root,
      capabilities = capabilities,
      on_attach = function(client, _)
        client.server_capabilities.hoverProvider = false
      end,
    })
  end,
})

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
    map("n", "gy",         vim.lsp.buf.type_definition, "Type definition")
    map("n", "R",          vim.lsp.buf.rename,          "Rename")
    map("n", "<leader>j",  vim.lsp.buf.references,      "References (finder)")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("n", "<leader>fm", function()
      local ok_conform, conform = pcall(require, "conform")
      if ok_conform then
        conform.format({ async = true, lsp_format = "fallback" })
      else
        vim.lsp.buf.format({ async = true })
      end
    end, "Format")
    map("n", "[d",         function() vim.diagnostic.jump({ count = -1, float = true }) end, "Prev diagnostic")
    map("n", "]d",         function() vim.diagnostic.jump({ count =  1, float = true }) end, "Next diagnostic")
    map("n", "<leader>cd", vim.diagnostic.open_float,   "Line diagnostics")
  end,
})
