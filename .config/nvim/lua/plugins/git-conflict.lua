return {
  "akinsho/git-conflict.nvim",
  version = "*",
  config = function()
    vim.api.nvim_set_hl(0, "DiffCurrent", { fg = "#ffffff", bg = "#1d3b40" })
    vim.api.nvim_set_hl(0, "DiffIncoming", { fg = "#ffffff", bg = "#21401d" })
    require("git-conflict").setup {
      default_mappings = true,     -- disable buffer local mapping created by this plugin
      default_commands = true,     -- disable commands created by this plugin
      disable_diagnostics = false, -- This will disable the diagnostics in a buffer whilst it is conflicted
      list_opener = "copen",
      debug = false,
      highlights = {
        incoming = "DiffIncoming",
        current = "DiffCurrent",
      },
    }
  end,
}
