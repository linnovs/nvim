---@type snacks.dashboard.Config
local DashboardConfig = {
	enabled = true,
	sections = {},
	formats = {},
	width = 52,
	row = nil,
	col = nil,
	pane_gap = 4,
	autokeys = nil,
	preset = {},
	debug = false,
}

DashboardConfig.preset.keys = {
	{ icon = " ", key = "b", desc = "Browse Repository", action = ":lua Snacks.gitbrowse()" },
	{ icon = "󰝒 ", key = "N", desc = "New File", action = ":ene | startinsert" },
	{
		icon = " ",
		key = "s",
		desc = "Restore Session",
		action = ':lua require("persistence").load()',
		enabled = function() return package.loaded.persistence ~= nil end,
	},
	{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
}

DashboardConfig.sections[1] = {
	{
		text = {
			{
				[[
⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠆⠀⠀
⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⣿⠁⠀⠀
⣿⣿⣿⣷⣶⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣤⣤⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣠⣴⣾⣿⣿⣿⠁⠀⠀
⣿⣿⣿⣿⣿⣿⣿⣿⣷⣦⣄⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⠁⠀⠀
⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⠀⠀⠀⠀⢀⣀⣤⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠃⠀⠀
⠀⠀⠀⠉⠙⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣀⡀⠀⠀⣿⣿⡇⠀⠀⣀⣤⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠉⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠈⠉⠛⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣿⣿⣿⡇⠀⠀⣿⣿⡇⠀⢸⣿⣿⣿⣿⣿⡿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣿⡆⠀⠀⠀⠀⠀⠀⠀⠉⠛⣿⣿⡇⠀⠀⣿⣿⡇⠀⢸⣿⣿⠛⠋⠁⠀⠀⠀⠀⠀⠀⢰⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⡇⠀⠀⣿⣿⡇⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⡇⠀⠀⣿⣿⡇⠀⢸⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⣀⣿⣿⡇⠀⠀⣿⣿⡇⠀⢸⣿⣿⣀⡀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣿⡇⠀⠀⢀⣀⣤⣴⣾⣿⣿⣿⣿⡇⠀⠀⣿⣿⡇⠀⢸⣿⣿⣿⣿⣷⣶⣤⣄⡀⠀⠀⢸⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣿⣧⣶⣾⣿⣿⣿⣿⣿⡿⠿⠛⢉⣁⣤⣶⣿⣿⣷⣦⣄⡉⠛⠻⢿⣿⣿⣿⣿⣿⣿⣶⣼⣿⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠙⠿⣿⣿⣿⠿⠛⠋⣁⣤⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣤⣀⡉⠛⠿⢿⣿⣿⡿⠛⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠁⠀⢠⣶⣿⣿⣿⣿⣿⣿⠿⠛⠉⠀⠀⠉⠛⠻⢿⣿⣿⣿⣿⣿⣷⣦⠀⠈⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⡿⠟⠛⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡏⠁⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⢹⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⢸⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣧⣀⡀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⠀⣿⡇⠀⠀⠀⠀⣀⣼⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠛⠿⣿⣷⣦⣄⡀⣿⡇⠀⠀⠀⠀⠀⣿⡇⣀⣤⣶⣿⡿⠟⠉⠀⣤⣦⣤⣤⣆⠀⠀⠀⠀⠀⢀⣀⠀⣀⢀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⠻⢿⣿⣿⡇⠀⠀⠀⠀⠀⣿⣿⣿⠿⠛⠁⠀⠀⣠⣾⠟⢩⣿⢟⣵⠼⣯⡧⠶⣶⡿⢷⣶⠍⠉
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠛⠇⠀⠀⠀⠀⠀⠟⠋⠀⠀⠀⠀⠀⠀⢉⣀⣴⡿⠋⢋⣁⣴⠟⠥⠾⣋⣴⡿⠃⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣠⣤⣴⡶⠾⠿⠿⠟⠋⠀⠉⠉⠀⠠⠤⠒⠛⠋⠉⠁⠀⠀⠀
]],
				hl = "SnacksDashboardHeader",
			},
		},
	},
}

DashboardConfig.sections[2] = {
	pane = 2,
	{ section = "keys", gap = 0, padding = 1 },
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
				indent = 3,
			},
			{
				icon = "󰊢 ",
				title = "Git Status",
				cmd = "git status --short --branch --renames",
				height = 5,
				indent = 3,
			},
		}

		return vim.tbl_map(
			function(cmd)
				return vim.tbl_extend("force", {
					section = "terminal",
					enabled = in_git,
					padding = 1,
					ttl = 5 * 60,
				}, cmd)
			end,
			cmds
		)
	end,
}

return DashboardConfig
