return {
	{
		"rcarriga/nvim-notify",
		priority = 1000,
		opts = { timeout = 3000, background_colour = "#00000000" },
		init = function()
			vim.notify = require("notify")
		end,
		config = function(_, opts)
			require("notify").setup(opts)
		end,
	},

	{
		"folke/noice.nvim",
		priority = 500,
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			views = {
				mini = {
					win_options = {
						winblend = 0,
					},
				},
			},
			-- routes = { { view = "notify", filter = { event = "msg_showmode" } } },
			presets = {
				bottom_search = false,
				command_palette = true,
				long_message_to_split = true,
				inc_name = false,
				lsp_doc_border = false,
			},
		},
	},

	{
		"utilyre/barbecue.nvim",
		event = "BufReadPre",
		name = "barbecue",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			attach_navic = false,
			theme = "catppucin",
		},
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{
				"<leader>zen",
				"<CMD>ZenMode<CR>",
				desc = "Zen Mode",
			},
		},
		opts = {},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPre",
		opts = {
			indent = {
				char = "┊",
				tab_char = "┊",
			},
			scope = { enabled = false },
			exclude = {
				filetypes = {
					"FTerm",
					"Trouble",
					"alpha",
					"help",
					"lazy",
					"mason",
					"neo-tree",
				},
			},
		},
	},

	-- dashboard
	{
		"glepnir/dashboard-nvim",
		event = "VimEnter",
		config = function()
			local dashboard = require("kuuga.config.dashboard")
			require("dashboard").setup(dashboard)
		end,
	},

	{
		"echasnovski/mini.indentscope",
		event = "BufReadPre",
		opts = {
			symbol = "┊",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = {
					"FTerm",
					"Trouble",
					"alpha",
					"help",
					"lazy",
					"mason",
					"neo-tree",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- beauty defaul UI
	{
		"stevearc/dressing.nvim",
		event = "BufReadPre",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			select = {
				telescope = require("telescope.themes").get_cursor(),
			},
		},
	},

	-- statusline
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = function()
			require("kuuga.config.statusline")
		end,
	},

	-- icons
	"nvim-tree/nvim-web-devicons",
}
