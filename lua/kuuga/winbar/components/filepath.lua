---@param winid integer
---@param active boolean
return function(winid, active)
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	local filetype = vim.bo[bufnr].filetype

	if filetype == "oil" then filename = filename:gsub(".+://", "") end

	local pathname = vim.fn.fnamemodify(filename, ":~:.:h")
	local pathname_parts = vim.split(pathname, "/")

	return table.concat({
		active and "%#WinBarFilepathLogo#" or "",
		" 󱉭  %*",
		active and "%#WinBarFilepathPart#" or "",
		table.concat(pathname_parts, " "),
		"%*",
	})
end
