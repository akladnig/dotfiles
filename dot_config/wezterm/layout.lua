local wezterm = require 'wezterm'
local h = require 'helpers'

local act = wezterm.action
local hx = 'hx'
local explorer = 'lf'

local module = {}

function module.apply_to_config(config)
	-- Toggle the explorer pane on/off
	-- if explorer exists
	--	is explorer minimised
	--		maximise explorer
	-- 	else
	-- 		minimise explorer
	-- else
	-- 	 create explorer pane on the left

	wezterm.on('explorer', function(window, pane)
		local panes = pane:tab():panes()

		-- Check for explorer and helix if found set panes for both
		-- TODO use.for keys
		local explorerPane = h.OpenPanes(panes)["explorerPane"]
		local hxPane = h.OpenPanes(panes)["hxPane"]

		local activePaneTitle = pane:tab():active_pane():get_title()

		if explorerPane ~= nil then
			local explorerPaneColumns = explorerPane:get_dimensions().cols
			local delta = h.ExplorerPaneWidth() - explorerPaneColumns
			-- If in the explorer pane, minimise it and go to hx pane
			if h.PaneExists(activePaneTitle, explorer) then
				window:perform_action(act.AdjustPaneSize { 'Left', explorerPaneColumns - 1 }, explorerPane)
				if hxPane ~= nil then
					hxPane:activate()
				end
			else
				-- in the hx or terminal pane so maximise the explorerPane
				-- if the explorerPane is already maximised do nothing otherwise maximise it
				if delta > 0 then
					window:perform_action(act.AdjustPaneSize { 'Right', delta }, explorerPane)
				end
				explorerPane:activate()
			end
		else
			h.splitExplorerPane(pane)
		end
	end)

	-- Activate the helix pane if it is open
	wezterm.on('helix', function(window, pane)
		local panes = pane:tab():panes()

		local hxPane = h.OpenPanes(panes)["hxPane"]
		if hxPane ~= nil then
			hxPane:activate()
			h.minimiseExplorerPane(window, pane)
			h.minimiseTerminalPane(window, pane)
		end
	end)

	-- check if there is an explorer pane and create it if not
	-- then check if there is a terminal pane and create it if not
	-- if terminalPane is active
	-- 		minimise terminal
	--		activate hxPane
	-- else
	--		maximise terminal
	--		active terminalPane

	wezterm.on('terminal', function(window, pane)
		local panes = pane:tab():panes()

		local hxPane = h.OpenPanes(panes)["hxPane"]
		local terminalPane = h.OpenPanes(panes).terminalPane

		local layout = h.GetLayout(pane)

		-- if hxPane ~= nil then
		-- 	hxPane:send_text(tostring(layout.hxIde))
		-- end

		local activePane = pane:tab():active_pane()

		-- Create hxIde layout from hx layout
		if layout.hx then
			hxPane = activePane
			explorerPane = h.splitExplorerPane(pane)
			terminalPane = h.splitTerminalPane(pane)
			terminalPane:activate()
		end

		-- Activate the Terminal Pane if in another pane otherwise
		-- minimise the Terminal Pane
		if layout.plainIde or layout.hxIde or layout.hxSplitIde then
			if layout.plainIde then
				-- TODO open hx instance
			end
			if terminalPane ~= nil then
				local terminalPaneRows = terminalPane:get_dimensions().viewport_rows
				local delta = h.TerminalPaneHeight() - terminalPaneRows
				if h.ActivePaneis(pane).explorerPane or h.ActivePaneis(pane).hxPane then
					terminalPane:activate()
					window:perform_action(act.AdjustPaneSize { 'Up', delta }, terminalPane)
				else
					window:perform_action(act.AdjustPaneSize { 'Down', terminalPaneRows - 1 }, terminalPane)
					if hxPane ~= nil then
						-- hxPane:send_text(tostring(tostring(delta)))
						hxPane:activate()
					end
				end
			end
		end


		-- local activePaneTitle = pane:tab():active_pane():get_title()
		-- -- Determine which pane is active and then move to the hx pane
		-- -- If in the explorer pane move right to the hx pane
		-- if h.PaneExists(activePaneTitle, explorer) then
		-- 	if hxPane ~= nil then
		-- 		hxPane:activate()
		-- 	else
		-- 		-- In case hx has exited and a plain shell remains
		-- 		window:perform_action(act.ActivatePaneDirection('Right'), pane)
		-- 	end
		-- end

		-- local activePane = pane:tab():active_pane()
		-- activePaneTitle = activePane:get_title()
		-- -- if in the hx pane check if a terminal pane is open and open if not
		-- if h.PaneExists(activePaneTitle, hx) then
		-- 	terminalPane = pane:tab():get_pane_direction('Down')
		-- else
		-- 	Pane = pane:tab():get_pane_direction('Up')
		-- 	if h.PaneExists(hxPane:get_title(), hx) then
		-- 		terminalPane = activePane
		-- 	end
		-- end

		-- if terminalPane ~= nil then
		-- 	local terminalPaneRows = terminalPane:get_dimensions().viewport_rows
		-- 	local delta = h.TerminalPaneHeight() - terminalPaneRows
		-- 	-- if the terminal pane is already open and full size just move to it
		-- 	if terminalPaneRows == h.TerminalPaneHeight() then
		-- 		window:perform_action(act.ActivatePaneDirection('Down'), pane)
		-- 		-- otherwise maximise it
		-- 	elseif terminalPaneRows < h.TerminalPaneHeight() then
		-- 		window:perform_action(act.AdjustPaneSize { 'Up', delta }, terminalPane)
		-- 		window:perform_action(act.ActivatePaneDirection('Down'), pane)
		-- 	else
		-- 		window:perform_action(act.AdjustPaneSize { 'Down', terminalPaneRows - 1 }, terminalPane)
		-- 		window:perform_action(act.ActivatePaneDirection('Up'), pane)
		-- 	end
		-- else
		-- 	h.splitTerminalPane(pane)
		-- end
	end)
end

return module
