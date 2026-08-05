return {
    'axkirillov/easypick.nvim',
    dependencies = 'nvim-telescope/telescope.nvim',
    cmd = 'Easypick',
    config = function()
        local easypick = require('easypick')

        -- Reads a local ref; `git remote show origin` would hit the network (~2.5s).
        local function default_branch()
            local ref = vim.fn.system('git symbolic-ref --short refs/remotes/origin/HEAD 2>/dev/null')
            local branch = vim.trim(ref):gsub('^origin/', '')
            return branch ~= '' and branch or 'main'
        end

        local base = default_branch()

        easypick.setup({
            pickers = {
                {
                    name = 'changed_files',
                    command = 'git diff --name-only --relative $(git merge-base HEAD ' .. base .. ')',
                    previewer = easypick.previewers.branch_diff({ base_branch = base }),
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
