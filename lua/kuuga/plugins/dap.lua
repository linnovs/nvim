return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		keys = {
			{
				"<F5>",
				function()
					require("dap").continue()
				end,
				desc = "Start/Continue DAP",
			},
			{
				"<F10>",
				function()
					require("dap").step_over()
				end,
				desc = "Step over DAP",
			},
			{
				"<F11>",
				function()
					require("dap").step_into()
				end,
				desc = "Step into DAP",
			},
			{
				"<F12>",
				function()
					require("dap").step_out()
				end,
				desc = "Step out DAP",
			},
			{
				"<leader>dtb",
				function()
					require("dap").toggle_breakpoint()
				end,
				desc = "Toggle breakpoint DAP",
			},
			{
				"<leader>dl",
				function()
					require("dap").run_last()
				end,
				desc = "Run last DAP",
			},
		},
		config = function()
			vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
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

	{
		"leoluz/nvim-dap-go",
		version = false,
		lazy = true,
		ft = { "go" },
		dependencies = { "mfussenegger/nvim-dap" },
		opts = {},
	},
}
