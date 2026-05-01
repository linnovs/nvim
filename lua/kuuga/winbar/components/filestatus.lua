local function modified_symbol(bufnr) return vim.bo[bufnr].modified and "%#WinBarFileModified#%*" or nil end

local function readonly_symbol(bufnr) return vim.bo[bufnr].readonly and "%#WinBarFileReadonly#%*" or nil end

---@param _ boolean
return function(_)
	local winid = vim.api.nvim_get_current_win()
	local bufnr = vim.api.nvim_win_get_buf(winid)

	return table.concat({
		modified_symbol(bufnr) or "",
		readonly_symbol(bufnr) or "",
	})
end
