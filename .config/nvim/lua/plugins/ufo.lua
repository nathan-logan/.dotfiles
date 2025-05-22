-- Code block folding
return {
  'kevinhwang91/nvim-ufo',
  dependencies = {
    'kevinhwang91/promise-async',
  },
opts = {},
keys = {
    { "zR", function() require("ufo").openAllFolds() end, mode = "n", desc = "Open All Folds" },
    { "zM", function() require("ufo").closeAllFolds() end, mode = "n", desc = "Close All Folds" },
  },
--confg = function()
--local ufo = require("ufo")
--ufo.setup({})
--vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open All Folds" })
    --vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close All Folds" })
--end
}
