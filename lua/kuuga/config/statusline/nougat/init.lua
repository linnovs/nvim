local Bar = require("nougat.bar")
local bar_util = require("nougat.bar.util")
local sep = require("nougat.separator")
local spacer = require("nougat.nut.spacer").create
local truncation_point = require("nougat.nut.truncation_point").create
local color = require("catppuccin.palettes").get_palette("macchiato") or {}

local mode = require("kuuga.config.statusline.nougat.mode")
local lsp_server = require("kuuga.config.statusline.nougat.lsp_server")
local git = require("kuuga.config.statusline.nougat.git")
local file = require("kuuga.config.statusline.nougat.file")
local lazy = require("kuuga.config.statusline.nougat.lazy")
local diagnostic = require("kuuga.config.statusline.nougat.diagnostic")
local ruler = require("kuuga.config.statusline.nougat.ruler")
local percentage = require("kuuga.config.statusline.nougat.percentage")

local stl = Bar("statusline")
stl:add_item(mode())
stl:add_item(lsp_server())
stl:add_item(git.branch())
stl:add_item(git.status())
stl:add_item(file.name_with_icon({
	sep_left = sep.right_chevron_solid(true),
}))
stl:add_item(file.status())
stl:add_item(spacer())
stl:add_item(truncation_point())
stl:add_item(lazy())
stl:add_item(sep.space())
stl:add_item(file.format({
	hl = { bg = color.surface1 },
	prefix = " ",
	sep_left = sep.left_lower_triangle_solid(true),
}))
stl:add_item(file.encoding({
	hl = { bg = color.surface1 },
	prefix = " ",
	sep_right = sep.right_lower_triangle_solid(true),
	suffix = " ",
}))
stl:add_item(file.type({
	hl = { bg = color.surface0 },
	sep_right = sep.right_upper_triangle_solid(true),
}))
stl:add_item(diagnostic(vim.diagnostic.severity.ERROR))
stl:add_item(diagnostic(vim.diagnostic.severity.WARN))
stl:add_item(diagnostic(vim.diagnostic.severity.INFO))
stl:add_item(diagnostic(vim.diagnostic.severity.HINT))
stl:add_item(ruler())
stl:add_item(percentage({ sep_left = sep.left_chevron_solid(true) }))

local inactive_stl = Bar("statusline")
inactive_stl:add_item(mode())
inactive_stl:add_item(file.name_with_icon({
	sep_left = sep.right_chevron_solid(true),
}))
inactive_stl:add_item(file.status())
inactive_stl:add_item(spacer())
inactive_stl:add_item(file.format({ prefix = " " }))
inactive_stl:add_item(file.encoding({ prefix = " ", suffix = " " }))

bar_util.set_statusline(function(ctx)
	return ctx.is_focused and stl or inactive_stl
end)
