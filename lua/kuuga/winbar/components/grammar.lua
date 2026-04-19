---@param active boolean
return function(active)
	local winid = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local client = vim.lsp.get_clients({ bufnr = bufnr, name = "harper_ls" })[1]

	if not client then return "" end

	return table.concat({
		active and "%#WinBarGrammarIcon#" or "",
		"󰴰",
	})
end
