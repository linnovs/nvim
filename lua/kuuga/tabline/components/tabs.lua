local file_lib = require("kuuga.lib.file")

vim.api.nvim_exec2(
	[[
function! KuugaTabLineSwitchTab(tabid, clicks, button, mod)
	execute a:tabid .. "tabnext"
endfunction
]],
	{}
)

---@param tabid integer
---@param tabpage string
local function wrap_tab_switch(tabid, tabpage)
	local tabnr = vim.api.nvim_tabpage_get_number(tabid)
	local tab_func = "%" .. tabnr .. "@KuugaTabLineSwitchTab@"
	return tab_func .. tabpage .. "%X"
end

---@param tabid integer
local function get_tabpage(tabid)
	local winid = vim.api.nvim_tabpage_get_win(tabid)
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local filename = file_lib.get_filename(bufnr)
	local icon, hl = file_lib.get_file_icon(filename)

	local focused = tabid == vim.api.nvim_get_current_tabpage()

	local text_hl = focused and "%#TabLineTabActive#" or "%#TabLineTabInactive#"
	local icon_hl = focused and "%#" .. hl .. "#" or "%#TabLineTabInactive#"
	local tabicon_hl = focused and "%#TabLineTabNumber#" or "%#TabLineTabInactive#"
	local tab_icon = icon_hl .. icon .. " "
	local tab_filename = text_hl .. filename .. " "
	local tab_number = tabicon_hl .. "󰓩 " .. vim.api.nvim_tabpage_get_number(tabid) .. " "

	local tabpage = table.concat({ tab_icon, tab_filename, tab_number })

	return wrap_tab_switch(tabid, tabpage)
end

return function()
	local tabids = vim.api.nvim_list_tabpages()
	local tabs = {}

	for _, tabid in ipairs(tabids) do
		local tab = get_tabpage(tabid)
		if tab then table.insert(tabs, tab) end
	end

	return table.concat(tabs, "  ")
end
