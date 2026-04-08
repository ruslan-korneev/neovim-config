return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  opts = {
    flavour = "mocha",
    transparent_background = false,
    term_colors = true,
    no_italic = false,
    styles = {
      comments = { "italic" },
      keywords = { "italic" },
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { "undercurl" },
          hints = { "undercurl" },
          warnings = { "undercurl" },
          information = { "undercurl" },
        },
      },
      gitsigns = true,
      fzf = true,
      blink_cmp = true,
      bufferline = true,
      markdown = true,
      mason = false,
      notify = false,
    },
  },
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
}
