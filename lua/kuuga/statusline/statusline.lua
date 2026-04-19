StatusLine = {}

local components = require("kuuga.statusline.components")

StatusLine.last_status = setmetatable({}, { __mode = "k" })

function StatusLine.refresh()
	local winid = vim.api.nvim_get_current_win()
	StatusLine.last_status[winid] = table.concat({
		"%#StatusLineLogo#   ",
		components.render("mode", false),
		components.render("git", true),
		components.render("git_diff", true),
		components.render("diagnostics", true),
		"%=",
		components.render("macro_recording", false),
		"%=",
		components.render("buffer_info", true),
		components.render("line_info", true),
		components.render("filetype", true),
		components.render("scrollbar", true),
		"%* ",
	})
end

function StatusLine.render()
	local winid = vim.api.nvim_get_current_win()
	return StatusLine.last_status[winid] or "%#StatusLineLogo#   Loading ...%*"
end
