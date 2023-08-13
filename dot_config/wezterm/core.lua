local module = {}

function module.apply_to_config(config)
	config.set_environment_variables = { PATH = "/opt/homebrew/bin:~/.local/bin:" .. os.getenv('PATH') }

	-- Enable the scrollbar.
	-- It will occupy the right window padding space.
	-- If right padding is set to 0 then it will be increased
	-- to a single cell width
	config.enable_scroll_bar = true
end

return module