-- nvim-treesitter-textobjects (main branch) — provides the `textobjects.scm`
-- queries and the select/move helpers. Used here for:
--   * af / if — function outer / inner
--   * ac / ic — class outer / inner
--   * ]f [f ]F [F — next/prev function start/end
--   * ]c [c ]C [C — next/prev class start/end
return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = "main",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = "VeryLazy",
  config = function()
    local select = require("nvim-treesitter-textobjects.select")
    local move = require("nvim-treesitter-textobjects.move")

    -- Select text objects (operator-pending + visual).
    local selects = {
      ["af"] = "@function.outer",
      ["if"] = "@function.inner",
      ["ac"] = "@class.outer",
      ["ic"] = "@class.inner",
    }
    for lhs, capture in pairs(selects) do
      vim.keymap.set({ "x", "o" }, lhs, function()
        select.select_textobject(capture, "textobjects")
      end, { desc = "TS select " .. capture })
    end

    -- Movement between function / class boundaries.
    local moves = {
      { keys = "]f", fn = "goto_next_start", capture = "@function.outer", desc = "Next function start" },
      { keys = "]F", fn = "goto_next_end", capture = "@function.outer", desc = "Next function end" },
      { keys = "[f", fn = "goto_previous_start", capture = "@function.outer", desc = "Prev function start" },
      { keys = "[F", fn = "goto_previous_end", capture = "@function.outer", desc = "Prev function end" },
      { keys = "]c", fn = "goto_next_start", capture = "@class.outer", desc = "Next class start" },
      { keys = "]C", fn = "goto_next_end", capture = "@class.outer", desc = "Next class end" },
      { keys = "[c", fn = "goto_previous_start", capture = "@class.outer", desc = "Prev class start" },
      { keys = "[C", fn = "goto_previous_end", capture = "@class.outer", desc = "Prev class end" },
    }
    -- Wrapped in pcall: nvim-treesitter-textobjects (main) errors with
    -- "arithmetic on local 'score' (a nil value)" in buffers whose language
    -- has no matching capture (e.g. `]f` in a JSON file). Swallow that so the
    -- motion becomes a silent no-op instead of a scary traceback.
    for _, m in ipairs(moves) do
      vim.keymap.set({ "n", "x", "o" }, m.keys, function()
        pcall(move[m.fn], m.capture, "textobjects")
      end, { desc = m.desc })
    end
  end,
}
