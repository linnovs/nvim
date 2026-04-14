StatusLine = {}

local components = require("kuuga.statusline.components")
local refresh_interval = 16 -- refresh every 16 milliseconds (60fps)

StatusLine.last_status = {} ---@type table<integer, string>
StatusLine.last_refresh_time = {} ---@type table<integer, integer>

---@param winid integer
function StatusLine.refresh(winid)
	local last_refresh_time = StatusLine.last_refresh_time[winid] or 0
	if math.abs(last_refresh_time - vim.uv.now()) < refresh_interval then return end

	local macro_recording = components.render("macro_recording", false)
	local search_count = components.render("search_count", macro_recording ~= "")

	StatusLine.last_status[winid] = table.concat({
		"%#StatusLineLogo#   ",
		components.render("mode", false),
		components.render("git", true),
		components.render("diagnostics", true),
		"%=",
		macro_recording,
		search_count,
		"%=",
		components.render("buffer_info", true),
		components.render("line_info", true),
		components.render("filetype", true),
		components.render("scrollbar", true),
		"%* ",
	})
	StatusLine.last_refresh_time[winid] = vim.uv.now()
end

function StatusLine.render()
	local winid = vim.g.statusline_winid
	StatusLine.refresh(winid)
	return StatusLine.last_status[winid] or "%#StatusLineLogo#   Loading ...%*"
end
