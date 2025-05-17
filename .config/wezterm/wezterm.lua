-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you apply your config choices.
config.color_scheme = 'Gruvbox dark, soft (base16)'
config.font = wezterm.font 'JetBrains Mono'

-- Finally, return the configuration to wezterm:
return config
