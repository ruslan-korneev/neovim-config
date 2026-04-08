return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>F",
      mode = { "n" },
      "<cmd>Neotree float<cr>",
      desc = "Open float neotree",
    },
    {
      "<leader>fe",
      mode = { "n" },
      "<cmd>Neotree reveal float<cr>",
      desc = "Open float neotree",
    },
    {
      "<leader>ge",
      mode = { "n" },
      "<cmd>Neotree reveal float git_status<cr>",
      desc = "Open float neotree git status",
    },
  },
  lazy = true, -- neo-tree will lazily load itself
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    window = {
      position = "float",
    },
  },
}
