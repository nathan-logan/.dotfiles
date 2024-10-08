local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

local function custom_attach()
  require("lsp_signature").on_attach({
    bind = true,
    use_lspsaga = false,
    floating_window = true,
    fix_pos = true,
    hint_enable = true,
    hi_parameter = "Search",
    handler_opts = { "double" },
  })
end

local ahk2_configs = {
  autostart = true,
  cmd = {
    "node",
    vim.fn.expand("$HOME/vscode-autohotkey2-lsp/server/dist/server.js"),
    "--stdio"
  },
  filetypes = { "ahk", "autohotkey", "ah2" },
  init_options = {
    locale = "en-us",
    InterpreterPath = "C:/Program Files/AutoHotkey/v2/AutoHotkey.exe",
    -- Same as initializationOptions for Sublime Text4, convert json literal to lua dictionary literal
  },
  single_file_support = true,
  flags = { debounce_text_changes = 500 },
  capabilities = capabilities,
  -- on_attach = custom_attach,
}
local configs = require "lspconfig.configs"
configs["ahk2"] = { default_config = ahk2_configs }
local nvim_lsp = require("lspconfig")
nvim_lsp.ahk2.setup({})
