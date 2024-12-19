-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Appearance
config.color_scheme = "GruvboxDark"
config.font = wezterm.font("0xProto Nerd Font")
config.line_height = 1.2
config.font_size = 16.0
-- config.window_background_opacity = 0.95
config.macos_window_background_blur = 80

config.window_close_confirmation = "NeverPrompt"

-- Make it run faster
config.max_fps = 240
config.animation_fps = 240

-- Multiplexing
config.unix_domains = {
	{
		name = "unix",
	},
}
config.default_gui_startup_args = { "connect", "unix" }

-- Keyboard shortcuts and natural text editing
config.keys = {
	-- Make Option-Left equivalent to Alt-b which many line editors interpret as backward-word
	{
		key = "LeftArrow",
		mods = "OPT",
		action = wezterm.action({ SendKey = { key = "b", mods = "ALT" } }),
	},
	-- Make Option-Right equivalent to Alt-f; forward-word
	{
		key = "RightArrow",
		mods = "OPT",
		action = wezterm.action({ SendKey = { key = "f", mods = "ALT" } }),
	},
	-- Make Command-Delete equivalent to Ctrl-u; kill-line
	{
		key = "Backspace",
		mods = "CMD",
		action = wezterm.action({ SendKey = { key = "u", mods = "CTRL" } }),
	},
	-- Select next tab with cmd-opt-left/right arrow
	{
		key = "LeftArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	{
		key = "RightArrow",
		mods = "CMD|OPT",
		action = wezterm.action.ActivateTabRelative(1),
	},
	-- Select next pane with cmd-left/right arrow
	{
		key = "LeftArrow",
		mods = "CMD",
		action = wezterm.action({ ActivatePaneDirection = "Prev" }),
	},
	{
		key = "RightArrow",
		mods = "CMD",
		action = wezterm.action({ ActivatePaneDirection = "Next" }),
	},
	-- Close current pane with cmd+w
	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
}

-- Help it run on some machines
config.front_end = "WebGpu"

-- and finally, return the configuration to wezterm
return config
