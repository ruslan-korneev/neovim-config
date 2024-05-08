---@diagnostic disable: missing-fields
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
