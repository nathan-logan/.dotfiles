-- Disable NVIM right click context menu
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.api.nvim_command([[aunmenu PopUp]])
		vim.api.nvim_command([[autocmd! nvim.popupmenu]])
	end
})

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

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	desc = "Open file at the last position it was opened",
	pattern = "*",
	command = 'silent! normal! g`"zv',
})
