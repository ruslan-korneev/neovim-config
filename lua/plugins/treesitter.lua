return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "lua", "vim", "vimdoc", "query",
      "python",
      "javascript", "typescript", "tsx",
      "html", "css", "json", "jsonc",
      "go", "gomod", "gosum",
      "rust",
      "c", "cpp",
      "markdown", "markdown_inline",
      "bash", "yaml", "toml", "regex", "diff",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
