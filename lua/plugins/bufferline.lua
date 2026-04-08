return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    options = {
      mode = "buffers",
      numbers = "none",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
      show_buffer_close_icons = false,
      show_close_icon = false,
      separator_style = "thin",
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "netrw",
          text = "File Explorer",
          text_align = "left",
          separator = true,
        },
      },
    },
  },
  keys = {
    { "gn",         "<cmd>BufferLineCycleNext<cr>",   desc = "Next buffer" },
    { "gp",         "<cmd>BufferLineCyclePrev<cr>",   desc = "Prev buffer" },
    { "<leader>bp", "<cmd>BufferLineTogglePin<cr>",   desc = "Pin buffer" },
    { "<leader>bd", "<cmd>bdelete<cr>",               desc = "Delete buffer" },
    { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
    { "[b",         "<cmd>BufferLineMovePrev<cr>",    desc = "Move buffer left" },
    { "]b",         "<cmd>BufferLineMoveNext<cr>",    desc = "Move buffer right" },
  },
}
