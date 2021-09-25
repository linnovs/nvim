local components = { active = { {}, {}, {} }, inactive = { {}, {}, {} } }

local function insert(position, component, inactive)
	local pos = { left = 1, mid = 2, right = 3 }
	local state = inactive and "inactive" or "active"
	table.insert(components[state][pos[position]], component)
end

local vi_mode = require("nebula.plugin.statusline.vi_mode")
local git = require("nebula.plugin.statusline.git")
local file = require("nebula.plugin.statusline.file")
local lsp = require("nebula.plugin.statusline.lsp")
local diagnostic = require("nebula.plugin.statusline.diagnostic")
local gps = require("nebula.plugin.statusline.gps")

insert("left", vi_mode)
insert("left", lsp.client_name)
insert("left", git.branch)
insert("left", git.added)
insert("left", git.modified)
insert("left", git.removed)
insert("left", file.info)
insert("mid", gps)
insert("right", file.encoding)
insert("right", file.format)
insert("right", file.type)
insert("right", diagnostic.errors)
insert("right", diagnostic.warnings)
insert("right", diagnostic.hints)
insert("right", diagnostic.info)
insert("right", file.position)

insert("left", file.file_info, true)
insert("right", file.position_inactive, true)

local colors = require("nebula.plugin.statusline.colors")

require("feline").setup({
	colors = colors.default,
	components = components,
	vi_mode_colors = colors.vi_mode,
})
