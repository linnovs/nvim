local M = {}

M.last_linestatus = setmetatable({}, { __mode = "k" })

function M.click_fold()
	local pos = vim.fn.getmousepos()
	vim.api.nvim_win_set_cursor(pos.winid, { pos.line, 1 })
	vim.api.nvim_win_call(pos.winid, function()
		if vim.fn.foldlevel(pos.line) == 0 then vim.cmd("normal! za") end
	end)
end

local function wrap_click(components)
	local res = table.concat(components, "")
	return "%@v:lua.require'kuuga.statuscol'.click_fold@" .. res .. " %X"
end

local function generate_key()
	local winid = vim.g.statusline_winid
	local bufnr = vim.api.nvim_win_get_buf(winid)
	return ("%d:%d:%d:%d:%d"):format(winid, bufnr, vim.v.lnum, vim.v.virtnum ~= 0 and 1 or 0, vim.v.relnum)
end

function M.reset() M.last_linestatus = setmetatable({}, { __mode = "k" }) end

---@param key string
function M.refresh(key)
	M.last_linestatus[key] = wrap_click({
		require("kuuga.statuscol.sign")(),
		require("kuuga.statuscol.lnum")(),
		require("kuuga.statuscol.fold")(),
	})
end

function M.render()
	local key = generate_key()
	if not M.last_linestatus[key] then M.refresh(key) end
	return M.last_linestatus[key] or tostring(vim.v.lnum)
end

return M
