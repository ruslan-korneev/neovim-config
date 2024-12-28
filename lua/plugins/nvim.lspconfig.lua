return {
  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@diagnostic disable-next-line: undefined-doc-name
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  {
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
    end,
  },
}
