-- Pull in the wezterm API
local wezterm = require("wezterm")
local core = require("core")
local keymap = require("keymap")
local theme = require("theme")
local layout = require("layout")
local exit = require("exit")

local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

core.apply_to_config(config)
keymap.apply_to_config(config)
theme.apply_to_config(config)
layout.apply_to_config(config)
exit.apply_to_config(config)

-- This is where you actually apply your config choices

local mux = wezterm.mux
--[[Start wezterm maximized
	Layout for helix with lf on left and terminal on bottom
	| lf |   hx   k  |
	|    |  Terminal |
-- ]] 

wezterm.on("gui-startup", function(cmd)
	local tab, hxPane, window = mux.spawn_window(cmd or {})
	local lfPane = hxPane:split {
		direction = 'Left',
		size = 40,
	}
	local terminalPane = hxPane:split {
		direction = 'Bottom',
		size = 1,
	}
	window:gui_window():maximize()
end)

-- and finally, return the configuration to wezterm
return config
