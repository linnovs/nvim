local client_filter = { "harper_ls", "typos_lsp", "copilot" }

return function(active)
	local bufnr = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	local filtered_clients = vim.tbl_filter(
		function(client) return not vim.list_contains(client_filter, client.name) end,
		clients
	)

	if #filtered_clients == 0 then return "%#StatusLineLSPDisabled#   No active LSP" end

	return table.concat({
		active and "%$WinBarLSPIcon$" or "",
		"  %*",
		"LSP [",
		active and "%$WinBarLSPName$" or "",
		table.concat(vim.tbl_map(function(client) return client.name end, filtered_clients), " "),
		"%*]",
	})
end
