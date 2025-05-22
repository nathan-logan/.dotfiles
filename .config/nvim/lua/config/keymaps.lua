local keyset = vim.keymap.set

keyset("n", "<tab>", ":bn<CR>", { desc = "Next Buffer" })
keyset("n", "<S-tab>", ":bp<CR>", { desc = "Previous Buffer" })

keyset('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keyset('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keyset('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keyset('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
keyset('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Move lines up or down in visual mode
keyset("v", "J", ":m '>+1<CR>gv=gv")
keyset("v", "K", ":m '<-2<CR>gv=gv")

-- TIP: Disable arrow keys in normal mode
keyset('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
keyset('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
keyset('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
keyset('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
keyset('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keyset('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keyset('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keyset('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Quickfix list helpers
keyset('n', ']q', '<cmd>cn<CR>', { desc = 'Next Quickfix list item' })
keyset('n', '[q', '<cmd>cp<CR>', { desc = 'Previous Quickfix list item' })

keyset('i', '<C-e>', '<C-o>de', { desc = "Delete the word after the cursor" })

keyset("i", "<C-s>", function() vim.lsp.buf.signature_help() end, { noremap = true, silent = true })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
