return {
  "olimorris/codecompanion.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    strategies = {
      chat = {
        adapter = "openai",
      },
      inline = {
        adapter = "openai",
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
      openai = function()
        return require("codecompanion.adapters").extend("openai", {
          env = {
            api_key = "OPENAI_API_KEY",
          },
          schema = {
            model = {
              default = "gpt-5-mini"
            }
          }
        })
      end,
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "GEMINI_API_KEY",
          },
          schema = {
            model = {
              default = "gemini-2.5-flash-preview-05-20"
            }
          }
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
      ["Generate Prod PR Ticket Links"] = {
        strategy = "chat",
        description = "Generate a list of Jira ticket links based on the diff between staging & production branches",
        opts = {
          auto_submit = true,
        },
        prompts = {
          {
            role = "user",
            content = function()
              local git_diff = vim.fn.system("git log --oneline origin/production..origin/staging")

              return [[
              Can you extract the ticket identifiers from this git commit log and compile them into a list of links. Each link should be formatted as markdown like this: [<ticket_number>](https://puntaa.atlassian.net/browse/<ticket_number>). Return only the list of links, no other words.

              ```
              diff
              ]] .. git_diff .. [[
              ```
            ]]
            end
          }
        }
      },
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
                  [[You are an expert at following the Conventional Commit specification. Given the diff and branch name listed below generate me a commit message:

```diff
]] .. vim.fn.system("git diff --cached -- ':!*_Generated.ts'") .. [[
```

Current branch name: ]] .. vim.fn.system("git rev-parse --abbrev-ref HEAD") .. [[

Follow the following format to write the commit message, get the ticket number from the git branch name above: {feat|bug|fix|refactor|chore}({ticket number}): {Summary of changes}

  {List of details if necessary using bullets}

Return the code only and no markdown codeblocks.
                    ]]
            end,
          },
        },
      }
    }
  },
  keys = {
    { "<leader>aic", function() require("codecompanion").chat() end,    mode = "n", desc = "Open a New Code Companion [C]hat" },
    { "<leader>aia", function() require("codecompanion").actions() end, mode = "n", desc = "Show the Code Companion [A]ctions" },
  },
}
