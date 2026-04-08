return {
  "Exafunction/windsurf.vim",
  event = "InsertEnter",
  cmd = "Codeium",
  init = function()
    vim.g.codeium_disable_bindings = 1
    vim.g.codeium_no_map_tab = 1
  end,
  config = function()
    local map = vim.keymap.set
    local opts = { expr = true, silent = true, replace_keycodes = false }
    map("i", "<C-g>", function() return vim.fn["codeium#Accept"]() end,
      vim.tbl_extend("force", opts, { desc = "Codeium accept" }))
    map("i", "<M-]>", function() return vim.fn["codeium#CycleCompletions"](1) end,
      vim.tbl_extend("force", opts, { desc = "Codeium next" }))
    map("i", "<M-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end,
      vim.tbl_extend("force", opts, { desc = "Codeium prev" }))
    map("i", "<C-]>", function() return vim.fn["codeium#Clear"]() end,
      vim.tbl_extend("force", opts, { desc = "Codeium clear" }))
  end,
}
