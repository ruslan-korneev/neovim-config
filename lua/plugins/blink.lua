return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  opts = {
    keymap = {
      preset = "none",
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"]     = { "hide", "fallback" },
      ["<CR>"]      = { "accept", "fallback" },
      ["<C-b>"]     = { "scroll_documentation_up", "fallback" },
      ["<C-f>"]     = { "scroll_documentation_down", "fallback" },
      ["<C-n>"]     = { "select_next", "fallback" },
      ["<C-p>"]     = { "select_prev", "fallback" },
      ["<Tab>"]     = { "select_next", "fallback" },
      ["<S-Tab>"]   = { "select_prev", "fallback" },
    },
    appearance = { nerd_font_variant = "mono" },
    completion = {
      accept = { auto_brackets = { enabled = true } },
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = { border = "rounded" },
      list = { selection = { preselect = false, auto_insert = true } },
    },
    signature = { enabled = true, window = { border = "rounded" } },
    sources = { default = { "lsp", "path", "buffer" } },
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
