-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux
local act = wezterm.action

-- Always launch the terminal maximized
wezterm.on('gui-startup', function()
	local _, _, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

local config = wezterm.config_builder()

config.mouse_bindings = {
	-- Change the default click behavior so that it only selects text and
	-- doesn't open hyperlinks
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'NONE',
		action = act.CompleteSelection 'ClipboardAndPrimarySelection',
	},

	-- Make CTRL-Click open hyperlinks
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'CTRL',
		action = act.OpenLinkAtMouseCursor,
		mouse_reporting = true -- this is needed so nvim/tmux receives the moust event
	},

	-- Allow pasting from the clipboard with right-click
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom 'Clipboard',
		mouse_reporting = true -- this is needed so nvim/tmux receives the moust event
	},
}

config.keys = {
	{ key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
	{ key = 'W', mods = 'CTRL', action = act.CloseCurrentPane { confirm = true } },

	{
		key = 'E',
		mods = 'CTRL|SHIFT',
		action = act.PromptInputLine {
			description = 'Enter new name for tab',
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:active_tab():set_title(line)
				end
			end),
		},
	},
}

config.color_scheme = 'Gruvbox dark, soft (base16)'
config.font = wezterm.font {
	family = 'JetBrains Mono',
	harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }, -- disable ligatures
}
config.font_size = 11.0

return config
