local keyset = vim.keymap.set
local opts = { noremap = true, silent = false }

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

keyset("i", "<C-s>", function() vim.lsp.buf.signature_help() end, opts)

-- ZK KEYBINDS https://github.com/zk-org/zk-nvim#example-mappings
-- Create a new note after asking for its title.
keyset("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
-- Open notes.
keyset("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
-- Open notes associated with the selected tags.
keyset("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)
-- Search for the notes matching a given query.
keyset("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)
-- Search for the notes matching the current visual selection.
keyset("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)

keyset("n", "<leader>p", "<Cmd>NnnPicker %:p:h<CR>",
	{ desc = "Explore the current [p]roject", silent = false, noremap = true })
