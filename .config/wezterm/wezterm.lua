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
	},

	-- Allow pasting from the clipboard with right-click
	{
		event = { Down = { streak = 1, button = "Right" } },
		mods = "NONE",
		action = act.PasteFrom 'Clipboard',
		mouse_reporting = true -- this is needed so nvim receives the moust event
	},
}

config.color_scheme = 'Gruvbox dark, soft (base16)'
config.font = wezterm.font 'JetBrains Mono'

return config
