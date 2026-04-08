return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    signs = {
      add          = { text = "▎" },
      change       = { text = "▎" },
      delete       = { text = "" },
      topdelete    = { text = "" },
      changedelete = { text = "▎" },
      untracked    = { text = "▎" },
    },
    on_attach = function(buf)
      local gs = package.loaded.gitsigns
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
      end

      -- Stage
      map("n", "ga", gs.stage_hunk, "Stage hunk")
      map("v", "ga", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage selection")
      map("n", "gA", gs.stage_buffer, "Stage buffer")

      -- Reset
      map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset selection")

      -- Preview / blame / diff
      map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
      map("n", "<leader>bg", function() gs.blame_line({ full = true }) end, "Blame line")
      map("n", "<leader>gd", function() gs.diffthis("~") end, "Diff against ~")

      -- Navigation
      map("n", "]h", function() gs.nav_hunk("next") end, "Next hunk")
      map("n", "[h", function() gs.nav_hunk("prev") end, "Prev hunk")
    end,
  },
}
