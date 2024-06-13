require('netrw').setup {
  use_devicons = true,
}

-- vim.keymap.set("n", "<leader>", { desc = "" })

vim.keymap.set(
  'n',
  '<leader>p',
  -- opens netrw with the current file in focus
  ':Ex <bar> :sil! /<C-R>=expand("%:t")<CR><CR>',
  { desc = '[P]roject [E]xplore' }
)
