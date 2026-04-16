vim.api.nvim_exec2(
	[[
function! KuugaTabLineCloseTab(tab_id, clicks, button, mod)
	execute "tabclose"
endfunction
]],
	{}
)

return function()
	local tabs = vim.api.nvim_list_tabpages()

	if #tabs <= 1 then return "%#TabLineTabCloseInactive#  " end

	return "%1@KuugaTabLineCloseTab@%#TabLineTabClose#  %X"
end
