require('codecompanion').setup({
  strategies = {
    chat = {
      adapter = "gemini",
    },
    inline = {
      adapter = "gemini",
      keymaps = {
        accept_change = {
          modes = { n = "<Space>a" },
          description = "Accept the suggested change",
        },
        reject_change = {
          modes = { n = "<Space>r" },
          description = "Reject the suggested change",
        },
      },
    },
  },
  adapters = {
    gemini = function()
      return require("codecompanion.adapters").extend("gemini", {
        env = {
          api_key = "cmd: gpg --batch --quiet --decrypt /home/nathan/gemini_api_key.txt.gpg",
        },
      })
    end,
  },
  display = {
    inline = {
      layout = "vertical"
    },
    diff = {
      enabled = true,
      close_chat_at = 240,    -- Close an open chat buffer if the total columns of your display are less than...
      layout = "vertical",    -- vertical|horizontal split for default provider
      opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
      provider = "mini_diff", -- default|mini_diff
    },
  },
})
