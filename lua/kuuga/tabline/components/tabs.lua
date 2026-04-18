local file_lib = require("kuuga.lib.file")

vim.api.nvim_exec2(
	[[
function! KuugaTabLineSwitchTab(tabid, clicks, button, mod)
	execute a:tabid .. "tabnext"
endfunction
]],
	{}
)

local window_count_icons = {
	[0] = "󰎡 ",
	[1] = "󰎤 ",
	[2] = "󰼐 ",
	[3] = "󰼑 ",
	[4] = "󰼒 ",
	[5] = "󰼓 ",
	[6] = "󰼔 ",
	[7] = "󰼕 ",
	[8] = "󰼖 ",
	[9] = "󰼗 ",
	[10] = "󰿪 ",
	above10 = "󰼘 ",
}

---@param tabid integer
---@param focused boolean
local function get_window_count(tabid, focused)
	local wins = vim.api.nvim_tabpage_list_wins(tabid)
	local window_count = 0

	for _, winid in ipairs(wins) do
		local config = vim.api.nvim_win_get_config(winid)
		if config.relative == "" then window_count = window_count + 1 end
	end

	return table.concat({
		focused and "%#TabLineTabWindowCount# " or "%#TabLineTabInactive# ",
		window_count_icons[window_count] or window_count_icons.above10,
	})
end

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
	local window_count = get_window_count(tabid, focused) .. " "

	local tabpage = table.concat({ tab_icon, tab_filename, window_count, tab_number })

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
