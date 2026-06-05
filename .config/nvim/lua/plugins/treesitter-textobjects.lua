return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  branch = 'main',
  lazy = false,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require('nvim-treesitter-textobjects').setup {
      select = {
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
      },
      move = {
        -- whether to set jumps in the jumplist
        set_jumps = true,
      },
    }

    -- select: you can use the capture groups defined in textobjects.scm
    local select_maps = {
      ['aa'] = '@parameter.outer',
      ['ia'] = '@parameter.inner',
      ['af'] = '@function.outer',
      ['if'] = '@function.inner',
      ['ac'] = '@class.outer',
      ['ic'] = '@class.inner',
    }
    for keys, capture in pairs(select_maps) do
      vim.keymap.set({ 'x', 'o' }, keys, function()
        require('nvim-treesitter-textobjects.select').select_textobject(capture, 'textobjects')
      end)
    end

    -- move
    local move_maps = {
      goto_next_start = { [']m'] = '@function.outer', [']]'] = '@class.outer' },
      goto_next_end = { [']M'] = '@function.outer', ['][' ] = '@class.outer' },
      goto_previous_start = { ['[m'] = '@function.outer', ['[['] = '@class.outer' },
      goto_previous_end = { ['[M'] = '@function.outer', ['[]'] = '@class.outer' },
    }
    for fn, maps in pairs(move_maps) do
      for keys, capture in pairs(maps) do
        vim.keymap.set({ 'n', 'x', 'o' }, keys, function()
          require('nvim-treesitter-textobjects.move')[fn](capture, 'textobjects')
        end)
      end
    end
  end,
}
