return function()
	local chars = { "󰋙", "󰫃", "󰫄", "󰫅", "󰫆", "󰫇", "󰫈" }

	local current_line = vim.api.nvim_win_get_cursor(0)[1]
	local total_lines = vim.api.nvim_buf_line_count(0)
	local part = math.floor(current_line / total_lines * (#chars - 1)) + 1

	return table.concat({
		"%#StatusLineScrollbar#",
		chars[part],
	})
end
