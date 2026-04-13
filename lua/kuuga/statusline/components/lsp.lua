vim.g.statusline_lsp_show_servers = false

return function()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local clients = vim.lsp.get_clients({ bufnr = bufnr })

	if #clients == 0 then return "" end

	return table.concat({
		"%#StatuslineLSPIcon#",
		"  ",
		"%#StatuslineLSP#",
		"LSP",
		vim.g.statusline_lsp_show_servers and table.concat({
			" [%#StatuslineLSPName#",
			table.concat(vim.tbl_map(function(client) return client.name end, clients), " "),
			"%#StatuslineLSP#]",
		}) or "",
	})
end
