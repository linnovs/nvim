local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local M = {}

M[1] = function()
	return "@" .. vim.fn.reg_recording()
end

M.icon = "󰻃 "
M.color = {
	fg = colors.red,
	bg = colors.overlay0,
}

M.cond = function()
	return vim.fn.reg_recording() ~= ""
end

return M
