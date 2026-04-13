local M = {}
local sep = require("kuuga.statusline.components.sep")

---@enum ComponentNames
local component_names = {
	mode = "mode",
	filepath = "filepath",
	file = "file",
	git = "git",
	macro_recording = "macro_recording",
	search_count = "search_count",
	buffer_info = "buffer_info",
	line_info = "line_info",
	filetype = "filetype",
	scrollbar = "scrollbar",
	diagnostics = "diagnostics",
	lsp = "lsp",
}

---@type table<ComponentNames, fun(): string>
local components = {
	[component_names.mode] = require("kuuga.statusline.components.mode"),
	[component_names.filepath] = require("kuuga.statusline.components.filepath"),
	[component_names.file] = require("kuuga.statusline.components.file"),
	[component_names.git] = require("kuuga.statusline.components.git"),
	[component_names.macro_recording] = require("kuuga.statusline.components.macro_recording"),
	[component_names.search_count] = require("kuuga.statusline.components.search_count"),
	[component_names.buffer_info] = require("kuuga.statusline.components.buffer_info"),
	[component_names.line_info] = require("kuuga.statusline.components.line_info"),
	[component_names.filetype] = require("kuuga.statusline.components.filetype"),
	[component_names.scrollbar] = require("kuuga.statusline.components.scrollbar"),
	[component_names.diagnostics] = require("kuuga.statusline.components.diagnostics"),
	[component_names.lsp] = require("kuuga.statusline.components.lsp"),
}

---@param name ComponentNames
---@param sep_before boolean whether to add a separator before the component
function M.render(name, sep_before)
	if components[name] then
		local status = components[name]()
		if status ~= "" and sep_before then status = sep() .. status end
		return status
	else
		return ""
	end
end

return M
