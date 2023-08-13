local wezterm = require 'wezterm'

local act = wezterm.action

-- This is the module table that we will export

local module = {}

-- define a function in the module table.
-- Only functions defined in `module` will be exported to
-- code that imports this module.
-- The suggested convention for making modules that update
-- the config is for them to export an `apply_to_config`
-- function that accepts the config object, like this:
function module.apply_to_config(config)
	-- config.leader = { key = '+'}
	config.keys = {

		{
			key = "[",
			mods = "CMD",
			action = act.ActivateTabRelative(1),
		},
		{
			key = "]",
			mods = "CMD",
			action = act.ActivateTabRelative(-1),
		},
		{
			key = "[",
			mods = "CTRL",
			action = act.ActivatePaneDirection 'Prev',
		},
		{
			key = "]",
			mods = "CTRL",
			action = act.ActivatePaneDirection 'Next',
		},
		{
			key = "r",
			mods = "CTRL",
			action = act.ActivatePaneDirection 'Right',
		},
		{
			key = "e",
			mods = "CTRL",
			action = act.EmitEvent 'explorer',
		},
		{
			key = "t",
			mods = "CTRL",
			action = act.EmitEvent 'terminal',
		},
		{
			key = "x",
			mods = "CTRL",
			action = act.EmitEvent 'exit-hx',
			-- action = act.CloseCurrentPane { confirm = false },
		},
		{
			key = "z",
			mods = "CTRL",
			action = act.TogglePaneZoomState,
		}
	}
end

-- return our module table
return module

