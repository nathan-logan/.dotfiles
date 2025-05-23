return {
    "luukvbaal/nnn.nvim",
    config = function()
        require("nnn").setup({
            picker = {
                cmd = "tmux new-session nnn -Pp",
                style = { border = "rounded" },
                session = "shared",
                offset = true
            },
            replace_netrw = "picker",
        })
    end
}
