local components = { active = { {}, {}, {} }, inactive = { {}, {}, {} } }

local function insert(position, component, inactive)
	local pos = { left = 1, mid = 2, right = 3 }
	local state = inactive and "inactive" or "active"
	table.insert(components[state][pos[position]], component)
end

local vi_mode = require("nebula.plugin.statusline.vi_mode")
insert("left", vi_mode)

local colors = require("nebula.plugin.statusline.colors")

require("feline").setup({
	colors = colors.default,
	components = components,
	vi_mode_colors = colors.vi_mode,
})
