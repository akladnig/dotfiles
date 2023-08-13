local wezterm = require 'wezterm'

local act = wezterm.action
local hx = 'hx2'
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
-- Toggle the explorer (lf) pane on/off 
-- if lf exists
--	is lf minimised 
--		maximise lf
-- 	else
-- 		minimise lf
-- else
-- 	 create lf pane on the left

		wezterm.on('explorer', function(window, pane)
		local panes = pane:tab():panes()
		local explorerPane
		local lfPaneWidth = 60

		-- Check for lf and if found set explorerPane
		for _, paneName in ipairs(panes) do
			local paneTitle = paneName:get_title()
			-- if string.find(paneTitle, 'lf') ~= nil then
			if PaneExists(paneTitle, 'lf') then
				explorerPane = paneName
			end
		end

		if explorerPane ~= nil then
			local explorerPaneColumns = explorerPane:get_dimensions().cols
			local delta = lfPaneWidth - explorerPaneColumns
			if explorerPaneColumns < lfPaneWidth then
				window:perform_action(act.AdjustPaneSize {'Right', delta}, explorerPane)
				window:perform_action(act.ActivatePaneDirection('Left'), pane)
			else
				window:perform_action(act.AdjustPaneSize {'Left', explorerPaneColumns - 1}, explorerPane)
				window:perform_action(act.ActivatePaneDirection('Right'), pane)
			end
		else

			local action = wezterm.action {
				SplitPane = {
					direction = 'Left',
					size = {Cells = lfPaneWidth},
					-- command = { args = { 'lf'  } }
					command = { args = { 'lf', '-config', '/Users/adrian/.config/lf/lfhxrc' } }
				},
			};
			window:perform_action(action, pane);
		end
	end)

	-- check if there is an explorer pane and create it if not
	-- Toggle the terminal pane on/off 
	-- if the terminal exists
	--	is terminal minimised 
	--		maximise terminal
	-- 	else
	-- 		minimise terminal
	-- else
	-- 	 create terminal pane on the bottom

	-- terminal exists:
	-- if in hx pane and pane active below

	wezterm.on('terminal', function(window, pane)
		local panes = pane:tab():panes()
		local terminalPane
		local explorerPane
		local terminalPaneHeight = 15

		-- Check for lf and if found set explorerPane
		for _, paneName in ipairs(panes) do
			local paneTitle = paneName:get_title()
			-- if string.find(paneTitle, 'lf') ~= nil then
			if PaneExists(paneTitle, 'lf') then
				explorerPane = paneName
			end
		end

		-- Create an explorer pane if it does not exist
		if explorerPane == nil then
			local action = wezterm.action {
				SplitPane = {
					direction = 'Left',
					size = {Cells = 1},
					command = { args = { 'lf', '-config', '/Users/adrian/.config/lf/lfhxrc' } }
				},
			};
			window:perform_action(action, pane);
		end

		local activePane = pane:tab():active_pane()
		local activePaneTitle = activePane:get_title()
		-- Determine which pane is active and then move to the hx pane
		-- If in the lf pane move right to the hx pane
		if PaneExists(activePaneTitle, 'lf') then
    	window:perform_action(act.ActivatePaneDirection('Right'), pane)
    end

		activePane = pane:tab():active_pane()
		activePaneTitle = activePane:get_title()
		-- if in the hx pane check if a terminal pane is open and open if not
		if PaneExists(activePaneTitle, hx) then
			terminalPane = pane:tab():get_pane_direction('Down')
		else
			local hxPane =  pane:tab():get_pane_direction('Up')
			if  PaneExists(hxPane:get_title(), hx) then
				terminalPane = activePane
			end
		end

		if terminalPane ~= nil then
			local terminalPaneRows = terminalPane:get_dimensions().viewport_rows
			local delta = terminalPaneHeight - terminalPaneRows
			if terminalPaneRows < terminalPaneHeight then
				window:perform_action(act.AdjustPaneSize {'Up', delta}, terminalPane)
				window:perform_action(act.ActivatePaneDirection('Down'), pane)
			else
				window:perform_action(act.AdjustPaneSize {'Down', terminalPaneRows - 1}, terminalPane)
				window:perform_action(act.ActivatePaneDirection('Up'), pane)
			end
		else
			local action = wezterm.action {
				SplitPane = {
					direction = 'Down',
					size = {Cells = terminalPaneHeight},
				},
			};
			window:perform_action(action, pane);
		end
	end)

end

return module
