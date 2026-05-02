return function()
	local fold_closed = vim.api.nvim_win_call(
		vim.api.nvim_get_current_win(),
		function() return vim.fn.foldclosed(vim.v.lnum) end
	)

	return fold_closed == -1 and " " or "%#FoldColumn#%*"
end
