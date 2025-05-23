return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  ---@module "render-markdown"
  ---@type render.md.UserConfig,
  opts = {
    file_types = { "markdown" },
    overrides = {
      buftype = {
        nofile = {
          render_modes = false, -- disable rendering markdown in signature help
        }
      }
    }
  }
};
