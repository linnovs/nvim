return function()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	local filetype = vim.bo[bufnr].filetype

	if vim.bo[bufnr].buftype == "terminal" then
		return table.concat({
			"%#StatuslineFilepathTerminal#",
			" ",
			"%#StatuslineFilepath#",
			vim.fs.basename(filename),
		})
	end

	if filetype == "oil" then filename = filename:gsub(".+://", "") end

	local pathname = vim.fn.fnamemodify(filename, ":~:.:h")

	return table.concat({
		"%#StatuslineFilepathIcon#",
		"󱉭  ",
		"%#StatuslineFilepath#",
		pathname,
	})
end
