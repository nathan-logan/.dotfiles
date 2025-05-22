return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  config = function()
    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IndentColor", { fg = "#464443" })
      -- This is the highlight color of the currently active scope
      vim.api.nvim_set_hl(0, "ActiveIndentColor", { fg = "#5a5958" })
    end)
  end,
  opts = { indent = { highlight = { "IndentColor" } }, scope = { highlight = { "ActiveIndentColor" } } }
}
