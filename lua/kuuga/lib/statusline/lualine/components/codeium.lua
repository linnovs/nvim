local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local M = {}

M[1] = function()
	return "{…}" .. vim.api.nvim_call_function("codeium#GetStatusString", {})
end
M.cond = function()
	return vim.api.nvim_call_function("codeium#GetStatusString", {}) ~= "   "
		and vim.api.nvim_call_function("codeium#GetStatusString", {}) ~= " ON"
		and vim.api.nvim_call_function("codeium#GetStatusString", {}) ~= "OFF"
end

M.color = {
	fg = colors.green,
	bg = colors.overlay0,
}

M.separator = {
	left = "",
	right = "",
}

return M
