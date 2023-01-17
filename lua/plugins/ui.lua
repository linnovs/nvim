local icons = require("kuuga.icons").kinds

return {
	{
		"rcarriga/nvim-notify",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = { timeout = 3000 },
		init = function()
			vim.notify = require("notify")
		end,
		config = function(_, opts)
			require("notify").setup(opts)

			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyVimStarted",
				callback = function()
					local stats = require("lazy").stats()
					local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
					vim.notify("⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms", "info")
				end,
			})
		end,
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		opts = {
			char = "┊",
			context_char = "┊",
			buftype_exclude = { "terminal", "help" },
			filetype_exclude = { "lsp-installer", "alpha", "packer", "lazy" },
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = true,
		},
	},

	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		config = function()
			local dashboard = require("kuuga.config.dashboard")
			if vim.o.filetype == "lazy" then
				vim.cmd.close()
				vim.api.nvim_create_autocmd("User", {
					pattern = "AlphaReady",
					callback = function()
						require("lazy").show()
					end,
				})
			end

			require("alpha").setup(dashboard.opts)
		end,
	},

	-- beauty defaul UI
	{

		"stevearc/dressing.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = {
			select = {
				telescope = require("telescope.themes").get_dropdown({}),
			},
		},
	},

	-- bufferline
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		opts = {
			options = {
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
						text_align = "left",
					},
				},
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

	-- code context
	{
		"SmiteshP/nvim-navic",
		lazy = true,
		opts = {
			icons = icons,
			highlight = true,
		},
	},

	-- icons
	"nvim-tree/nvim-web-devicons",

	"MunifTanjim/nui.nvim",
}
