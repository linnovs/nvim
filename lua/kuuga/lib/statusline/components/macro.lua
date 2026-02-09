local marco = require("lualine.component"):extend()
local colors = require("catppuccin.palettes").get_palette("mocha") or {}

function marco:init(options) marco.super.init(self, options) end

function marco:update_status()
	-- If recording, return the current recording register
	if vim.fn.reg_recording() ~= "" then return "@" .. vim.fn.reg_recording() end
	-- If not recording, return nil
	return nil
end

return {
	marco,
	icon = "󰻃 ",
	color = { fg = colors.red, bg = colors.overlay0 },
}
