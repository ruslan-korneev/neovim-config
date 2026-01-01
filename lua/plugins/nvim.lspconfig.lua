-- ~/.config/nvim/lua/plugins/lsp.lua
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },

    --- Change or extend LazyVim's default LSP options
    opts = function(_, opts)
      ------------------------------------------------------------------
      -- 1.  List all servers you want LazyVim to start
      ------------------------------------------------------------------
      opts.servers = vim.tbl_extend("force", opts.servers or {}, {
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "openFilesOnly",
                autoImportCompletions = true,
              },
            },
          },
        },
        ruff  = {},
        ts_ls  = {},
        ton       = {},    -- <-- TON language server
      })

      ------------------------------------------------------------------
      -- 2.  (Optional) Add Mason packages to auto-install
      ------------------------------------------------------------------
      opts.ensure_installed = vim.list_extend(
        opts.ensure_installed or {},
        { "pyright", "ruff", "typescript-language-server" }
      )
      -- TON LS is *not* on Mason, so we keep installing it manually.

      ------------------------------------------------------------------
      -- 3.  Custom setup for TON because it is not in nvim-lspconfig yet
      ------------------------------------------------------------------
      opts.setup = opts.setup or {}
      opts.setup.ton = function(_, server_opts)
        local lspconfig = require("lspconfig")
        local configs   = require("lspconfig.configs")

        -- Register a new lspconfig entry only once
        if not configs.ton then
          configs.ton = {
            default_config = {
              cmd = {
                "node",
                -- adapt the path ↓ or keep it in $PATH and use `vim.fn.exepath "ton-language-server"`
                vim.fn.expand("/Users/ruslankorneev/.config/ton-language-server/dist/server.js"),
                "--stdio",
              },
              filetypes = { "tolk", "fift", "tlb" },
              root_dir  = lspconfig.util.root_pattern("package.json", ".git"),
            },
            docs = {
              description = "TON Language Server – https://github.com/ton-blockchain/ton-language-server",
            },
          }
        end

        -- Finally start / attach
        lspconfig.ton.setup(server_opts)
        return true            -- tell LazyVim that we handled it
      end
    end,
  },
}
