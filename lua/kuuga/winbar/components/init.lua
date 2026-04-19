local Component = {}
local sep = require("kuuga.winbar.components.sep")

---@alias WinbarComponent
---| "filepath"
---| "file"
---| "lsp"
---| "search_count"
---| "copilot"
---| "grammar"
---@type table<WinbarComponent, fun(active: boolean): string>
local components = {
	filepath = require("kuuga.winbar.components.filepath"),
	file = require("kuuga.winbar.components.file"),
	lsp = require("kuuga.winbar.components.lsp"),
	search_count = require("kuuga.winbar.components.search_count"),
	copilot = require("kuuga.winbar.components.copilot"),
	grammar = require("kuuga.winbar.components.grammar"),
}

---@param name WinbarComponent
---@param active boolean
---@param sep_before boolean
function Component.render(name, active, sep_before)
	if components[name] then
		local comp = components[name](active)
		if sep_before and comp ~= "" then comp = sep() .. comp end
		return comp
	end
	return ""
end

return Component
