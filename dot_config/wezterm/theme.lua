
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
	config.color_scheme = "catppuccin-mocha"
	-- config.color_scheme = "Dracula (Official)"
	config.colors = {
		-- The default text color
		foreground = "silver",
		-- The default background color
		background = "#211B41",
	}
	config.font = wezterm.font("JetBrains Mono", { weight = "Bold", italic = false })
	-- config.font = wezterm.font("FiraCode", { weight = "Medium", italic = false })
	config.font_size = 13

end

return module
