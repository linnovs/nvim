---@param active boolean
return function(active)
	local winid = vim.api.nvim_get_current_win()
	local winnr = vim.api.nvim_win_get_number(winid)
	local hl = active and "%#WinBarWindowNum#" or ""
	return hl .. "  " .. tostring(winnr)
end
