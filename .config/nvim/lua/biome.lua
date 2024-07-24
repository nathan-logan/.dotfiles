local is_biome_avail = function()
  local current_buffer_path = vim.api.nvim_buf_get_name(0)

  local formatter_config_path = vim.fs.find('biome.json', {
    path = current_buffer_path,
    stop = vim.loop.os_homedir(),
    upward = true,
  })

  return formatter_config_path[1] ~= nil
end

local run_biome_linter = function()
  local current_buffer_path = vim.api.nvim_buf_get_name(0)

  local args = "lint --write " .. current_buffer_path
  vim.cmd("silent !biome " .. args)
end

return { is_biome_avail = is_biome_avail, run_biome_linter = run_biome_linter }
