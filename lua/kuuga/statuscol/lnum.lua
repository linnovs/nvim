return function()
	local lnum = "%=" .. tostring(vim.v.lnum)
	if vim.v.relnum == 0 then lnum = tostring(vim.v.lnum) .. "%=" end
	return lnum
end
