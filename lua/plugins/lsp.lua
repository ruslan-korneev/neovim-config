return {
  "neovim/nvim-lspconfig",
  dependencies = { "williamboman/mason.nvim" },
  opts = {
    code_action_prompt = { enable = false },
  },
  config = function()
    local lspconfig = require("lspconfig")
    local mason = require("mason")

    mason.setup()

    -- pyright
    lspconfig.pyright.setup({
      settings = {
        python = {
          analysis = {
            diagnosticSeverityOverrides = {},
          },
        },
      },
    })

    -- ruff
    lspconfig.ruff_lsp.setup({
      on_attach = function(client, bufnr)
        if client.name == "ruff_lsp" then
          client.server_capabilities.hoverProvider = false
        end
      end,
      settings = {
        python = {
          analysis = { ignore = { "*" } },
        },
      },
    })

    -- lua
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          telemetry = {
            enable = false,
          },
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
  end,
}
