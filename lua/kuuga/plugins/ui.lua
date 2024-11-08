return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		---@module "noice"
		---@type NoiceConfig
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				progress = {
					enabled = false,
				},
			},
			views = {
				mini = {
					win_options = {
						winblend = 0,
					},
				},
			},
			routes = {
				{
					filter = {
						event = "msg_show",
						any = {
							{ find = "%d+L, %d+B" },
							{ find = "; after #%d+" },
							{ find = "; before #%d+" },
						},
					},
					view = "notify",
				},
			},
			presets = {
				bottom_search = true,
				command_palette = true,
				long_message_to_split = true,
				inc_name = false,
				lsp_doc_border = true,
			},
		},
	},

	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "▏",
				tab_char = "▏",
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
					"dashboard",
				},
			},
		},
	},

	{
		"echasnovski/mini.indentscope",
		event = "BufReadPost",
		opts = function()
			local animation = require("mini.indentscope").gen_animation.none()

			return {
				symbol = "▏",
				options = { try_as_border = true },
				draw = {
					animation = animation,
				},
			}
		end,
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
					"man",
					"dashboard",
				},
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},

	-- beauty default UI
	{
		"stevearc/dressing.nvim",
		event = "BufReadPost",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = function()
			return {
				select = {
					telescope = require("telescope.themes").get_cursor(),
				},
			}
		end,
	},
}
