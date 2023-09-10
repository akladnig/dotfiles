local wezterm = require 'wezterm'

-- This is the module table that we will export

local module = {}

-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
function module.apply_to_config(config)
	-- For example, changing the color scheme:
	-- config.color_scheme = 'shades-of-purple'
	config.color_scheme = "Catppuccin Mocha"
	-- config.color_scheme = "Dracula (Official)"

	config.colors = {
		-- The default text color
		-- foreground = "silver",
		-- The default background color
		background = "#211B41",

		ansi = {
			'#45475a',
			'#f38ba8',
			'#a6e3a1',
			'#f9e2af',
			'#89b4fa',
			'#cba6f7',
			'#94e2d5',
			'#bac2de',
		},
		brights = {
			'#585b70',
			'#f38ba8',
			'#a6e3a1',
			'#f9e2af',
			'#89b4fa',
			'#be94f9',
			'#94e2d5',
			'#a6adc8',
		},
	}
	config.font_size = 13
	config.font = wezterm.font_with_fallback {
		{ family = 'JetBrains Mono', weight = "Bold", italic = false, },
		"Broot Icons Visual Studio Code",
	}
	-- config.font = wezterm.font("vscode", { italic = false })
end

return module
