local icons = require("kuuga.icons").diagnostics

local M = {}

M.client_names = {
	function()
		local clients = {}

		for _, client in pairs(vim.lsp.buf_get_clients(0)) do
			clients[#clients + 1] = client.name
		end

		return table.concat(clients, " ")
	end,
	icon = " ",
}

M.diagnostics =
	{ "diagnostics", symbols = { error = icons.Error, warn = icons.Warn, info = icons.Info, hint = icons.Hint } }

return M
