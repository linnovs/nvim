local M = {}

local components = require("kuuga.tabline.components")

M.last_tabline = setmetatable({}, { __mode = "k" }) ---@type table<integer, string>

function M.refresh()
	local winid = vim.api.nvim_get_current_win()
	M.last_tabline[winid] = table.concat({
		components.render("logo", false),
		components.render("tabs", true),
		"%=",
		components.render("tab_close", true),
	})
end

function M.render()
	local winid = vim.api.nvim_get_current_win()
	return M.last_tabline[winid] or "%#TabLine#   Loading ...%*"
end

function M.switch_tab(tabid) vim.api.nvim_set_current_tabpage(tabid) end

function M.close_tab() vim.cmd("tabclose") end

function M.switch_window(winid) vim.api.nvim_set_current_win(winid) end

function M.close_window(winid) vim.api.nvim_win_close(winid, false) end

return M
