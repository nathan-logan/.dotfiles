require("options")
require("bootstrap")
require("plugins")
require("lsp")
require("keymaps")

vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#363433" })

-- Disable NVIM right click context menu
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.api.nvim_command([[aunmenu PopUp]])
		vim.api.nvim_command([[autocmd! nvim.popupmenu]])
	end
})
