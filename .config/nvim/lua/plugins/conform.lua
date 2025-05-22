return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  cmd = { 'ConformInfo' },
opts = {
  formatters_by_ft = {
    typescript = { "biome-check", "prettier", stop_after_first = true },
    typescriptreact = { "biome-check", "prettier", stop_after_first = true },
    javascript = { "biome-check", "prettier", stop_after_first = true },
    javascriptreact = { "biome-check", "prettier", stop_after_first = true },
    json = { "biome-check", "prettier", stop_after_first = true },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
},
}
