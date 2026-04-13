Statusline = {}

local components = require("kuuga.statusline.components")
local refresh_interval = 16 -- refresh every 16 milliseconds (60fps)

Statusline.last_status = {} ---@type table<integer, string>
Statusline.last_refresh_time = {} ---@type table<integer, integer>

---@param winid integer
---@param last_refresh_time integer
function Statusline.refresh(winid, last_refresh_time)
	if math.abs(last_refresh_time - vim.uv.now()) < refresh_interval then return end

	local macro_recording = components.render("macro_recording", false)
	local search_count = components.render("search_count", macro_recording ~= "")

	Statusline.last_status[winid] = table.concat({
		"%#StatuslineNormal#   ",
		components.render("mode", false),
		components.render("git", true),
		components.render("filepath", true),
		components.render("file", true),
		components.render("diagnostics", true),
		"%=",
		macro_recording,
		search_count,
		"%=",
		components.render("lsp", true),
		components.render("buffer_info", true),
		components.render("line_info", true),
		components.render("filetype", true),
		components.render("scrollbar", true),
		"%* ",
	})
	Statusline.last_refresh_time[winid] = vim.uv.now()
end

function Statusline.render()
	local winid = vim.g.statusline_winid
	local last_refresh_time = Statusline.last_refresh_time[winid] or 0

	if last_refresh_time and math.abs(last_refresh_time - vim.uv.now()) >= refresh_interval then
		Statusline.refresh(winid, last_refresh_time)
	end

	return Statusline.last_status[winid] or "%#StatuslineNormal#   Loading ...%*"
end
