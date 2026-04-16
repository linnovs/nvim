local file_lib = require("kuuga.lib.file")

local function modified_symbol(bufnr) return vim.bo[bufnr].modified and "%#TabLineWindowModified# " or nil end

local function readonly_symbol(bufnr) return vim.bo[bufnr].readonly and "%#TabLineWindowReadonly# " or nil end

vim.api.nvim_exec2(
	[[
function! KuugaTabLineSwitchWindow(win_id, clicks, button, mod)
	call win_gotoid(a:win_id)
endfunction

function! KuugaTabLineCloseWindow(win_id, clicks, button, mod)
	call win_execute(a:win_id, "close")
endfunction
]],
	{}
)

---@param winid integer
---@param text_hl string
---@param window string
local function wrap_click_func(winid, text_hl, window)
	local win_func = "%" .. winid .. "@KuugaTabLineSwitchWindow@"
	local close_button = "%" .. winid .. "@KuugaTabLineCloseWindow@" .. text_hl .. "%X"
	return win_func .. window .. "%X " .. close_button
end

---@param winid integer
---@param current_tab integer
local function get_window(winid, current_tab)
	local win_tab = vim.api.nvim_win_get_tabpage(winid)
	if current_tab ~= win_tab then return end

	local config = vim.api.nvim_win_get_config(winid)
	if config.relative ~= "" then return end

	local focused = winid == vim.api.nvim_get_current_win()
	local text_hl = focused and "%#TabLineWindowActive#" or "%#TabLineWindowInactive#"
	local winnr = vim.api.nvim_win_get_number(winid)
	local bufnr = vim.api.nvim_win_get_buf(winid)
	local filename = file_lib.get_filename(bufnr)
	local icon, hl = file_lib.get_file_icon(filename)

	local index_hl = focused and "%#TabLineWindowIndex#" or "%#TabLineWindowInactive#"
	local win_index = index_hl .. winnr .. text_hl .. ": "
	local file_icon = (hl and "%$" .. hl .. "$" or "") .. icon .. " "
	local file_window = file_icon .. text_hl .. filename
	local symbol = readonly_symbol(bufnr) or modified_symbol(bufnr) or "  "

	local window = table.concat({ win_index, file_window, symbol })

	return wrap_click_func(winid, text_hl, window)
end

return function()
	local current_tab = vim.api.nvim_get_current_tabpage()
	local window_ids = vim.api.nvim_list_wins()
	local windows = {}

	for _, winid in ipairs(window_ids) do
		local window = get_window(winid, current_tab)
		if window then table.insert(windows, window) end
	end

	return table.concat(windows, "  ")
end
