require("conform").setup({
  formatters_by_ft = {
    typescript = { "biome", "prettier", stop_after_first = true },
    typescriptreact = { "biome", "prettier", stop_after_first = true },
    javascript = { "biome", "prettier", stop_after_first = true },
    javascriptreact = { "biome", "prettier", stop_after_first = true },
    json = { "prettier", stop_after_first = true },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
