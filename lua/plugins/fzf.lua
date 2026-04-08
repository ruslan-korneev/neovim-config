return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>fP", function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("data") .. "/lazy" })
      end, desc = "Find plugin file" },
    { "<leader>r", function()
        require("fzf-lua").live_grep({
          rg_opts = "--column --line-number --no-heading --color=always "
            .. "--smart-case --max-columns=4096 --hidden -g '!.git/'",
        })
      end, desc = "Live grep (hidden)" },
    { "<leader>fr", function()
        require("fzf-lua").oldfiles({ cwd_only = true })
      end, desc = "Recent files (cwd)" },
    { "<leader>t",  "<cmd>FzfLua help_tags<cr>",            desc = "Help tags" },
    { "<leader>;",  "<cmd>FzfLua resume<cr>",               desc = "Resume picker" },
    { "<leader>s",  "<cmd>FzfLua treesitter<cr>",           desc = "Treesitter symbols" },
    { "<leader>dd", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Diagnostics (all)" },
    { "<leader>fg", "<cmd>FzfLua git_status<cr>",            desc = "Git status" },
    { "\\",         "<cmd>FzfLua buffers<cr>",              desc = "Buffers" },
    -- Convenience: simple files picker
    { "<leader>ff", "<cmd>FzfLua files<cr>",                desc = "Find files" },
  },
  opts = { "default-title" },
}
