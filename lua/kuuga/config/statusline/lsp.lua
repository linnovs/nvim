local icons = require("kuuga.icons").diagnostics

local M = {}

M.client_names = {
	function()
		local clients = {}

		for _, client in pairs(vim.lsp.get_active_clients()) do
			clients[#clients + 1] = client.name
		end

		return table.concat(clients, " ")
	end,
	icon = " ",
	color = { fg = "#b7bdf8" },
}

M.diagnostics =
	{ "diagnostics", symbols = { error = icons.Error, warn = icons.Warn, info = icons.Info, hint = icons.Hint } }

return M
