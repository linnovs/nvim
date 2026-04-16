StatusLine = {}

local components = require("kuuga.statusline.components")
local refresh_interval = 16 -- refresh every 16 milliseconds (60fps)
local timer = vim.uv.new_timer()

StatusLine.last_status = setmetatable({}, { __mode = "k" })
StatusLine.last_refresh_time = setmetatable({}, { __mode = "k" })

---@param winid integer
function StatusLine.refresh(winid)
	local last_refresh_time = StatusLine.last_refresh_time[winid] or 0
	if math.abs(last_refresh_time - vim.uv.now()) < refresh_interval then return end

	local macro_recording = components.render(winid, "macro_recording", false)

	StatusLine.last_status[winid] = table.concat({
		"%#StatusLineLogo#   ",
		components.render(winid, "mode", false),
		components.render(winid, "git", true),
		components.render(winid, "git_diff", true),
		components.render(winid, "diagnostics", true),
		"%=",
		macro_recording,
		"%=",
		components.render(winid, "buffer_info", true),
		components.render(winid, "line_info", true),
		components.render(winid, "filetype", true),
		components.render(winid, "scrollbar", true),
		"%* ",
	})
	StatusLine.last_refresh_time[winid] = vim.uv.now()
end

function StatusLine.render()
	local winid = vim.api.nvim_get_current_win()
	StatusLine.refresh(winid)
	return StatusLine.last_status[winid] or "%#StatusLineLogo#   Loading ...%*"
end

function StatusLine.setup()
	vim.opt.statusline = "%!v:lua.StatusLine.render()"
	if not timer then return end
	vim.uv.timer_start(
		timer,
		0,
		refresh_interval,
		vim.schedule_wrap(function()
			local winid = vim.api.nvim_get_current_win()
			StatusLine.refresh(winid)
			vim.cmd.redrawstatus()
		end)
	)
end
