local Item = require("nougat.item")
local sep = require("nougat.separator")
local color = require("catppuccin.palettes").get_palette("macchiato") or {}

local get_content = function(_, ctx)
	local clients = {}
	for _, client in ipairs(vim.lsp.get_clients({ bufnr = ctx.bufnr })) do
		clients[#clients + 1] = client.name
	end

	if #clients == 0 then
		return nil
	end

	return table.concat(clients, " & ")
end

local is_hidden = function(_, ctx)
	return #vim.lsp.get_clients({ bufnr = ctx.bufnr }) == 0
end

local lsp_server = function(opts)
	opts = vim.tbl_extend("force", {
		prefix = " 󰑣  ",
		suffix = " ",
		content = get_content,
		hidden = is_hidden,
		sep_left = sep.left_half_circle_solid(true),
		sep_right = sep.right_half_circle_solid(true),
		hl = {
			bg = color.overlay2,
			fg = color.surface0,
			bold = true,
		},
	}, opts or {})

	return Item(opts)
end

return lsp_server
