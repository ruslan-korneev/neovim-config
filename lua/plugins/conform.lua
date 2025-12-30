return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
      rust = { "rustfmt" },
      -- Use a sub-list to run only the first available formatter
      javascript = { "prettierd", "prettier" },
    },
  },
}
