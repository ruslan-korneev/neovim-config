return {
  {
    "LiadOz/nvim-dap-repl-highlights",
    opts = function(_, opts)
    end,
    },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "LiadOz/nvim-dap-repl-highlights" },
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "dap_repl",
        "func",
      })
    end,
  },
}
