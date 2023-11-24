local noice = require("noice").api.status

local M = {}

M.marco = {
	noice.mode.get,
	cond = noice.mode.has,
	color = { fg = "#ffffff", bg = "#e43fde" },
}

return M
