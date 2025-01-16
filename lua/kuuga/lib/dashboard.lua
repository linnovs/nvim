---@module 'snacks'
---@type snacks.dashboard.Config
local M = { enabled = true, sections = {}, formats = {} }

M.width = 75
M.row = nil
M.col = nil
M.pane_gap = 4

M.preset = {}
M.preset.keys = {
	{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
	{ icon = "󰝒 ", key = "n", desc = "New File", action = ":ene" },
	{ icon = "󰈞 ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
	{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
	{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
	{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
}

M.sections[1] = {
	section = "terminal",
	cmd = "chafa ~/.config/nvim/dashboard.png --format symbols --stretch --size 40x20 --align center,center; sleep .1",
	height = 20,
	padding = 2,
}

M.sections[2] = {
	pane = 2,
	{ section = "keys", gap = 1, padding = 1 },
	{
		section = "terminal",
		enabled = function() return Snacks.git.get_root() ~= nil end,
		icon = "󰊢 ",
		title = "Git Status",
		cmd = "git status --short --branch --renames",
		ttl = 5 * 60,
		height = 5,
		padding = 1,
		indent = 3,
	},
	{ section = "startup", padding = 1 },
}

return M
