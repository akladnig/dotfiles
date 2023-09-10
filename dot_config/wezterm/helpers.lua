local wezterm = require 'wezterm'

local module = {}

local act = wezterm.action
local hx = 'hx'
local explorer = 'lf'

local explorerPaneWidth = 60
local terminalPaneHeight = 15

function module.ExplorerPaneWidth()
	return explorerPaneWidth
end

function module.TerminalPaneHeight()
	return terminalPaneHeight
end

function module.PaneExists(paneTitle, paneName)
	return paneTitle == paneName
	-- return string.find(paneTitle, paneName) ~= nil
end

function module.splitExplorerPane(pane)
	return pane:split {
		direction = 'Left',
		size = { Cells = explorerPaneWidth },
		command = { args = { explorer, '-config', '/Users/adrian/.config/lf/lfhxrc' } }
	}
end

function module.splitTerminalPane(pane)
	return pane:split {
		SplitPane = {
			direction = 'Down',
			size = { Cells = terminalPaneHeight },
		}
	}
end

function module.minimiseExplorerPane(window, pane)
	if pane ~= nil then
		local explorerPaneColumns = pane:get_dimensions().cols
		window:perform_action(act.AdjustPaneSize { 'Left', explorerPaneColumns - 1 }, pane)
	end
end

function module.minimiseTerminalPane(window, pane)
	if pane ~= nil then
		local terminalPaneRows = pane:get_dimensions().viewport_rows
		window:perform_action(act.AdjustPaneSize { 'Down', terminalPaneRows - 1 }, pane)
	end
end

-- Gets the Panes that are currently open
function module.OpenPanes(panes)
	local openPanes = { explorerPane = nil, hxPane = nil, terminalPane = nil }

	for _, paneName in ipairs(panes) do
		local paneTitle = paneName:get_title()

		if module.PaneExists(paneTitle, explorer) then
			openPanes["explorerPane"] = paneName
		elseif module.PaneExists(paneTitle, hx) then
			openPanes["hxPane"] = paneName
		else
			openPanes.terminalPane = paneName
		end
	end

	return openPanes
end

-- Gets the currently active pane
function module.ActivePaneis(pane)
	local activePaneList = {
		explorerPane = false,
		hxPane = false,
		terminalPane = false
	}

	local activePane = pane:tab():active_pane()
	local activePaneTitle = activePane:get_title()
	if module.PaneExists(activePaneTitle, explorer) then
		activePaneList.explorerPane = true
	elseif module.PaneExists(activePaneTitle, hx) then
		activePaneList.hxPane = true
	else
		-- TODO assume terminal pane
		activePaneList.terminalPane = true
	end

	return activePaneList
end

-- Layout types:
--
-- hx
-- +----------------+
-- |		 						|
-- |     helix  		|
-- |		 						|
-- +----------------+
--
-- hxExplorer
-- +----------+-----------+
-- |	      	|						|
-- | explorer |		helix		|
-- |	      	|						|
-- +----------+-----------+
--
-- hxSplitExplorer
-- +----------+--------+--------+
-- |          |				 |				|
-- | explorer | helix  | helix	|
-- |          |				 |				|
-- +----------+--------+--------+
--
-- plainIde / hxIde
-- +----------+-----------+
-- |      		|						|
-- |          |		zsh or  |
-- | explorer |   helix		|
-- |      		|						|
-- |          |-----------+
-- |      		|	terminal  |
-- +----------+-----------+
--
-- hxSplitIde
-- +----------+--------+--------+
-- |          |				 |				|
-- | explorer | helix  | helix	|
-- |         	|				 |				|
-- |          |--------+--------+
-- |      		|	terminal  			|
-- +----------+-----------------+

function module.GetLayout(pane)
	local panes = pane:tab():panes()
	local paneCount = #panes

	local paneList = {
		explorerPane = 0,
		hxPane = 0,
		terminalPane = 0
	}

	local layouts = {
		none = true,
		hx = false,
		hxExplorer = false,
		hxSplitExplorer = false,
		plainIde = false,
		hxIde = false,
		hxSplitIde = false,
	}

	local terminalApps = {
		ghci = false,
		lg = false,
		lua = false,
		zsh = false,
	}

	for _, paneName in ipairs(panes) do
		local paneTitle = paneName:get_title()

		if module.PaneExists(paneTitle, explorer) then
			paneList.explorerPane = paneList.explorerPane + 1
		elseif module.PaneExists(paneTitle, hx) then
			paneList.hxPane = paneList.hxPane + 1
		else
			paneList.terminalPane = paneList.terminalPane + 1
		end
	end

	if paneCount == 1 and paneList.hxPane == 1 then
		layouts.hx = true
	elseif paneCount == 2 and paneList.explorerPane == 1 and paneList.hxPane == 1 then
		layouts.hxExplorer = true
	elseif paneCount == 3 and paneList.explorerPane == 1 and paneList.hxPane == 0 then
		-- Need to check if the 3rd pane is below helix for now just assume it is
		layouts.plainIde = true
	elseif paneCount == 3 and paneList.explorerPane == 1 and paneList.hxPane == 1 then
		-- Need to check if the 3rd pane is below helix for now just assume it is
		layouts.hxIde = true
	elseif paneCount == 3 and paneList.explorerPane == 1 and paneList.hxPane == 2 then
		layouts.hxSplitExplorer = true
	elseif paneCount == 4 and paneList.explorerPane == 1 and paneList.hxPane == 2 then
		-- Need to check if the 4th pane is below helix for now just assume it is
		layouts.hxSplitIde = true
	end

	return layouts
end

return module
