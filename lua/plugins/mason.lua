return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      -- a list of all tools you want to ensure are installed upon
      -- start
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "html-lsp",
        "css-lsp",
        "prettier",
        "json-lsp",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "hadolint",
        "markdownlint",
        "marksman",
        "shfmt",
        "eslint-lsp",

        -- Python
        "pyright",
        "mypy",
        "ruff",
        "ruff-lsp",
        "python-lsp-server",
        "black",
        "debugpy",
        "vulture",
        "isort",
      },
      auto_update = true,
      run_on_start = true,
    },
  },
}
