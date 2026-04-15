StatusLine = {}

local components = require("kuuga.statusline.components")
local refresh_interval = 16 -- refresh every 16 milliseconds (60fps)

StatusLine.last_status = setmetatable({}, { __mode = "k" })
StatusLine.last_refresh_time = setmetatable({}, { __mode = "k" })

---@param winid integer
function StatusLine.refresh(winid)
	local last_refresh_time = StatusLine.last_refresh_time[winid] or 0
	if math.abs(last_refresh_time - vim.uv.now()) < refresh_interval then return end

	local macro_recording = components.render("macro_recording", false)

	StatusLine.last_status[winid] = table.concat({
		"%#StatusLineLogo#   ",
		components.render("mode", false),
		components.render("git", true),
		components.render("git_diff", true),
		components.render("diagnostics", true),
		"%=",
		macro_recording,
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

function StatusLine.setup() vim.opt_local.statusline = "%!v:lua.StatusLine.render()" end
