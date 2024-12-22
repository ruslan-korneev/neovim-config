return {
  -- lang
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.docker" },

  -- ai
  { import = "lazyvim.plugins.extras.ai.codeium" },

  -- ui
  { import = "lazyvim.plugins.extras.ui.mini-animate" },

  -- formatting
  { import = "lazyvim.plugins.extras.formatting.prettier" },
  { import = "lazyvim.plugins.extras.formatting.black" },

  -- lsp
  { import = "lazyvim.plugins.extras.lsp.none-ls" },

  -- coding
  { import = "lazyvim.plugins.extras.coding.blink" },
  { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
}
