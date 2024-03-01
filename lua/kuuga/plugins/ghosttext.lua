return {
	"subnut/nvim-ghost.nvim",
	cmd = { "GhostTextStart" },
	init = function()
		vim.g.nvim_ghost_server_port = 4001
		vim.g.nvim_ghost_autostart = 0
	end,
}
