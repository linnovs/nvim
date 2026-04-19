---@param active boolean
return function(active)
	if vim.api.nvim_get_vvar("hlsearch") == 0 then return "" end
	local count = vim.fn.searchcount({ recompute = true, maxcount = 500 })
	local current = count.current
	local total = count.total > count.maxcount and ">" .. count.maxcount or count.total

	if count.incomplete == 1 then
		current = "?"
		total = "?"
	end

	return table.concat({
		active and "%#WinBarSearchCountIcon#" or "",
		"  ",
		active and "%#WinBarSearchCountCount#" or "",
		current,
		"/",
		total,
	})
end
