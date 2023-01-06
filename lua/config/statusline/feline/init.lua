local components = { active = { {}, {}, {} }, inactive = { {}, {}, {} } }

local function insert(position, component, inactive)
    local pos = { left = 1, mid = 2, right = 3 }
    local state = inactive and "inactive" or "active"
    table.insert(components[state][pos[position]], component)
end

local vi_mode = require("config.plugin.statusline.feline.vi_mode")
local git = require("config.plugin.statusline.feline.git")
local file = require("config.plugin.statusline.feline.file")
local lsp = require("config.plugin.statusline.feline.lsp")
local diagnostic = require("config.plugin.statusline.feline.diagnostic")
local gps = require("config.plugin.statusline.feline.gps")

insert("left", vi_mode)
insert("left", lsp.client_name)
insert("left", git.branch)
insert("left", git.added)
insert("left", git.modified)
insert("left", git.removed)
insert("left", git.right_sep)
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

local colors = require("config.plugin.statusline.feline.colors")

require("feline").setup({
    theme = colors.default,
    components = components,
    vi_mode_colors = colors.vi_mode,
})
