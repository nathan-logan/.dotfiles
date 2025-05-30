return {
    "windwp/nvim-ts-autotag",
    lazy = false,
    config = function()
        require("nvim-ts-autotag").setup({
            enable_close = true,          -- Auto close tags
            enable_rename = true,         -- Auto rename pairs of tags
            enable_close_on_slash = true, -- Auto close on trailing </
        })
    end
}
