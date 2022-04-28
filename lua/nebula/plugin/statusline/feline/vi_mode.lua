local vi_mode = require("feline.providers.vi_mode")

local mode_map = {
	["n"] = "NORMAL",
	["no"] = "OP",
	["nov"] = "OP",
	["noV"] = "OP",
	["no"] = "OP",
	["niI"] = "NORMAL",
	["niR"] = "NORMAL",
	["niV"] = "NORMAL",
	["v"] = "VISUAL",
	["V"] = "LINES",
	[""] = "BLOCK",
	["s"] = "SELECT",
	["S"] = "SELECT",
	[""] = "BLOCK",
	["vs"] = "SELECT",
	["Vs"] = "SELECT",
	["s"] = "BLOCK",
	["i"] = "INSERT",
	["ic"] = "INSERT",
	["ix"] = "INSERT",
	["R"] = "REPLACE",
	["Rc"] = "REPLACE",
	["Rv"] = "V-REPLACE",
	["Rx"] = "REPLACE",
	["c"] = "COMMAND",
	["cv"] = "COMMAND",
	["r"] = "ENTER",
	["rm"] = "MORE",
	["r?"] = "CONFIRM",
	["!"] = "SHELL",
	["t"] = "TERM",
	["null"] = "NONE",
}

return {
	provider = function()
		local mode = mode_map[vim.api.nvim_get_mode().mode]
		return " " .. mode .. " "
	end,
	hl = function()
		return {
			name = vi_mode.get_mode_highlight_name(),
			bg = vi_mode.get_mode_color(),
			fg = "vi_fg",
			style = "bold",
		}
	end,
}
