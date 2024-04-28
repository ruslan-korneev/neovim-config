---@diagnostic disable: missing-fields
-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("lspconfig").pyright.setup({
  settings = {
    python = {
      analysis = {
        diagnosticSeverityOverrides = {
          reportIncompatibleVariableOverride = "none",
          reportIncompatibleMethodOverride = "none",
        },
      },
    },
  },
})
