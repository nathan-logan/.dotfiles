local function filenameFirst(_, path)
  local tail = require("telescope.utils").path_tail(path)
  local parent = vim.fn.fnamemodify(path, ":.:h")
  if parent == "." then
    return tail
  end
  return string.format("%s\t\t%s", tail, parent)
end

return {
  "nvim-telescope/telescope.nvim",
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    { 'smartpde/telescope-recent-files' },
  },
  opts = {
    defaults = {
      file_ignore_patterns = { "node_modules", ".yarn", ".git" },
    },
    pickers = {
      find_files = {
        hidden = true,
        path_display = filenameFirst,
      },
      lsp_references = {
        layout_strategy = "vertical",
        fname_width = 80,
        path_display = filenameFirst,
      },
      live_grep = {
        layout_strategy = "vertical",
        fname_width = 80,
        path_display = filenameFirst,
      },
    },
    extensions = {
      ["ui-select"] = require("telescope.themes").get_dropdown(),
    },
  },
  config = function(_, opts)
    local ts = require("telescope")
    ts.setup(opts)

    -- Load extensions safely
    pcall(ts.load_extension, "fzf")
    pcall(ts.load_extension, "ui-select")
    pcall(ts.load_extension, "recent_files")

    -- Autocmd for TelescopeResults highlighting
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "TelescopeResults",
      callback = function(ctx)
        vim.api.nvim_buf_call(ctx.buf, function()
          vim.fn.matchadd("TelescopeParent", "\t\t.*$")
          vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
        end)
      end,
    })
  end,
  keys = {
    { "<leader>sh",       "<cmd>Telescope help_tags<cr>",                                     desc = "[S]earch [H]elp" },
    { "<leader>sk",       "<cmd>Telescope keymaps<cr>",                                       desc = "[S]earch [K]eymaps" },
    { "<C-p>",            "<cmd>Telescope find_files<cr>",                                    desc = "[S]earch [F]iles" },
    { "<leader>sf",       "<cmd>Telescope find_files<cr>",                                    desc = "[S]earch [F]iles" },
    { "<leader>ss",       "<cmd>Telescope builtin<cr>",                                       desc = "[S]earch [S]elect Telescope" },
    { "<leader>sw",       "<cmd>Telescope grep_string<cr>",                                   desc = "[S]earch current [W]ord" },
    { "<leader>sg",       "<cmd>Telescope live_grep<cr>",                                     desc = "[S]earch by [G]rep" },
    { "<leader>sd",       "<cmd>Telescope diagnostics<cr>",                                   desc = "[S]earch [D]iagnostics" },
    { "<leader>sr",       "<cmd>Telescope resume<cr>",                                        desc = "[S]earch [R]esume" },
    { "<leader>s.",       "<cmd>Telescope oldfiles<cr>",                                      desc = '[S]earch Recent Files ("." for repeat)' },
    { "<leader><leader>", "<cmd>lua require('telescope').extensions.recent_files.pick()<cr>", desc = "Show recently closed buffers" },
    { "<leader>gs",       "<cmd>Telescope git_status<cr>",                                    desc = "Show Telescope's [g]it [s]tatus" },
    {
      "<leader>/",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find(
          require("telescope.themes").get_dropdown {
            winblend = 10,
            previewer = false,
          }
        )
      end,
      desc = "[/] Fuzzily search in current buffer",
    },
    {
      "<leader>s/",
      function()
        require("telescope.builtin").live_grep {
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        }
      end,
      desc = "[S]earch [/] in Open Files",
    },
    {
      "<leader>sn",
      function()
        require("telescope.builtin").find_files { cwd = vim.fn.stdpath "config" }
      end,
      desc = "[S]earch [N]eovim files",
    },
  },
}
