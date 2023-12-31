_G.StatusColFoldAction = function()
	local mousepos = vim.fn.getmousepos()
	if mousepos == nil then
		return
	end

	vim.api.nvim_set_current_win(mousepos.winid)
	vim.api.nvim_win_set_cursor(0, { mousepos.line, 0 })

	local char = vim.fn.screenstring(mousepos.screenrow, mousepos.screencol)
	local fillchars = vim.opt.fillchars:get()
	local action = fillchars.foldopen == char and "zc" or "zo"

	vim.schedule(function()
		vim.cmd("norm! " .. action)
	end)
end

_G.StatusCol = function()
	local lnum = vim.v.lnum
	local relnum = vim.v.relnum
	local virtnum = vim.v.virtnum
	local fillchars = vim.opt.fillchars:get()

	if virtnum ~= 0 then
		return "%="
	end

	local signCol = "%s"
	local foldCol = "  "
	local numberCol = "%{v:lnum}%="

	if relnum ~= 0 then
		numberCol = "%=%{v:relnum}"
	end

	-- inspired by https://github.com/neovim/neovim/pull/25028#issuecomment-1707054458
	if vim.fn.foldlevel(lnum) > vim.fn.foldlevel(lnum - 1) then
		local arrow = vim.fn.foldclosed(lnum) == -1 and fillchars.foldopen or fillchars.foldclose
		foldCol = string.format(" %%#FoldColumn#%%@v:lua.StatusColFoldAction@%s", arrow)
	end

	return signCol .. numberCol .. foldCol .. " "
end

vim.opt.statuscolumn = "%!v:lua.StatusCol()"
