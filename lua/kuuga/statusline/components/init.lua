local Component = {}
local sep = require("kuuga.statusline.components.sep")

---@alias ComponentNames
---| "mode"
---| "git"
---| "macro_recording"
---| "buffer_info"
---| "line_info"
---| "filetype"
---| "scrollbar"
---| "diagnostics"
---@type table<ComponentNames, fun(): string>
local components = {
	mode = require("kuuga.statusline.components.mode"),
	git = require("kuuga.statusline.components.git"),
	macro_recording = require("kuuga.statusline.components.macro_recording"),
	buffer_info = require("kuuga.statusline.components.buffer_info"),
	line_info = require("kuuga.statusline.components.line_info"),
	filetype = require("kuuga.statusline.components.filetype"),
	scrollbar = require("kuuga.statusline.components.scrollbar"),
	diagnostics = require("kuuga.statusline.components.diagnostics"),
}

---@param name ComponentNames
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
