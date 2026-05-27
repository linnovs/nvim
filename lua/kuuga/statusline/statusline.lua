local M = {}

local components = require("kuuga.statusline.components")

M.last_status = setmetatable({}, { __mode = "k" })

function M.refresh()
	local winid = vim.api.nvim_get_current_win()
	M.last_status[winid] = table.concat({
		"%#StatusLineLogo#   ",
		components.render("mode", false),
		components.render("git", true),
		components.render("git_diff", true),
		components.render("diagnostics", true),
		"%=",
		components.render("macro_recording", false),
		"%=",
		components.render("wakatime", true),
		components.render("buffer_info", true),
		components.render("line_info", true),
		components.render("filetype", true),
		components.render("scrollbar", true),
		"%* ",
	})
	return M.last_status[winid]
end

function M.render()
	local winid = vim.api.nvim_get_current_win()
	return M.last_status[winid] or M.refresh()
end

return M
