local Component = {}
local sep = require("kuuga.statusline.components.sep")

require("kuuga.statusline.components.git_lib").setup()

---@alias StatusLineComponent
---| "mode"
---| "git"
---| "git_diff"
---| "macro_recording"
---| "buffer_info"
---| "line_info"
---| "filetype"
---| "scrollbar"
---| "diagnostics"
---@type table<StatusLineComponent, fun(): string>
local components = {
	mode = require("kuuga.statusline.components.mode"),
	git = require("kuuga.statusline.components.git"),
	git_diff = require("kuuga.statusline.components.git_diff"),
	macro_recording = require("kuuga.statusline.components.macro_recording"),
	buffer_info = require("kuuga.statusline.components.buffer_info"),
	line_info = require("kuuga.statusline.components.line_info"),
	filetype = require("kuuga.statusline.components.filetype"),
	scrollbar = require("kuuga.statusline.components.scrollbar"),
	diagnostics = require("kuuga.statusline.components.diagnostics"),
}

---@param name StatusLineComponent
---@param sep_before boolean whether to add a separator before the component
function Component.render(name, sep_before)
	if components[name] then
		local status = components[name]()
		if status ~= "" and sep_before then status = sep() .. status end
		return status
	end
	return ""
end

return Component
