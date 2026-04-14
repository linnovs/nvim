vim.g.statusline_lsp_show_servers = false

local client_filter = { "harper_ls", "typos_lsp", "copilot" }

return function()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	local filtered_clients = vim.tbl_filter(
		function(client) return not vim.tbl_contains(client_filter, client.name) end,
		clients
	)

	if #filtered_clients == 0 then return "%#StatuslineLSPDisabled#   No active LSP" end

	return table.concat({
		"%#StatuslineLSPIcon#",
		"  ",
		"%#StatuslineLSP#",
		"LSP",
		table.concat({
			" [%#StatuslineLSPName#",
			table.concat(vim.tbl_map(function(client) return client.name end, filtered_clients), " "),
			"%#StatuslineLSP#]",
		}),
	})
end
