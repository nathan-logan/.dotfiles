require('typescript-tools').setup {
  -- on_attach = function() end,
  settings = {
    -- spawn additional tsserver instance to calculate diagnostics on it
    separate_diagnostic_server = true,
    -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    publish_diagnostic_on = 'insert_value',
    -- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
    -- "remove_unused_imports"|"organize_imports") -- or string "all"
    -- to include all supported code actions
    -- specify commands exposed as code_actions
    expose_as_code_action = {},
    -- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file under path
    -- not exists then standard path resolution strategy is applied
    tsserver_path = nil,
    -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    -- (see 💅 `styled-components` support section)
    tsserver_plugins = {},
    -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    -- memory limit in megabytes or "auto"(basically no limit)
    tsserver_max_memory = 'auto',
    -- described below
    tsserver_format_options = {},
    tsserver_file_preferences = {},
    -- locale of all tsserver messages, supported locales you can find here:
    -- https://github.com/microsoft/TypeScript/blob/3c221fc086be52b19801f6e8d82596d04607ede6/src/compiler/utilitiesPublic.ts#L620
    tsserver_locale = 'en',
    -- mirror of VSCode's `typescript.suggest.completeFunctionCalls`
    complete_function_calls = false,
    include_completions_with_insert_text = true,
    -- CodeLens
    -- WARNING: Experimental feature also in VSCode, because it might hit performance of server.
    -- possible values: ("off"|"all"|"implementations_only"|"references_only")
    code_lens = 'off',
    -- by default code lenses are displayed on all referencable values and for some of you it can
    -- be too much this option reduce count of them by removing member references from lenses
    disable_member_code_lens = true,
    -- JSXCloseTag
    -- WARNING: it is disabled by default (maybe you configuration or distro already uses nvim-ts-autotag,
    -- that maybe have a conflict if enable this feature. )
    jsx_close_tag = {
      enable = false,
      filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
    },
  },
}

local nmap = function(keys, func, desc)
  if desc then
    desc = 'TS [T]ools: ' .. desc
  end

  vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
end

-- TSToolsOrganizeImports - sorts and removes unused imports
-- TSToolsSortImports - sorts imports
-- TSToolsRemoveUnusedImports - removes unused imports
-- TSToolsRemoveUnused - removes all unused statements
-- TSToolsAddMissingImports - adds imports for all statements that lack one and can be imported
-- TSToolsFixAll - fixes all fixable errors
-- TSToolsGoToSourceDefinition - goes to source definition (available since TS v4.7)
-- TSToolsRenameFile - allow to rename current file and apply changes to connected files
-- TSToolsFileReferences - find files that reference the current file (available since TS v4.2)
nmap('<leader>ti', vim.cmd.TSToolsAddMissingImports, 'Add Missing [I]mports')
nmap('<leader>to', vim.cmd.TSToolsOrganizeImports, '[O]rganise & Sort Imports')
nmap('<leader>tu', vim.cmd.TSToolsRemoveUnusedImports, 'Remove [U]nused Imports')
nmap('<leader>tr', vim.cmd.TSToolsRenameFile, '[R]ename File & and other imports')
nmap('<leader>ta', vim.cmd.TSToolsFixAll, '[A]uto-fix')
nmap('<leader>tf', vim.cmd.TSToolsFileReferences, '[F]ind File References')
