local M = {}

local hl = {
	fg = "lsp_fg",
	bg = "lsp_bg",
	style = "bold,italic",
}

M.client_name = {
	provider = "lsp_client_names",
	hl = hl,
	icon = " ",
	left_sep = {
		str = " ",
		hl = hl,
	},
}

return M
