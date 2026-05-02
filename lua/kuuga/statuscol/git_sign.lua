return function()
	local winid = vim.g.statusline_winid
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local sign = require("gitsigns").statuscolumn(bufnr, vim.v.lnum)
	return " " .. sign:sub(1, #sign - 1)
end
