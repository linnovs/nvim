---@param active boolean
return function(active)
	local bufnr = vim.api.nvim_get_current_buf()
	local filename = vim.api.nvim_buf_get_name(bufnr)
	local filetype = vim.bo[bufnr].filetype

	if filetype == "oil" then filename = filename:gsub(".+://", "") end

	local pathname = vim.fn.fnamemodify(filename, ":~:.:h")
	local pathname_parts = vim.split(pathname, "/")

	return table.concat({
		active and "%#WinBarFilepathLogo#" or "",
		" 󱉭  %*",
		table.concat(pathname_parts, "󰄾 "),
	})
end
