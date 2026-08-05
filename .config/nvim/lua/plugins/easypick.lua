return {
    'axkirillov/easypick.nvim',
    dependencies = 'nvim-telescope/telescope.nvim',
    cmd = 'Easypick',
    config = function()
        local easypick = require('easypick')
        local telescope_utils = require('telescope.utils')
        local telescope_conf = require('telescope.config').values

        -- Telescope's own path formatter, so these pickers look like the built-in
        -- file ones (filename first, directory dimmed). It hands back the string
        -- plus its highlight ranges, which is why `display` below is a function
        -- and not a plain string.
        local function display_path(entry)
            return telescope_utils.transform_path({ path_display = telescope_conf.path_display }, entry.value)
        end

        -- `value` is both what the sorter filters on and what the previewer hands
        -- to git, so it has to stay a usable path. `ordinal` keeps filtering on the
        -- full path even though the display is reshuffled.
        local function file_entry(file)
            return {
                value = file,
                display = display_path,
                ordinal = file,
            }
        end

        local function status_entry(line)
            -- Porcelain lines are `XY path`: two status columns, a separator, then
            -- the file. Anything that doesn't fit that shape goes through as-is.
            local status, file = line:match('^(..).(.*)$')
            if not file then
                return file_entry(line)
            end

            -- Renames read as `old -> new`; keep the new path.
            file = file:match('.* %-> (.*)') or file
            -- Paths containing spaces or control characters come back quoted.
            file = file:match('^"(.*)"$') or file

            -- `git status --porcelain` paths are repo-root relative, but the diff
            -- previewer resolves its pathspec against nvim's cwd, so rebase onto it.
            local cwd = vim.uv.cwd()
            local absolute = (vim.fs.root(cwd, '.git') or cwd) .. '/' .. file

            local entry = file_entry(vim.fn.fnamemodify(absolute, ':.'))
            -- Opening the file uses the absolute path, so a picker run from a
            -- subdirectory still lands on the right buffer.
            entry.path = absolute
            -- file_diff branches on this: `??` and `A ` show the whole file, since
            -- there is nothing in HEAD to diff against. Everything else gets a diff.
            entry.status = status

            return entry
        end

        easypick.setup({
            pickers = {
                {
                    name = 'changed_files',
                    command = 'git status --porcelain --untracked-files=all',
                    entry_maker = status_entry,
                    previewer = easypick.previewers.file_diff(),
                },
                {
                    name = 'conflicts',
                    command = 'git diff --name-only --diff-filter=U --relative',
                    entry_maker = file_entry,
                    previewer = easypick.previewers.file_diff(),
                },
            },
        })
    end,
}
