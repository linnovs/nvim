local components = { active = { {}, {}, {} }, inactive = { {}, {}, {} } }

local colors = require("nebula.plugin.statusline.colors")

require("feline").setup({
	colors = colors.default,
	components = components,
	vi_mode_colors = colors.vi_mode,
})
