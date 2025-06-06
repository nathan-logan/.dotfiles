vim.opt.tabstop = 2
vim.opt.shiftwidth = 2                 -- indent_size = 2
vim.opt.softtabstop = -1               -- Often set the same as shiftwidth for consistency
vim.opt.expandtab = true               -- indent_style = space
vim.opt.autoindent = true              -- Enable auto-indentation
vim.opt.smartindent = true             -- Enable smarter auto-indentation
vim.opt.backspace = "indent,eol,start" -- Better backspace behavior

-- Set space as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Save undo history
vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 15

-- Makes theme colours look correct
vim.o.termguicolors = true

vim.opt.hlsearch = false

-- Code block folding
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.colorcolumn = "81"

-- Set the spell-check language to Australian English
vim.o.spelllang = "en_au"
