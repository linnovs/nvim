return function()
	local winid = vim.api.nvim_get_current_win()
	local chars = { "󰋙", "󰫃", "󰫄", "󰫅", "󰫆", "󰫇", "󰫈" }

	local current_line = vim.api.nvim_win_get_cursor(winid)[1]
	local total_lines = vim.api.nvim_buf_line_count(vim.api.nvim_win_get_buf(winid))
	local part = math.floor(current_line / total_lines * (#chars - 1)) + 1

	return table.concat({
		"%#StatusLineScrollbar#",
		chars[part],
	})
end
