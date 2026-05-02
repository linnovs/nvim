return function()
	local tabs = vim.api.nvim_list_tabpages()

	if #tabs <= 1 then return "%#TabLineTabCloseInactive#  " end

	return "%1@v:lua.TabLine.close_tab@%#TabLineTabClose#  %X"
end
