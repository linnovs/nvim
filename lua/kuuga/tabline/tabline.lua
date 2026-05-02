TabLine = {}

local components = require("kuuga.tabline.components")

TabLine.last_tabline = setmetatable({}, { __mode = "k" }) ---@type table<integer, string>

function TabLine.refresh()
	local winid = vim.api.nvim_get_current_win()
	TabLine.last_tabline[winid] = table.concat({
		components.render("logo", false),
		components.render("tabs", true),
		"%=",
		components.render("tab_close", true),
	})
end

function TabLine.render()
	local winid = vim.api.nvim_get_current_win()
	return TabLine.last_tabline[winid] or "%#TabLine#   Loading ...%*"
end

function TabLine.switch_tab(tabid) vim.api.nvim_set_current_tabpage(tabid) end

function TabLine.close_tab() vim.cmd("tabclose") end

function TabLine.switch_window(winid) vim.api.nvim_set_current_win(winid) end

function TabLine.close_window(winid) vim.api.nvim_win_close(winid, false) end
