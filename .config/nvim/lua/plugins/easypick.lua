return {
    'axkirillov/easypick.nvim',
    dependencies = 'nvim-telescope/telescope.nvim',
    cmd = 'Easypick',
    config = function()
        local easypick = require('easypick')

        easypick.setup({
            pickers = {
                {
                    name = 'changed_files',
                    command = 'git diff --name-only --relative HEAD',
                    previewer = easypick.previewers.file_diff(),
                },
                {
                    name = 'conflicts',
                    command = 'git diff --name-only --diff-filter=U --relative',
                    previewer = easypick.previewers.file_diff(),
                },
            },
        })
    end,
}
