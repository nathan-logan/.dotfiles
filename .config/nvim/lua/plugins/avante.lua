return {
    "yetone/avante.nvim",
    build = "make",
    event = "VeryLazy",
    version = false,
    ---@module 'avante'
    ---@type avante.Config
    opts = {
        provider = "openai",
        auto_suggestions_provider = "openai-gpt-4o-mini",
        providers = {
            ---@type AvanteSupportedProvider
            openai = {
                endpoint = "https://api.openai.com/v1",
                model = "gpt-5-mini-2025-08-07",
                timeout = 30000,
                context_window = 4096,
                extra_request_body = {
                    temperature = 0.5,
                    max_completion_tokens = 2048,
                    reasoning_effort = "medium",
                },
            },
            ---@type AvanteSupportedProvider
            gemini = {
                model = "gemini-2.5-flash",
                timeout = 20000,
                extra_request_body = {
                    temperature = 0.6,
                    max_tokens = 2048,
                },
            },
            ["openai-gpt-4o-mini"] = {
                __inherited_from = "openai",
                model = "gpt-4o-mini",
            },
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
