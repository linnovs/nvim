---@module 'snacks'
---@type snacks.dashboard.Config
local M = {
	enabled = true,
	sections = {},
	formats = {},
	width = 75,
	row = nil,
	col = nil,
	pane_gap = 4,
	autokeys = nil,
	preset = {},
	debug = false,
}

M.preset.keys = {
	{ icon = " ", key = "b", desc = "Browse Repository", action = ":lua Snacks.gitbrowse()" },
	{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
	{ icon = "󰝒 ", key = "N", desc = "New File", action = ":ene" },
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
	function()
		local in_git = Snacks.git.get_root() ~= nil
		local cmds = {
			{
				title = "Notifications",
				cmd = "gh notify -s -a -n5",
				action = function() vim.ui.open("https://github.com/notifications") end,
				key = "n",
				icon = " ",
				height = 5,
				enabled = true,
			},
			{
				icon = " ",
				title = "Open PRs",
				cmd = "gh pr list -L 3",
				key = "P",
				action = function() vim.fn.jobstart("gh pr list --web", { detach = true }) end,
				height = 7,
			},
			{
				icon = "󰊢 ",
				title = "Git Status",
				cmd = "git status --short --branch --renames",
				height = 5,
			},
		}

		return vim.tbl_map(
			function(cmd)
				return vim.tbl_extend("force", {
					section = "terminal",
					enabled = in_git,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				}, cmd)
			end,
			cmds
		)
	end,
	{ section = "startup", padding = 1 },
}

return M
