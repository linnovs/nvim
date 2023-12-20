return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		keys = {
			{
				"<leader>dap",
				"<cmd>lua require('dapui').toggle()<cr>",
				desc = "Toggle DAP UI",
			},
		},
		config = function()
			require("dapui").setup()
		end,
	},
}
