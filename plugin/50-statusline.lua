require("kuuga.winbar")
require("kuuga.statusline")

local timer = vim.uv.new_timer()
local refresh_interval = 16 -- Refresh every 16 milliseconds (approximately 60 FPS)
local scheduled_refresh = {} ---@type table<integer, vim.api.keyset.win_config>

if timer == nil then error("Failed to create timer") end
vim.uv.timer_start(
	timer,
	0,
	refresh_interval,
	vim.schedule_wrap(function()
		local refresh_needed = next(scheduled_refresh) ~= nil
		for winid, config in pairs(scheduled_refresh) do
			if config.relative == "" then WinBar.refresh(winid) end
			scheduled_refresh[winid] = nil
		end

		if refresh_needed then
		vim.cmd.redrawtabline()
			StatusLine.refresh()

			vim.cmd.redrawstatus()
			vim.cmd.redrawtabline()
		end
	end)
)

vim.api.nvim_create_autocmd({
	"VimEnter",
	"VimResized",
	"SessionLoadPost",
	"WinEnter",
	"WinLeave",
	"BufEnter",
	"BufLeave",
	"CursorMoved",
	"CursorMovedI",
	"CursorHold",
	"LspAttach",
	"LspDetach",
	"DiagnosticChanged",
	"ModeChanged",
}, {
	group = vim.api.nvim_create_augroup("KuugaStatusLineRefresh", { clear = true }),
	callback = function()
		local tabpage = vim.api.nvim_get_current_tabpage()
		local wins = vim.api.nvim_tabpage_list_wins(tabpage)

		for _, winid in ipairs(wins) do
			if scheduled_refresh[winid] == nil then scheduled_refresh[winid] = vim.api.nvim_win_get_config(winid) end
		end
	end,
})
