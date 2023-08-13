local module = {}

function module.PaneExists(paneTitle, paneName)
	return string.find(paneTitle, paneName) ~= nil
end

return module
