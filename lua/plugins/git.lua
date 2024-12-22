return {
  "lewis6991/gitsigns.nvim",
  cmd = "Gitsigns",
  lazy = true,
  init = function()
    -- require("wuelnerdotexe.plugin.util").add_colorscheme_integration("gitsigns")
    --
    -- require("wuelnerdotexe.plugin.util").set_option("termguicolors", true)
    -- require("wuelnerdotexe.plugin.util").set_option("signcolumn", "yes:1")

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("load_gitsigns", { clear = false }),
      callback = function()
        if package.loaded["gitsigns"] then
          vim.api.nvim_clear_autocmds({ group = "load_gitsigns" })

          return true
        end

        vim.api.nvim_call_function("system", {
          "git -C " .. vim.api.nvim_call_function("expand", { "%:p:h" }) .. " rev-parse",
        })

        if vim.api.nvim_get_vvar("shell_error") ~= 0 then
          return
        end

        vim.api.nvim_clear_autocmds({ group = "load_gitsigns" })

        require("lazy").load({ plugins = { "gitsigns.nvim" } })
      end,
    })
  end,
  config = function()
    local updatetime = vim.api.nvim_get_option_value("updatetime", { scope = "global" })

    require("gitsigns").setup({
      -- signs = { add = { text = "│" }, change = { text = "│" } },
      current_line_blame = true,
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d %T> - <summary>",
      current_line_blame_opts = {
        delay = 1,
      },
      sign_priority = 1,
      update_debounce = updatetime,
      preview_config = { border = "rounded", row = 1, col = 0 },
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hr", "", {
          callback = function()
            gs.reset_hunk()
          end,
          desc = "Git: [r]eset the current [h]unk",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "x", "<leader>hr", "", {
          callback = function()
            gs.reset_hunk({
              vim.api.nvim_call_function("line", { "." }),
              vim.api.nvim_call_function("line", { "v" }),
            })
          end,
          desc = "Git: [r]eset the current [h]unk",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>hp", "", {
          callback = function()
            gs.preview_hunk()
          end,
          desc = "Git: [p]review the current [h]unk",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>bg", "", {
          callback = function()
            gs.blame_line({ full = true })
          end,
          desc = "Git: [p]review the current line [b]lame",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "ga", "", {
          callback = function()
            gs.stage_hunk()
          end,
          desc = "Git stage hunk",
        })
        vim.api.nvim_buf_set_keymap(bufnr, "v", "ga", "", {
          callback = function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end,
          desc = "Git stage selected",
        })
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gA", "", {
          callback = function()
            gs.stage_buffer()
          end,
          desc = "Git stage buffer",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>gd", "", {
          callback = function()
            gs.diffthis("~")
          end,
          desc = "Git: split [g]it [d]iffs",
        })

        vim.api.nvim_buf_set_keymap(bufnr, "n", "]h", "", {
          callback = function()
            gs.nav_hunk("next")
          end,
        })
        vim.api.nvim_buf_set_keymap(bufnr, "n", "[h", "", {
          callback = function()
            gs.nav_hunk("prev")
          end,
        })
      end,
    })

    if not pcall(require, "scrollbar.handlers.gitsigns") then
      return
    end

    require("scrollbar.handlers.gitsigns").setup()
  end,
}
