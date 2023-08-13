local wezterm = require 'wezterm'
local helper = require 'helpers'

local act = wezterm.action
local hx = 'hx2'
local explorer = 'lf'

function ResetExplorer(window, pane)
  local ratiosStr = ':set ratios 1:2:3\n'
  local drawboxStr = ':set drawbox true\n'
  local previewStr = ':set preview true\n'

  window:perform_action(act.SendString(ratiosStr), pane)
  window:perform_action(act.SendString(drawboxStr), pane)
  window:perform_action(act.SendString(previewStr), pane)
end

local module = {}

function module.apply_to_config(config)

		wezterm.on('exit-hx', function(window, pane)
		local panes = pane:tab():panes()
    local paneCount = #panes

		local explorerPane
    local hxPane
    local terminalPane

		-- Check for explorer and hx and if found set pane names
		for _, paneName in ipairs(panes) do
			local paneTitle = paneName:get_title()
			if helper.PaneExists(paneTitle, explorer) then
				explorerPane = paneName
      elseif helper.PaneExists(paneTitle, hx) then
        hxPane = paneName
			end
		end

    -- Check if a terminal pane is open
    -- First need to go to the helix pane
    if hxPane ~= nil and paneCount == 3 then
      hxPane:activate()
      terminalPane = pane:tab():get_pane_direction('Down')
      window:perform_action(act.SendString(terminalPane), hxPane)
    end
    -- if there is a single pane check if it an explorer pane and then reset the explorer config otherwise close the pane
    if paneCount == 1 then
  		if explorerPane == nil then
      	window:perform_action(act.CloseCurrentPane { confirm = true }, pane)
  		else
        ResetExplorer(window, explorerPane)
  		end
    -- deal with 2-3 panes
    elseif paneCount >= 2 then
      -- if there is a terminal pane then close it.
      if terminalPane ~= nil then
        terminalPane:activate()
      	window:perform_action(act.CloseCurrentPane { confirm = false }, terminalPane)
      end
      if hxPane ~= nil then
        hxPane:activate()
      	window:perform_action(act.CloseCurrentPane { confirm = false }, hxPane)
      end
  		if explorerPane == nil then
      	window:perform_action(act.CloseCurrentPane { confirm = true }, pane)
  		else
        ResetExplorer(window, explorerPane)
  		end
    end
  end)
end

return module
