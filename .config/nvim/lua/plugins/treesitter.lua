return {
  "nvim-treesitter/nvim-treesitter",
  branch = 'main',
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require('nvim-treesitter').install { 'go', 'lua', 'tsx', 'css', 'typescript', 'vimdoc', 'vim', 'html', 'markdown', 'markdown_inline', 'xml', 'yaml', 'json', 'bash', 'fish' }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'go', 'lua', 'typescript', 'typescriptreact', 'html', 'markdown', 'vim' },
      callback = function()
        vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })
  end
}
