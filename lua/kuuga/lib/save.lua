return function()
	local bufnr = vim.api.nvim_get_current_buf()

	if vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
		vim.cmd.write()
	else
		vim.notify("No changes to save", vim.log.levels.INFO)
	end
end
