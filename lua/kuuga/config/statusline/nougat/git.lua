local sep = require("nougat.separator")
local nut_git_branch = require("nougat.nut.git.branch")
local nut_git_status = require("nougat.nut.git.status")
local color = require("catppuccin.palettes").get_palette("macchiato") or {}

local branch = function(opts)
	opts = vim.tbl_extend("force", {
		hl = { bg = color.overlay0, fg = "#ff9e64", bold = true },
		prefix = "  ",
		suffix = " ",
	}, opts or {})

	return nut_git_branch.create(opts)
end

local status = function(opts)
	opts = vim.tbl_extend("force", {
		hl = { bg = color.overlay0, bold = true },
		content = {
			nut_git_status.count("added", {
				hl = { bg = color.green, fg = color.surface1 },
				prefix = "  ",
				suffix = " ",
				sep_left = sep.left_lower_triangle_solid(true),
			}),
			nut_git_status.count("changed", {
				hl = { bg = color.blue, fg = color.surface1 },
				prefix = "  ",
				suffix = " ",
				sep_left = sep.left_lower_triangle_solid(true),
			}),
			nut_git_status.count("removed", {
				hl = { bg = color.red, fg = color.surface1 },
				prefix = "  ",
				suffix = " ",
				sep_left = sep.left_lower_triangle_solid(true),
			}),
		},
	}, opts or {})

	return nut_git_status.create(opts)
end

return {
	branch = branch,
	status = status,
}
