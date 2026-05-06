return function()
	local winid = vim.g.statusline_winid
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local line_count = tostring(vim.api.nvim_buf_line_count(bufnr))
	local lnum = tostring(vim.v.lnum)

	lnum = lnum .. (" "):rep(line_count:len() - lnum:len() + 1) .. "%="
	if vim.v.relnum ~= 0 then lnum = "%=" .. tostring(vim.v.relnum) end
	return lnum
end
