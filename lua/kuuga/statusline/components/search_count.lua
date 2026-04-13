return function()
	if vim.api.nvim_get_vvar("hlsearch") == 0 then return "" end
	local count = vim.fn.searchcount({ recompute = true, maxcount = 500 })
	local current = count.current
	local total = count.total > count.maxcount and ">" .. count.maxcount or count.total

	if count.incomplete == 1 then
		current = "?"
		total = "?"
	end

	return table.concat({
		"%#StatuslineSearchCountIcon#",
		"  ",
		"%#StatuslineSearchCountCount#",
		current,
		"/",
		total,
	})
end
