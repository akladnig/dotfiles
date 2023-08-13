local wezterm = require 'wezterm'

local act = wezterm.action

function PaneExists(paneTitle, paneName)
	return string.find(paneTitle, paneName) ~= nil
end

-- This is the module table that we will export

local module = {}

-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
function module.apply_to_config(config)
	config.set_environment_variables = { PATH = "/opt/homebrew/bin:~/.local/bin:" .. os.getenv('PATH') }

	-- Enable the scrollbar.
	-- It will occupy the right window padding space.
	-- If right padding is set to 0 then it will be increased
	-- to a single cell width
	config.enable_scroll_bar = true
end

return module