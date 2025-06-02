return {
    "luukvbaal/nnn.nvim",
    config = function()
        require("nnn").setup({
            picker = {
                cmd = "tmux new-session nnn -Pp",
                style = { width = 1, height = 0.95, xoffset = 0, yoffset = 0, border = "rounded" },
                session = "shared",
                offset = true
            },
            replace_netrw = "picker",
        })
    end
}
