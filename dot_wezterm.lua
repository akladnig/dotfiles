-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- Enable the scrollbar.
-- It will occupy the right window padding space.
-- If right padding is set to 0 then it will be increased
-- to a single cell width
config.enable_scroll_bar = true

config.keys = {
	{
		key = "]",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(1),
	},
	{
		key = "[",
		mods = "CMD",
		action = wezterm.action.ActivateTabRelative(-1),
	},
}
-- For example, changing the color scheme:
-- config.color_scheme = 'shades-of-purple'
-- config.color_scheme = "catppuccin-mocha"
config.color_scheme = "Dracula (Official)"
config.colors = {
	-- The default text color
	foreground = "silver",
	-- The default background color
	background = "#211B41",
}

local mux = wezterm.mux
-- Start wezterm maximized
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = false })
-- config.font = wezterm.font("FiraCode", { weight = "Medium", italic = false })
config.font_size = 13

-- and finally, return the configuration to wezterm
return config
