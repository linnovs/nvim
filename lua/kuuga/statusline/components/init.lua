local Component = {}
local sep = require("kuuga.statusline.components.sep")

---@alias ComponentNames
---| "mode"
---| "filepath"
---| "file"
---| "git"
---| "macro_recording"
---| "search_count"
---| "buffer_info"
---| "line_info"
---| "filetype"
---| "scrollbar"
---| "diagnostics"
---| "lsp"
---@type table<ComponentNames, fun(): string>
local components = {
	mode = require("kuuga.statusline.components.mode"),
	filepath = require("kuuga.statusline.components.filepath"),
	file = require("kuuga.statusline.components.file"),
	git = require("kuuga.statusline.components.git"),
	macro_recording = require("kuuga.statusline.components.macro_recording"),
	search_count = require("kuuga.statusline.components.search_count"),
	buffer_info = require("kuuga.statusline.components.buffer_info"),
	line_info = require("kuuga.statusline.components.line_info"),
	filetype = require("kuuga.statusline.components.filetype"),
	scrollbar = require("kuuga.statusline.components.scrollbar"),
	diagnostics = require("kuuga.statusline.components.diagnostics"),
	lsp = require("kuuga.statusline.components.lsp"),
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
