local colors = require("catppuccin.palettes").get_palette("macchiato") or {}

local M = {}

M[1] = function()
	local clients = {}
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
		clients[#clients + 1] = client.name
	end

	if #clients == 0 then
		return nil
	end

	return table.concat(clients, " ")
end

M.icon = "󰑣 "

M.separator = {
	left = "",
	right = "",
}

M.cond = function()
	return #vim.lsp.get_clients({ bufnr = 0 }) > 0
end

M.color = {
	fg = colors.surface0,
	bg = colors.overlay2,
	gui = "bold",
}

return M
