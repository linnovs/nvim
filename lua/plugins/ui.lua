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
			require("alpha").setup(dashboard.opts)

			vim.api.nvim_create_autocmd("VimEnter", {
				group = vim.api.nvim_create_augroup("kuuga_dashboard", { clear = true }),
				pattern = "*",
				callback = function()
					local argv = vim.api.nvim_call_function("argv", {})
					if #argv == 0 then
						return
					end

					local is_dir = vim.api.nvim_call_function("isdirectory", { argv[1] })
					if is_dir == 1 then
						vim.cmd.chdir(argv[1])
						vim.cmd.Alpha()
					end
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

	-- status column
	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")

			require("statuscol").setup({
				segments = {
					{
						sign = { name = { "Git" }, maxwidth = 1, colwidth = 1 },
						click = "v:lua.ScSa",
					},
					{
						sign = { name = { "Diagnostic" }, maxwidth = 1 },
						click = "v:lua.ScSa",
					},
					{
						text = { builtin.lnumfunc, " " },
						click = "v:lua:ScLa",
					},
					{ text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
				},
			})
		end,
	},

	-- icons
	"nvim-tree/nvim-web-devicons",
}
