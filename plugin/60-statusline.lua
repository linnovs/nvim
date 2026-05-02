local tabline = require("kuuga.tabline")
local winbar = require("kuuga.winbar")
local statusline = require("kuuga.statusline")

local timer = vim.uv.new_timer()
local refresh_interval = 50 -- Refresh at most 50 milliseconds
local scheduled_refresh = {} ---@type table<integer, vim.api.keyset.win_config>

vim.o.tabline = "%!v:lua.require'kuuga.tabline'.render()"
vim.o.statusline = "%!v:lua.require'kuuga.statusline'.render()"

if timer == nil then error("Failed to create timer") end
vim.uv.timer_start(
	timer,
	0,
	refresh_interval,
	vim.schedule_wrap(function()
		local refresh_needed = next(scheduled_refresh) ~= nil
		for winid, config in pairs(scheduled_refresh) do
			if vim.api.nvim_win_is_valid(winid) then
				vim.api.nvim_win_call(winid, function()
					if config.relative ~= "" then return end
					tabline.refresh()
					winbar.refresh()
					statusline.refresh()
				end)
			end
			scheduled_refresh[winid] = nil
		end

		if refresh_needed then
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
	"BufWritePost",
	"FileType",
	"CursorMoved",
	"CursorMovedI",
	"CursorHold",
	"LspAttach",
	"LspDetach",
	"RecordingEnter",
	"RecordingLeave",
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
