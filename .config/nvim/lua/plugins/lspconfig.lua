return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "yioneko/nvim-vtsls",

    { "j-hui/fidget.nvim", opts = {} },
    { "folke/neodev.nvim", opts = {} },
  },
  config = function()
    local nmap = vim.keymap.set;
    local lspconfig = require("lspconfig")

    local function rename_file(client)
      -- Get the current buffer's file path
      local old_path = vim.api.nvim_buf_get_name(0)

      -- Prompt for the new file name
      local new_path = vim.fn.input("New file name: ", old_path)

      -- Cancel if no input was provided
      if new_path == "" or new_path == old_path then
        print("File rename cancelled")
        return
      end

      -- Convert paths to URIs for the LSP
      local old_uri = vim.uri_from_fname(old_path)
      local new_uri = vim.uri_from_fname(new_path)

      -- Save the current buffer first
      vim.cmd("write")

      -- Request the typescript server to handle the rename
      client.request("workspace/executeCommand", {
        command = "_typescript.applyRenameFile",
        arguments = {
          {
            sourceUri = old_uri,
            targetUri = new_uri,
          }
        },
      }, function(err)
        if err then
          print("Error renaming file in TypeScript server:", vim.inspect(err))
          return
        end

        -- Set a timer to save all modified buffers after a delay
        -- to ensure TypeScript has time to update all references
        vim.defer_fn(function()
          -- Save all modified buffers
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(buf) then
              local buf_name = vim.api.nvim_buf_get_name(buf)
              if buf_name and buf_name ~= "" then
                vim.api.nvim_buf_call(buf, function()
                  vim.cmd("silent! write")
                end)
              end
            end
          end

          -- Now actually move the file at the filesystem level
          -- Create directory for new file if it doesn't exist
          local new_dir = vim.fn.fnamemodify(new_path, ":h")
          if vim.fn.isdirectory(new_dir) == 0 then
            vim.fn.mkdir(new_dir, "p")
          end

          -- Perform the filesystem rename
          local success = vim.loop.fs_rename(old_path, new_path)
          if not success then
            print("Error: Failed to rename file in filesystem")
            return
          end

          -- Open the new file
          vim.cmd("edit " .. vim.fn.fnameescape(new_path))
          print("File renamed successfully")
        end, 300) -- 300ms delay to ensure TypeScript has time to update all files
      end)
    end

    --- Vim buffer code action helper
    --- @param action string
    local function code_action(action)
      vim.lsp.buf.code_action({
        apply = true,
        context = {
          only = { action },
          diagnostics = {},
        },
      })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        local function buf_set_keymap(mode, lhs, rhs, opts)
          local keymap_opts = opts or {}
          keymap_opts.buffer = bufnr
          keymap_opts.noremap = true
          keymap_opts.silent = true

          -- prefix command descriptions with LSP
          if keymap_opts.desc then
            keymap_opts.desc = "LSP: " .. keymap_opts.desc
          end

          nmap(mode, lhs, rhs, keymap_opts)
        end

        buf_set_keymap("n", "<leader>tu", function()
            code_action("source.removeUnusedImports")
          end,
          { desc = "[T]ypescript Remove [u]nused Imports" })

        buf_set_keymap("n", "<leader>tm", function()
            code_action("source.addMissingImports")
          end,
          { desc = "[T]ypescript add [m]issing imports" })

        buf_set_keymap("n", "<leader>to", function()
            code_action("source.organiseImports")
          end,
          { desc = "[T]ypescript [o]rganise Imports" })

        buf_set_keymap("n", "<leader>tD", function()
            code_action("source.fixAll")
          end,
          { desc = "[T]ypescript fix all [D]iagnostics" })

        buf_set_keymap("n", "<leader>tr", vim.lsp.buf.rename, { desc = "[T]ypescript [R]ename Variable" })
        buf_set_keymap("n", "<leader>tR", function() rename_file(client) end, { desc = "[T]ypescript [R]ename File" })

        buf_set_keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[n]ame" })
        buf_set_keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })
        buf_set_keymap("n", "gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
        buf_set_keymap("n", "gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
        buf_set_keymap("n", "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
        buf_set_keymap("n", "<leader>D", vim.lsp.buf.type_definition, { desc = "Type [D]efinition" })
        buf_set_keymap("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols,
          { desc = "[D]ocument [S]ymbols" })
        buf_set_keymap("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
          { desc = "[W]orkspace [S]ymbols" })
        buf_set_keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
        buf_set_keymap("n", "gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
        buf_set_keymap("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, { desc = "[W]orkspace [A]dd Folder" })
        buf_set_keymap("n", "<leader>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { desc = "[W]orkspace [L]ist Folders" })
      end,
    })

    require('neodev').setup()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    local servers = {
      jsonls = {
        capabilities = capabilities,
      },
      ts_ls = {
        capabilities = capabilities,
      },
      biome = { capabilities = capabilities },
      cssls = {
        capabilities = capabilities,
      },
      tailwindcss = {
        capabilities = capabilities,
        settings = {
          tailwindCSS = {
            experimental = {
              classRegex = {
                {
                  "cva\\(((?:[^()]|\\([^()]*\\))*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]"
                },
                {
                  "cn\\(((?:[^()]|\\([^()]*\\))*)\\)",
                  "(?:'|\"|`)([^']*)(?:'|\"|`)",
                },
                {
                  "(?:\\b(?:const|let|var)\\s+)?[\\w$_]*(?:[Ss]tyles|[Cc]lasses|[Cc]lassnames)[\\w\\d]*\\s*(?:=|\\+=)\\s*['\"]([^'\"]*)['\"]"
                },
                { "ClassName:([^;]*);", "[\"'`]([^\"'`]*).*?[\"'`]" }
              }
            }
          }
        }
      },
      graphql = {
        capabilities = capabilities,
        root_dir = lspconfig.util.root_pattern(".graphqlconfig", ".graphqlrc", "package.json"),
        flags = {
          debounce_text_changes = 150,
        }
      },
      gopls = {
        capabilities = capabilities
      },
      yamlls = { capabilities = capabilities },
      marksman = { capabilities = capabilities },
      lua_ls = {
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            diagnostics = {
              globals = {
                "vim",
                -- luasnip snippet file globals
                "s",
                "sn",
                "isn",
                "t",
                "i",
                "f",
                "c",
                "d",
                "r",
                -- end luasnip
              },
            },
          },
        },
      },
    }

    require("mason").setup()

    local ensure_installed = vim.tbl_keys(servers or {})

    require("mason-lspconfig").setup {
      automatic_installation = true,
      ensure_installed = ensure_installed,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }

    local cmp = require "cmp"
    local luasnip = require "luasnip"
    luasnip.log.set_loglevel "info"
    require("luasnip.loaders.from_lua").lazy_load()
    luasnip.setup {
      store_selection_keys = "<Tab>",
    }
    luasnip.filetype_extend("typescriptreact", { "typescript" })

    cmp.setup {
      enabled = true,
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete {},
        ["<CR>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        per_filetype = {
          codecompanion = { "codecompanion" },
        }
      }
    }
  end
}
