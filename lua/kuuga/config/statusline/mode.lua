local M = {}

M.bar = {
	function()
		return "▌"
	end,
	color = { fg = "#b7bdf8" },
	padding = 0,
}

M.icon = {
	function()
		return "󰚀 "
	end,
}

return M
