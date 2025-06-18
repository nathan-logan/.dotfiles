return {
    "sindrets/diffview.nvim",
    config = function()
        local keyset = vim.keymap.set

        vim.api.nvim_set_hl(0, "DiffText", { bg = "#1d3b40" })

        keyset('n', '<leader>dv', '<cmd>DiffviewOpen<CR>',
            { desc = "Opens the Diffview window", noremap = true, silent = false })
        keyset('n', '<leader>dc', '<cmd>DiffviewClose<CR>',
            { desc = "Closes the Diffview window", noremap = true, silent = false })
    end
}
