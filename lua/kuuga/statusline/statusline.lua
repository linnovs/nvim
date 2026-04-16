StatusLine = {}

local components = require("kuuga.statusline.components")

StatusLine.last_status = setmetatable({}, { __mode = "k" })

function StatusLine.refresh()
	local winid = vim.api.nvim_get_current_win()
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
end

function StatusLine.render()
	local winid = vim.api.nvim_get_current_win()
	return StatusLine.last_status[winid] or "%#StatusLineLogo#   Loading ...%*"
end
