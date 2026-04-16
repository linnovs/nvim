local Component = {}
local sep = require("kuuga.tabline.components.sep")

---@alias TabLineComponent
---| "windows"
---| "tabs"
---| "tab_close"
---@type table<TabLineComponent, fun(): string>
local components = {
	windows = require("kuuga.tabline.components.windows"),
	tabs = require("kuuga.tabline.components.tabs"),
	tab_close = require("kuuga.tabline.components.tab_close"),
}

---@param name TabLineComponent
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
