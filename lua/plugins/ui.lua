return {
	{
		"rcarriga/nvim-notify",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		priority = 1000,
		opts = { timeout = 3000, background_colour = "#00000000" },
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
		event = "VeryLazy",
		name = "barbecue",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			attach_navic = false,
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		opts = {
			char = "┊",
			context_char = "┊",
			buftype_exclude = { "terminal", "help" },
			filetype_exclude = { "mason", "lsp-installer", "alpha", "packer", "lazy" },
			space_char_blankline = " ",
			show_current_context = true,
			show_current_context_start = true,
		},
	},

	-- dashboard
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

	-- status column
	{
		"luukvbaal/statuscol.nvim",
		opts = function()
			local builtin = require("statuscol.builtin")

			return {
				ft_ignore = { "alpha", "lazy", "neo-tree" },
				segments = {
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
					{
						sign = { name = { "Diagnostic" }, maxwidth = 2 },
						click = "v:lua.ScSa",
					},
					{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
					{
						sign = { name = { ".*" }, maxwidth = 2, colwidth = 1 },
						click = "v:lua.ScSa",
					},
				},
			}
		end,
	},

	-- icons
	"nvim-tree/nvim-web-devicons",

	"MunifTanjim/nui.nvim",
}
