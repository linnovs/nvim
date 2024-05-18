return {
	"subnut/nvim-ghost.nvim",
	cmd = { "GhostTextStart" },
	init = function()
		vim.g.nvim_ghost_server_port = 4001
		vim.g.nvim_ghost_autostart = 0

		vim.api.nvim_create_autocmd("User", {
			group = vim.api.nvim_create_augroup("nvim_ghost_user_autocommands", { clear = false }),
			pattern = { "*github.com" },
			command = "setfiletype markdown",
		})
	end,
}
