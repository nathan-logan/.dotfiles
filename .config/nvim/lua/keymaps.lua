local setkeymap = vim.keymap.set
local ufo = require('ufo')

setkeymap('n', '<Esc>', '<cmd>nohlsearch<CR>')
setkeymap('n', '<leader>bD', '<cmd>%bd<CR>', { desc = "Close all currently open buffers" })

-- Code folding
setkeymap('n', 'zR', ufo.openAllFolds)
setkeymap('n', 'zM', ufo.closeAllFolds)

-- Telescope git keymaps
setkeymap('n', '<leader>gs', '<cmd>Telescope git_status<CR>', { desc = 'Show Telescope\'s [g]it [s]tatus' })

-- Diagnostic keymaps
setkeymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
setkeymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
setkeymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
setkeymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Move lines up or down in visual mode
setkeymap("v", "J", ":m '>+1<CR>gv=gv")
setkeymap("v", "K", ":m '<-2<CR>gv=gv")

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
setkeymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
setkeymap('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
setkeymap('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
setkeymap('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
setkeymap('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
setkeymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
setkeymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
setkeymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
setkeymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

setkeymap('i', '<C-e>', '<C-o>de', { desc = "Delete the word after the cursor" })

--  See `:help lua-guide-autocommands`

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
