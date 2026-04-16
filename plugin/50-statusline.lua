require("kuuga.winbar")
require("kuuga.statusline")

local timer = vim.uv.new_timer()
local refresh_interval = 16 -- Refresh every 16 milliseconds (approximately 60 FPS)

if timer == nil then error("Failed to create timer") end
vim.uv.timer_start(
	timer,
	0,
	refresh_interval,
	vim.schedule_wrap(function()
		WinBar.refresh(vim.api.nvim_get_current_win())
		TabLine.refresh()
		StatusLine.refresh()

		vim.cmd.redrawstatus()
		vim.cmd.redrawtabline()
	end)
)
