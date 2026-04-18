local client_filter = { "harper_ls", "copilot" }

---@param winid integer
---@param active boolean
return function(winid, active)
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })
	local filtered_clients = vim.tbl_filter(
		function(client) return not vim.list_contains(client_filter, client.name) end,
		clients
	)

	if #filtered_clients == 0 then return "%#WinBarLSPDisabled#  No active LSP" end

	return table.concat({
		active and "%$WinBarLSPIcon$" or "",
		"  %*",
		"LSP [",
		active and "%$WinBarLSPName$" or "",
		table.concat(vim.tbl_map(function(client) return client.name end, filtered_clients), " "),
		"%*]",
	})
end
