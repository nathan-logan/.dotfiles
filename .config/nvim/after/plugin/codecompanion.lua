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
          api_key = "cmd: bw get notes \"Google AI API Key\"",
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
  prompt_library = {
    ["Auto-generate git commit message"] = {
      strategy = "inline",
      description = "Generate git commit message for current staged changes",
      opts = {
        mapping = "<LocalLeader>aim",
        placement = "before|false"
      },
      prompts = {
        {
          role = "user",
          contains_code = true,
          content = function()
            return
                [[You are an expert at following the Conventional Commit specification                       based on the following diff:
]] .. vim.fn.system("git diff --cached") .. [[

Current branch name: ]] .. vim.fn.system("git rev-parse --abbrev-ref HEAD") .. [[

Generate a commit message for me. Follow the following format to write the commit message, get the ticket number from the git branch name above:

  {feat|bug|fix|refactor|chore}({ticket number}): {Summary of changes}

  {List of details if necessary using bullets}

Return the code only and no markdown codeblocks.
                    ]]
          end,
        },
      },
    }
  }
})
