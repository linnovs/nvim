---@diagnostic disable: undefined-field
local status = require("noice").api.status
local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local M = {}

M[1] = function()
	local msg = status.mode.get()

	if string.sub(msg, 1, 9) == "recording" then
		return string.sub(msg, 11)
	end
end

M.icon = "󰻃 "
M.color = {
	fg = colors.red,
	bg = colors.overlay0,
}

M.cond = status.mode.has

return M
