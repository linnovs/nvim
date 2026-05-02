return function()
	local fold_closed = vim.api.nvim_win_call(
		vim.g.statusline_winid,
		function() return vim.fn.foldclosed(vim.v.lnum) end
	)
	return fold_closed == -1 and " " or "%#FoldColumn#%*"
end
