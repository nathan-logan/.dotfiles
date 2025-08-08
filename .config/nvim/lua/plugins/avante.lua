return {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    version = false,
    ---@module 'avante'
    ---@type avante.Config
    opts = {
        provider = "openai",
        providers = {
            openai = {
                model = "gpt-5-mini",
                timeout = 30000,
                context_window = 4096,
                extra_request_body = {
                    temperature = 1,
                    max_completion_tokens = 1024,
                    reasoning_effort = "minimal",
                },
            }
        },
        behaviour = {
            auto_suggestions = false
        }
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        {
            -- support for image pasting
            "HakonHarnes/img-clip.nvim",
            event = "VeryLazy",
            opts = {
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                },
            },
        },
        {
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { "markdown", "Avante" },
            },
            ft = { "markdown", "Avante" },
        },
    },
}
