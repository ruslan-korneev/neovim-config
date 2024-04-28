local keys = { quit = { "<esc>", "q" }, toggle_or_jump = { "<cr>", "o" } }

return {
  {
    "nvimdev/lspsaga.nvim",
    cmd = { "Lspsaga" },
    event = "BufReadPost",
    config = function(_, opts)
      require("lspsaga").setup(opts)
    end,
    opts = {
      code_action = { enable = false, extend_gitsigns = true },
      symbols_in_winbar = { enable = true, show_file = false },
      references = {
        include_declaration = true,
        keys = { quit = keys.quit, goto_location = "<cr>" },
      },
    },
    keys = {
      { "<leader>j", "<Cmd>Lspsaga finder<CR>", desc = "Lspsaga finder" },
      { "R", "<Cmd>Lspsaga rename<CR>", desc = "Lspsaga global renaming" },
    },
  },
  {
    "RRethy/vim-illuminate",
    opts = {
      filetypes_denylist = {
        "sagafinder",
      },
    },
  },
}
