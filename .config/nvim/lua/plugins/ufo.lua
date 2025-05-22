-- Code block folding
return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
    "kevinhwang91/promise-async",
  },
  opts = {},
  keys = {
    { "zR", function() require("ufo").openAllFolds() end,  mode = "n", desc = "Open All Folds" },
    { "zM", function() require("ufo").closeAllFolds() end, mode = "n", desc = "Close All Folds" },
  },
}
