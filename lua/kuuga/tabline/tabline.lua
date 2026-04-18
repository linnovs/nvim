TabLine = {}

local components = require("kuuga.tabline.components")

TabLine.last_tabline = setmetatable({}, { __mode = "k" }) ---@type table<integer, string>

function TabLine.refresh()
	local winid = vim.api.nvim_get_current_win()
	TabLine.last_tabline[winid] = table.concat({
		components.render("tabs", true),
		"%=",
		components.render("windows", true),
		components.render("tab_close", true),
	})
end

function TabLine.render()
	local winid = vim.api.nvim_get_current_win()
	return TabLine.last_tabline[winid] or "%#TabLine#   Loading ...%*"
end
