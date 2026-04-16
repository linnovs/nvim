---@param winid integer
---@param active boolean
return function(winid, active)
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local client = vim.lsp.get_clients({ bufnr = bufnr, name = "copilot" })[1]

	if not client then return "" end

	return table.concat({
		active and "%$WinBarCopilotIcon$" or "",
		" ",
	})
end
